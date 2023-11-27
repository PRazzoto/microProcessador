library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel is
    port(clk      : in  std_logic;
         rst      : in  std_logic;
         saida_ula: out unsigned(17 downto 0)
        );
end entity;

architecture a_toplevel of toplevel is
    component banco_regs is
      port(clk      : in std_logic;
           wr_en    : in  std_logic;
           rst      : in  std_logic;
           rs1      : in  unsigned (2 downto 0);
           rs2      : in  unsigned (2 downto 0);
           rd       : in  unsigned (2 downto 0);
           data_in  : in  unsigned(17 downto 0);
           data_out_A: out unsigned(17 downto 0);
           data_out_B: out unsigned(17 downto 0)
      );
    end component;

    component mux is
      port(in_a : in unsigned (17 downto 0);
           in_b : in unsigned (17 downto 0);
           ctrl : in std_logic;
           a_ou_b : out unsigned (17 downto 0)
      );
    end component;

    component ula is
      port( in_a : in unsigned(17 downto 0);
            in_b : in unsigned(17 downto 0);
            selec_op : in unsigned(1 downto 0);
            result : out unsigned(17 downto 0);
            pino_extra: out unsigned(17 downto 0)
      );
    end component;

    component rom is
      port( clk      : in std_logic;
            endereco : in unsigned(6 downto 0);
            dado     : out unsigned(17 downto 0) 
      );
    end component;

    component pc_n_soma is
      port(clk      : in std_logic;
           rst      : in std_logic;
           wr_en    : in std_logic;
           data_in  : in unsigned(6 downto 0);
           data_out_rom : out unsigned(6 downto 0);
           data_out_somado: out unsigned(6 downto 0)   
      );
    end component;

    component st_mach is
      port(clk      : in  std_logic;
           rst      : in  std_logic;
           estado   : out std_logic
      );
    end component;

    component uc is
      port(instr   : in  unsigned (17 downto 0);

           rs1     : out unsigned (2  downto 0); --endereço dos registradores
           rs2     : out unsigned (2  downto 0);
           rd      : out unsigned (2  downto 0);

           selec_op: out unsigned (1  downto 0);

           imm     : out unsigned (17 downto 0); --carga imediata
           ctrl    : out std_logic;

           destino : out unsigned (6  downto 0); --jump
           jump_en : out std_logic ;

           dado    : out unsigned (17 downto 0) --repasse da instrução
      );
    end component;

    component mux7bits is
      port(in_a : in unsigned (6 downto 0);
           in_b : in unsigned (6 downto 0);
           ctrl : in std_logic;
           a_ou_b : out unsigned (6 downto 0)
      );
    end component;

    component maq_estados is
      port( clk,rst: in std_logic;
            estado: out unsigned(1 downto 0)
      );
    end component;

    component mux_1x3 is
      port(out_fetch      : out std_logic;
           out_decode     : out std_logic;
           out_execute    : out std_logic;
           state_machine  : in unsigned(1 downto 0)
      );
    end component; 

    component reg16bits is
      port(clk      : in std_logic;
           rst      : in std_logic;
           wr_en    : in std_logic;
           data_in  : in unsigned(17 downto 0);
           data_out : out unsigned(17 downto 0)
      );
    end component;

    signal banco_mux, mux_ula, banco_ula, ula_banco, rom_reg, reg_uc, uc_imm: unsigned(17 downto 0);
    signal pc_rom, in_a_mux7, in_b_mux7, mux7_pc: unsigned (6 downto 0);
    signal maq_mux1x3: unsigned (1 downto 0);
    signal wren_pc, ctrl_mux7, wren_banco, wren_reginstr, uc_ctrl: std_logic;
    signal uc_rs1, uc_rs2, uc_rd: unsigned (2 downto 0);
    signal uc_selec_op : unsigned(1 downto 0);
    signal saida_instr_uc: unsigned (17 downto 0);  


begin
    banco_regs_1: banco_regs    port map(clk => clk, wr_en => wren_banco, rst => rst, data_in => ula_banco, rs1 => uc_rs1, rs2 => uc_rs2, rd => uc_rd, data_out_A => banco_ula, data_out_B => banco_mux);

    mux_1         : mux         port map(ctrl => uc_ctrl, in_a => banco_mux, in_b => uc_imm, a_ou_b => mux_ula);

    ula_1         : ula         port map(in_a => banco_ula, in_b => mux_ula, selec_op => uc_selec_op, result => ula_banco, pino_extra => saida_ula);

    pc_1          : pc_n_soma   port map(clk => clk, rst => rst, wr_en => wren_pc, data_out_rom => pc_rom, data_out_somado => in_a_mux7, data_in => mux7_pc);

    rom_1         : rom         port map(clk => clk, endereco => pc_rom, dado => rom_reg);

    uc_1          : uc          port map(instr => reg_uc, dado => saida_instr_uc, destino => in_b_mux7, jump_en => ctrl_mux7, rs1 => uc_rs1, rs2=>uc_rs2, rd=>uc_rd, selec_op => uc_selec_op, imm => uc_imm, ctrl => uc_ctrl);

    mux7_1        : mux7bits    port map(in_a => in_a_mux7, in_b => in_b_mux7, ctrl => ctrl_mux7, a_ou_b => mux7_pc);

    maq_estados_1 : maq_estados port map(clk => clk, rst => rst, estado => maq_mux1x3);

    mux1x3_1      : mux_1x3     port map(state_machine => maq_mux1x3, out_fetch => wren_reginstr, out_decode => wren_banco, out_execute => wren_pc);

    reg_instr     : reg16bits   port map(clk => clk, rst => rst, wr_en => wren_reginstr, data_in => rom_reg, data_out => reg_uc);

end architecture;
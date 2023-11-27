library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_regs is
    port(clk      : in  std_logic;
         wr_en    : in  std_logic;
         rst      : in  std_logic;
         rs1      : in  unsigned (2 downto 0);
         rs2      : in  unsigned (2 downto 0);
         rd       : in  unsigned (2 downto 0);
         data_in  : in  unsigned(17 downto 0);
         data_out_A: out unsigned(17 downto 0);
         data_out_B: out unsigned(17 downto 0)
        );
end entity;

architecture a_banco_regs of banco_regs is
    component reg16bits is
        port(clk      : in std_logic;
             rst      : in std_logic;
             wr_en    : in std_logic;
             data_in  : in unsigned(17 downto 0);
             data_out : out unsigned(17 downto 0)
        );
    end component;

    component mux8 is
        port(in_0 : in unsigned (17 downto 0);
             in_1 : in unsigned (17 downto 0);
             in_2 : in unsigned (17 downto 0);
             in_3 : in unsigned (17 downto 0);
             in_4 : in unsigned (17 downto 0);
             in_5 : in unsigned (17 downto 0);
             in_6 : in unsigned (17 downto 0);
             in_7 : in unsigned (17 downto 0);
             rs   : in unsigned (2 downto 0);
             data_out : out unsigned (17 downto 0)
        );
    end component;

    component mux_1x8 is
        port(wr_0 : out std_logic;
             wr_1 : out std_logic;
             wr_2 : out std_logic;
             wr_3 : out std_logic;
             wr_4 : out std_logic;
             wr_5 : out std_logic;
             wr_6 : out std_logic;
             wr_7 : out std_logic;
             rd   : in unsigned (2 downto 0);
             wr_en: in std_logic
        );
    end component;

    signal wr_en0,wr_en1,wr_en2,wr_en3,wr_en4,wr_en5,wr_en6,wr_en7 : std_logic;
    signal data_out0,data_out1,data_out2,data_out3,data_out4,data_out5,data_out6,data_out7: unsigned (17 downto 0);

begin
    reg0:reg16bits port map(clk => clk, rst => rst, wr_en => wr_en0, data_in => data_in, data_out => data_out0);
    reg1:reg16bits port map(clk => clk, rst => rst, wr_en => wr_en1, data_in => data_in, data_out => data_out1);
    reg2:reg16bits port map(clk => clk, rst => rst, wr_en => wr_en2, data_in => data_in, data_out => data_out2);
    reg3:reg16bits port map(clk => clk, rst => rst, wr_en => wr_en3, data_in => data_in, data_out => data_out3);
    reg4:reg16bits port map(clk => clk, rst => rst, wr_en => wr_en4, data_in => data_in, data_out => data_out4);
    reg5:reg16bits port map(clk => clk, rst => rst, wr_en => wr_en5, data_in => data_in, data_out => data_out5);
    reg6:reg16bits port map(clk => clk, rst => rst, wr_en => wr_en6, data_in => data_in, data_out => data_out6);
    reg7:reg16bits port map(clk => clk, rst => rst, wr_en => wr_en7, data_in => data_in, data_out => data_out7);

    mux1:mux8 port map(in_0 => data_out0, in_1 => data_out1, in_2 => data_out2, in_3 => data_out3, in_4 => data_out4, in_5 => data_out5, in_6 => data_out6, in_7 => data_out7, rs => rs1, data_out => data_out_A);

    mux2:mux8 port map(in_0 => data_out0, in_1 => data_out1, in_2 => data_out2, in_3 => data_out3, in_4 => data_out4, in_5 => data_out5, in_6 => data_out6, in_7 => data_out7, rs => rs2, data_out => data_out_B);

    mux_wr:mux_1x8 port map(rd => rd, wr_en => wr_en, wr_0 => wr_en0, wr_1 => wr_en1, wr_2 => wr_en2, wr_3 => wr_en3, wr_4 => wr_en4, wr_5 => wr_en5, wr_6 => wr_en6, wr_7 => wr_en7);
end architecture;
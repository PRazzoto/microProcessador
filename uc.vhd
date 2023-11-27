library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc is
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
  end entity;

  architecture a_uc of uc is
    signal opcode : unsigned(5 downto 0);
    begin
       -- coloquei o opcode nos 6 bits MSB
       opcode  <= instr(17 downto 12);

       -- jump
       destino <= instr(6 downto 0);
       
       jump_en <=  '1' when opcode="011111" else
                   '0';

       -- add/addi/sub
       rs1 <= instr(2 downto 0) when opcode="000000" else
              "000"             when opcode="000100" else
              instr(2 downto 0) when opcode="000001" else
              "000";

       -- add       
       rs2 <= instr(5 downto 3) when opcode="000000" else
              "000";

       -- add/addi/sub       
       rd  <= instr(8 downto 6) when opcode="000000" else
              instr(5 downto 3) when opcode="000100" else
              instr(5 downto 3) when opcode="000001" else
              "000";

       -- add/addi/sub
       ctrl <= '1' when opcode="000000" else
               '0' when opcode="000100" else
               '0' when opcode="000001" else
               '1';

       -- add/addi/subi
       selec_op <= "00" when opcode="000000" else
                   "00" when opcode="000100" else 
                   "01" when opcode="000001" else
                   "00";
       -- addi/subi
       imm <= "000000000000" & instr(11 downto 6) when opcode="000100" else
              "000000000000" & instr(11 downto 6) when opcode="000001" else
              "000000000000000000";                   


       dado <= instr;
  end architecture;
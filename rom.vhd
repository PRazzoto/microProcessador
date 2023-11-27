library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity rom is
   port( clk      : in std_logic;
         endereco : in unsigned(6 downto 0);
         dado     : out unsigned(17 downto 0) 
   );
end entity;
architecture a_rom of rom is
   type mem is array (0 to 127) of unsigned(17 downto 0);
   constant conteudo_rom : mem := (
      -- caso endereco => conteudo
      0  => "000100000101011000",
      1  => "000100001000100000",
      2  => "000000000101100011",
      3  => "000001000001101101",
      4  => "011111000000010100",
      5  => "000000000000000000",
      6  => "000000000000000000",
      7  => "000000000000000000",
      8  => "000000000000000000",
      9  => "000000000000000000",
      20 => "000000000011101000",
      21 => "011111000000000010",
      -- abaixo: casos omissos => (zero em todos os bits)
      others => (others=>'0')
   );
begin
   process(clk)
   begin
      if(rising_edge(clk)) then
         dado <= conteudo_rom(to_integer(endereco));
      end if;
   end process;
end architecture;
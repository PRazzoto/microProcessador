library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity st_mach is
  port(clk      : in  std_logic;
       rst      : in  std_logic;
       estado   : out std_logic
  );
end entity;


architecture a_st_mach of st_mach is
    signal registro: std_logic;
begin

  process(clk,rst)
  begin
    if rst='1' then
        registro <= '0';
    elsif rising_edge(clk) and registro='0' then
        registro <= '1';
    elsif rising_edge(clk) and registro='1' then
        registro <= '0';
    
    end if;
  end process;

  estado <= registro;
end architecture;
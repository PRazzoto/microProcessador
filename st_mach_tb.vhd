library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity st_mach_tb is
end;

architecture a_st_mach_tb of st_mach_tb is
  component st_mach 
  port( clk    : in  std_logic;
        rst    : in  std_logic;
        estado : out std_logic 
  );
  end component;

  constant period_time    : time := 100 ns;
  signal finished         : std_logic := '0';
  signal clk, rst         : std_logic;
  signal estado           : std_logic;

  begin
    uut: st_mach port map(clk    => clk,
                          rst    => rst,
                          estado => estado);

 reset_global:  process
    begin
      rst <= '1';
      wait for period_time*2; --2 clocks para garantir
      rst <= '0';
      wait;
    end process;

    sim_time_proc: process
    begin
      wait for 10 us;
      finished <= '1';
      wait;
    end process sim_time_proc;

    clk_proc: process
    begin
      while finished /= '1' loop
        clk <= '0';
        wait for period_time/2;
        clk <= '1';
        wait for period_time/2;
      end loop;
      wait;
    end process clk_proc;
end architecture a_st_mach_tb;
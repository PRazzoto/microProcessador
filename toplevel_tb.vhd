library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity toplevel_tb is
end;

architecture a_toplevel_tb of toplevel_tb is
  component toplevel
  port(clk      : in  std_logic;
       rst      : in  std_logic;
       saida_ula: out unsigned(17 downto 0)
      );
  end component;

  constant period_time                       : time := 100 ns;
  signal   finished                          : std_logic := '0';
  signal   clk,rst                           : std_logic;
  signal   saida_ula                         : unsigned(17 downto 0);

  begin
    uut: toplevel port map( clk => clk,
                            rst => rst,
                            saida_ula => saida_ula
                            );

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
end architecture a_toplevel_tb;
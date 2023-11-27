library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity pc_n_soma_tb is
end;

architecture a_pc_n_soma_tb of pc_n_soma_tb is
  component pc_n_soma 
  port( clk      : in std_logic;
        rst      : in std_logic;
        wr_en    : in std_logic;
        data_out : out unsigned(6 downto 0)
  );
  end component;

  constant period_time : time := 100 ns;
  signal finished : std_logic := '0';
  signal clk, rst, wr_en : std_logic;
  signal data_out : unsigned(6 downto 0);

  begin
    uut: pc_n_soma port map(clk => clk,
                            wr_en => wr_en,
                            rst => rst,
                            data_out => data_out);

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

    process                      -- sinais dos casos de teste (p.ex.)
    begin
      wr_en <= '1';
      wait;                     
    end process;
end architecture a_pc_n_soma_tb;
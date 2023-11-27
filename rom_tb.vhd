library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity rom_tb is
end;

architecture a_rom_tb of rom_tb is
    component rom 
    port( clk      : in std_logic;
          endereco : in unsigned(6 downto 0);
          dado     : out unsigned(17 downto 0) 
    );
    end component;

    constant period_time : time := 100 ns;
    signal finished      : std_logic := '0';
    signal clk           : std_logic;
    signal endereco      : unsigned(6 downto 0);
    signal dado          : unsigned(17 downto 0);

    begin
      uut: rom port map(clk      => clk,
                        endereco => endereco,
                        dado     => dado);

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
        wait for 200 ns;
        endereco <= "0000101";
        wait for 100 ns;
        endereco <= "0000000";
        wait;                     
      end process;
end architecture a_rom_tb;
library ieee;
use ieee.std_logic_1164.all;

entity paridade_tb is
end;

architecture a_paridade_tb of paridade_tb is
    component paridade
        port( in_a : in  std_logic;
              in_b : in  std_logic;
              in_c : in  std_logic;
              impar: out std_logic
        );
    end component;
    signal in_a, in_b, in_c, impar: std_logic;

    begin
        uut: paridade port map ( in_a => in_a,
                                 in_b => in_b,
                                 in_c => in_c,
                                 impar => impar);
    process
    begin
        in_a <= '0';
        in_b <= '0';
        in_c <= '0';
        wait for 50 ns;
        in_a <= '0';
        in_b <= '0';
        in_c <= '1';
        wait for 50 ns;
        in_a <= '0';
        in_b <= '1';
        in_c <= '0';
        wait for 50 ns;
        in_a <= '0';
        in_b <= '1';
        in_c <= '1';
        wait for 50 ns;
        in_a <= '1';
        in_b <= '0';
        in_c <= '0';
        wait for 50 ns;
        in_a <= '1';
        in_b <= '0';
        in_c <= '1';
        wait for 50 ns;
        in_a <= '1';
        in_b <= '1';
        in_c <= '0';
        wait for 50 ns;
        in_a <= '1';
        in_b <= '1';
        in_c <= '1';
        wait for 50 ns;
        wait;
    end process;
end architecture;

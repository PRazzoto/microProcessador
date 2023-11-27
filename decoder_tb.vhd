library ieee;
use ieee.std_logic_1164.all;

entity decoder_tb is
end;

architecture a_decoder_tb of decoder_tb is
    component decoder
        port( in_a: in std_logic;
              in_b: in std_logic;
              out_one: out std_logic;
              out_two: out std_logic;
              out_thr: out std_logic;
              out_fou: out std_logic
        );
    end component;
    signal in_a, in_b, out_one, out_two, out_thr, out_fou: std_logic;

    begin
        uut: decoder port map( in_a => in_a,
                               in_b => in_b,
                               out_one => out_one,
                               out_two => out_two,
                               out_thr => out_thr,
                               out_fou => out_fou);
    process
    begin
        in_a <= '0';
        in_b <= '0';
        wait for 50 ns;
        in_a <= '0';
        in_b <= '1';
        wait for 50 ns;
        in_a <= '1';
        in_b <= '0';
        wait for 50 ns;
        in_a <= '1';
        in_b <= '1';
        wait for 50 ns;
        wait;
    end process;
end architecture;
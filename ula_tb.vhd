library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ula_tb is
end;

architecture a_ula_tb of ula_tb is
  component ula
  port( in_a : in unsigned(15 downto 0);
        in_b : in unsigned(15 downto 0);
        selec_op : in unsigned(1 downto 0);
        result : out unsigned(15 downto 0);
        pino_extra: out unsigned(15 downto 0)
      );
  end component;

  signal in_a, in_b, result, pino_extra : unsigned (15 downto 0);
  signal selec_op: unsigned (1 downto 0);

  begin
    uut: ula port map(in_a => in_a,
                        in_b => in_b,
                        selec_op => selec_op,
                        result => result,
                        pino_extra => pino_extra);


    process
    begin
      selec_op <= "00";
      in_a <= "0111111111111111"; --testa 
      in_b <= "0000000000000001";
      wait for 100 ns;
      selec_op <= "00";
      in_a <= "1111111111111111"; --testa limite
      in_b <= "0000000000000001";
      wait for 100 ns;
      selec_op <= "00";
      in_a <= "1111111111111111"; --testa limitezão
      in_b <= "1111111111111111";

      wait for 100 ns;
      selec_op <= "01";
      in_a <= "0000000000000001"; --testa 
      in_b <= "0000000000000001";
      wait for 100 ns;
      selec_op <= "01";
      in_a <= "0000000000000000"; --testa limite
      in_b <= "0000000000000001";
      wait for 100 ns;
      selec_op <= "01";
      in_a <= "0000000000000000"; --testa limitezão
      in_b <= "1111111111111111";

      wait for 100 ns;
      selec_op <= "10";
      in_a <= "0000000000000001"; --testa 
      in_b <= "0000000000000000";
      wait for 100 ns;
      selec_op <= "10";
      in_a <= "0000000000000000"; --testa limite
      in_b <= "0000000000000000";
      wait for 100 ns;
      selec_op <= "10";
      in_a <= "1111111111111111"; --testa limitezão
      in_b <= "1111111111111111";

      wait for 100 ns;
      selec_op <= "11";
      in_a <= "0000000000000001"; --testa 
      in_b <= "0000000000000000";
      wait for 100 ns;
      selec_op <= "11";
      in_a <= "0000000000000000"; --testa limite
      in_b <= "0000000000000000";
      wait for 100 ns;
      selec_op <= "11";
      in_a <= "1111111111111111"; --testa limitezão
      in_b <= "1111111111111111";
    
      wait for 100 ns;
      wait;
    end process;
end architecture;

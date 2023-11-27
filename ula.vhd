library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
  port( in_a    : in unsigned(17 downto 0);
        in_b    : in unsigned(17 downto 0);
        selec_op: in unsigned(1 downto 0);
        result    : out unsigned(17 downto 0);
        pino_extra: out unsigned(17 downto 0)
  );
end entity;


  architecture a_ula of ula is
    begin

    result <= in_a + in_b when selec_op = "00" else


              in_a - in_b when selec_op = "01" else

              "000000000000000001" when in_a > in_b and selec_op = "10" else
              "000000000000000000" when in_a <= in_b and selec_op = "10" else

              in_a when in_a > in_b and selec_op = "11" else
              in_b when in_b > in_a and selec_op = "11" else

              "000000000000000000";

    pino_extra <= in_a + in_b when selec_op = "00" else


                  in_a - in_b when selec_op = "01" else

                  "000000000000000001" when in_a > in_b and selec_op = "10" else
                  "000000000000000000" when in_a <= in_b and selec_op = "10" else

                  in_a when in_a > in_b and selec_op = "11" else
                  in_b when in_b > in_a and selec_op = "11" else

                  "000000000000000000";
                  
  end architecture;

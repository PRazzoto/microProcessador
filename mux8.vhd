library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux8 is
  port(in_0 : in unsigned (17 downto 0);
       in_1 : in unsigned (17 downto 0);
       in_2 : in unsigned (17 downto 0);
       in_3 : in unsigned (17 downto 0);
       in_4 : in unsigned (17 downto 0);
       in_5 : in unsigned (17 downto 0);
       in_6 : in unsigned (17 downto 0);
       in_7 : in unsigned (17 downto 0);
       rs   : in unsigned (2 downto 0);
       data_out : out unsigned (17 downto 0)
  );
  end entity;

  architecture a_mux8 of mux8 is
  begin
      data_out <= in_0 when rs = "000" else
                  in_1 when rs = "001" else
                  in_2 when rs = "010" else
                  in_3 when rs = "011" else
                  in_4 when rs = "100" else
                  in_5 when rs = "101" else
                  in_6 when rs = "110" else
                  in_7 when rs = "111" else
                  "000000000000000000";
  end architecture;
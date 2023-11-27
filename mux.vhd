library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux is
  port(in_a : in unsigned (17 downto 0);
       in_b : in unsigned (17 downto 0);
       ctrl : in std_logic;
       a_ou_b : out unsigned (17 downto 0)
  );
  end entity;

  architecture a_mux of mux is
  begin
      a_ou_b <= in_a when ctrl = '1' else
                in_b when ctrl = '0' else
                "000000000000000000";
  end architecture;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux7bits is
  port(in_a : in unsigned (6 downto 0);
       in_b : in unsigned (6 downto 0);
       ctrl : in std_logic;
       a_ou_b : out unsigned (6 downto 0)
  );
  end entity;

  architecture a_mux7bits of mux7bits is
  begin
      a_ou_b <= in_a when ctrl = '0' else
                in_b when ctrl = '1' else
                "0000000";
  end architecture;
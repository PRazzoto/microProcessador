library ieee;
use ieee.std_logic_1164.all;

entity paridade is
    port( in_a : in  std_logic;
          in_b : in  std_logic;
          in_c : in  std_logic;
          impar: out std_logic
        );
end entity;

architecture a_paridade of paridade is
begin 
    impar <= in_a xor in_b xor in_c;
end architecture;
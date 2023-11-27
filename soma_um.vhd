library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity soma_um is
  port(data_in  : in unsigned(6 downto 0);
       data_out : out unsigned(6 downto 0)
  );
end entity;


architecture a_soma_um of soma_um is
begin
  data_out <= data_in + 1;
end architecture;
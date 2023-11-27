library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_1x3 is
  port(out_fetch      : out std_logic;
       out_decode     : out std_logic;
       out_execute    : out std_logic;
       state_machine  : in unsigned(1 downto 0)
  );
  end entity;


  architecture a_mux_1x3 of mux_1x3 is
  begin

    out_fetch <=   '1' when state_machine = "00" else
                   '0';
    out_decode <=  '1' when state_machine = "01" else
                   '0';
    out_execute <= '1' when state_machine = "10" else
                   '0';

  end architecture;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_1x8 is
  port(wr_0 : out std_logic;
       wr_1 : out std_logic;
       wr_2 : out std_logic;
       wr_3 : out std_logic;
       wr_4 : out std_logic;
       wr_5 : out std_logic;
       wr_6 : out std_logic;
       wr_7 : out std_logic;
       rd   : in unsigned (2 downto 0);
       wr_en: in std_logic
  );
  end entity;

  architecture a_mux_1x8 of mux_1x8 is
  begin
      wr_0 <= '0' when rd = "000" else
              '0';
      wr_1 <= wr_en when rd = "001" else
              '0';
      wr_2 <= wr_en when rd = "010" else
              '0';
      wr_3 <= wr_en when rd = "011" else
              '0';
      wr_4 <= wr_en when rd = "100" else
              '0';
      wr_5 <= wr_en when rd = "101" else
              '0';
      wr_6 <= wr_en when rd = "110" else
              '0';
      wr_7 <= wr_en when rd = "111" else
              '0';
  end architecture;
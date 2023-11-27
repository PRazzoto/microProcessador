library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_n_soma is
  port(clk      : in std_logic;
       rst      : in std_logic;
       wr_en    : in std_logic;
       data_in  : in unsigned(6 downto 0);
       data_out_rom : out unsigned(6 downto 0);
       data_out_somado: out unsigned(6 downto 0)   
  );
end entity;


architecture a_pc_n_soma of pc_n_soma is

    component pc is
        port(clk      : in std_logic;
             rst      : in std_logic;
             wr_en    : in std_logic;
             data_in  : in unsigned(6 downto 0);
             data_out_rom : out unsigned(6 downto 0);
             data_out_soma: out unsigned(6 downto 0)        
        );
    end component;

    component soma_um is
        port(data_in  : in unsigned(6 downto 0);
             data_out : out unsigned(6 downto 0)
        );
    end component;

    signal pc_soma, soma_pc : unsigned (6 downto 0);

begin
    pc_1: pc port map (clk => clk, rst => rst, wr_en => wr_en, data_in => data_in, data_out_rom => data_out_rom, data_out_soma => pc_soma);
    soma_um_1: soma_um port map(data_in => pc_soma, data_out => data_out_somado);
end architecture;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco_regs_tb is
end;

architecture a_banco_regs_tb of banco_regs_tb is
  component banco_regs
  port( clk      : in std_logic;
        rst      : in  std_logic;
        rs1      : in  unsigned (2 downto 0);
        rs2      : in  unsigned (2 downto 0);
        rd       : in  unsigned (2 downto 0);
        data_in  : in  unsigned(15 downto 0);
        data_out_A: out unsigned(15 downto 0);
        data_out_B: out unsigned(15 downto 0)
  );
  end component;

  constant period_time                   : time := 100 ns;
  signal finished                        : std_logic := '0';
  signal clk,rst                         : std_logic;
  signal rs1,rs2,rd                      : unsigned(2 downto 0);
  signal data_in, data_out_A, data_out_B : unsigned(15 downto 0);

  begin
    uut: banco_regs port map( clk => clk,
                              rst => rst,
                              rs1 => rs1,
                              rs2 => rs2,
                              rd => rd,
                              data_in => data_in,
                              data_out_A => data_out_A,
                              data_out_B => data_out_B);


 reset_global:  process
    begin
      rst <= '1';
      wait for period_time*2; --2 clocks para garantir
      rst <= '0';
      wait;
    end process;

    sim_time_proc: process
    begin
      wait for 10 us;
      finished <= '1';
      wait;
    end process sim_time_proc;

    clk_proc: process
    begin
      while finished /= '1' loop
        clk <= '0';
        wait for period_time/2;
        clk <= '1';
        wait for period_time/2;
      end loop;
      wait;
    end process clk_proc;

    process                      -- sinais dos casos de teste (p.ex.)
    begin
      --Escrever os dados:
      wait for 200 ns;
      rd <= "000"; 
      data_in <= "1111111111111111";
      rs1 <= "000";
      --registrador 0 deve permanecer inalterado

      wait for 100 ns;
      rd <= "001";
      data_in <= "0000000000000001";
      rs1 <= "001";
      --escreve no registrador 1 e faz sua leitura pela saida 1

      wait for 100 ns;
      rd <= "010";
      data_in <= "0000000000000010";
      rs2 <= "010";
      --escreve no registrador 2 e faz sua leitura pela saida 2
    
      wait for 100 ns;    
      rd  <= "011";
      data_in <= "0000000000000011";
      rs1 <= "011";
      --escreve no registrador 3 e faz sua leitura pela saida 1

      wait for 100 ns;
      rd  <= "100";
      data_in <= "0000000000000100";
      rs2 <= "100";    
      --escreve no registrador 4 e faz sua leitura pela saida 2

      wait for 100 ns;
      rs1 <= "001";
      rs2 <= "010";
      --registradores 1 e 2 devem permanecer com o valor 1 e 2


      wait;
    end process;
end architecture a_banco_regs_tb;

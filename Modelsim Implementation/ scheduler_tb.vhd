library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_scheduler is
end entity;

architecture sim of tb_scheduler is
  constant G_tb : integer := 4;
  constant Y_tb : integer := 2;

  signal clk     : std_logic := '0';
  signal reset_n : std_logic := '0';
  signal q0, q1, q2, q3 : unsigned(3 downto 0) := (others=>'0');
  signal best    : unsigned(1 downto 0);
  signal green   : std_logic_vector(3 downto 0);
  signal all_red : std_logic;
begin

  -- Instantiate the scheduler
  DUT: entity work.scheduler
    generic map (G => G_tb, Y => Y_tb)
    port map (
      clk     => clk,
      reset_n => reset_n,
      q0      => q0,
      q1      => q1,
      q2      => q2,
      q3      => q3,
      best    => best,
      green   => green,
      all_red => all_red
    );

  -- 1 ns clock
  clk_proc: process
  begin
    wait for 1 ns;
    clk <= not clk;
  end process;

  -- Test stimulus: static queue values
  stim_proc: process
  begin
    -- Reset system
    reset_n <= '0'; wait for 5 ns;
    reset_n <= '1'; wait for 1 ns;

    -- Test vector #1
    q0 <= to_unsigned(2,4);
    q1 <= to_unsigned(4,4);
    q2 <= to_unsigned(1,4);
    q3 <= to_unsigned(3,4);

    -- Let it run for 20 ns (enough to see G and Y phases)
    wait for 20 ns;

    -- Test vector #2
    q0 <= to_unsigned(0,4);
    q1 <= to_unsigned(5,4);
    q2 <= to_unsigned(2,4);
    q3 <= to_unsigned(5,4);

    wait for 20 ns;

    -- Done
    wait;
  end process;

end architecture sim;


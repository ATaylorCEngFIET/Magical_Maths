library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity tb_math is
--  Port ( );
end tb_math;

architecture Behavioral of tb_math is

component math_example is port(
 clk : in std_logic;
 rst : in std_logic;
 
 ip_val : in std_logic;
 ip : in std_logic_vector(7 downto 0);
 
 op_val : out std_logic;
 op : out std_logic_vector(7 downto 0));

end component math_example;

type input is array(0 to 59) of integer range 0 to 255;

signal stim_array : input := (70,71,69,67,65,68,69,66,65,72,70,69,67,65,70,64,69,65,68,64,69,70,72,68,65,72,69,67,67,68,70,71,69,67,65,68,69,66,65,72,70,69,67,65,70,64,69,65,68,64,69,70,72,68,65,72,69,67,67,68);

constant clk_period : time := 100 ns;
signal clk : std_logic := '0';
signal rst :  std_logic:='0';
signal ip_val :  std_logic :='0';
signal ip :  std_logic_vector(7 downto 0):=(others=>'0');
signal op_val :  std_logic :='0';
signal op : std_logic_vector(7 downto 0):=(others=>'0');

begin

clk_gen : clk <= not clk after (clk_period/2);

uut: math_example port map(clk, rst, ip_val, ip, op_val, op);

stim : process
begin 
 rst <= '1' ;
 wait for 1 us;
 rst <= '0';
 wait for clk_period;
 wait until rising_edge(clk);
 for i in 0 to 59 loop
  wait until rising_edge(clk);
  ip_val <= '1';
  ip <= std_logic_vector(to_unsigned(stim_array(i),8));
  wait until rising_edge(clk);
  ip_val <= '0';
 end loop;
 wait for 1 us;
 report "simulation complete" severity failure;
end process;
 

end Behavioral;

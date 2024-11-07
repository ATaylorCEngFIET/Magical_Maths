
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;


entity tb_complex is
--  Port ( );
end tb_complex;

architecture Behavioral of tb_complex is

component complex_example is port(
clk    : in std_logic; 
ip_val : in std_logic;
ip     : in std_logic_vector(7 downto 0);
op_val : out std_logic;
op     : out std_logic_vector(8 downto 0));
end component complex_example;


signal clk    :  std_logic:='0'; 
signal ip_val :  std_logic:='0';
signal ip     :  std_logic_vector(7 downto 0):=(others=>'0');
signal op     :  std_logic_vector(8 downto 0):=(others=>'0');
signal op_val :  std_logic:='0';
constant clk_period : time := 100 ns;

begin

clk <= not clk after (clk_period/2);

uut: complex_example port map(clk,ip_val,ip,op_val,op);

stim : process
begin 
 wait for 1 us;
 wait until rising_edge(clk);
 ip_val <= '1';
 ip <= std_logic_vector(to_unsigned(61,8));
 wait until rising_edge(clk);
 ip_val <= '0';
 wait for 1 us;
 report " simulation complete" severity failure;
end process;


end Behavioral;

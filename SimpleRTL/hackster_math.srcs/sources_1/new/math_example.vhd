library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--library ieee_proposed;
use ieee.fixed_pkg.all;

entity math_example is port(
 clk : in std_logic;
 rst : in std_logic;
 
 ip_val : in std_logic;
 ip : in std_logic_vector(7 downto 0);
 
 op_val : out std_logic;
 op : out std_logic_vector(7 downto 0));

end math_example;

architecture Behavioral of math_example is

constant divider : ufixed(-1 downto -16):= to_ufixed( 0.1, -1,-16 ) ; 

signal accumulator : ufixed(11 downto 0) := (others => '0');
signal average : ufixed(11 downto -16 ) := (others => '0');

begin

acumm : process(rst,clk)
begin
 
 if rising_edge(clk) then 
    if rst = '1' then 
        accumulator <= (others => '0');
        average <= (others => '0');
    elsif ip_val = '1' then 
        accumulator <= resize (arg => (accumulator + to_ufixed(ip,7,0)-average(11 downto 0)), size_res => accumulator);
        average <= accumulator * divider;
    end if;
 end if;
end process;

op <= to_slv(average(7 downto 0));

end Behavioral;

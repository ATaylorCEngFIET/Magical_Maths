library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use ieee.fixed_pkg.all;

entity complex_example is port(

clk : in std_logic; 

ip_val : in std_logic;
ip     : in std_logic_vector(7 downto 0);
op_val : out std_logic;
op     : out std_logic_vector(8 downto 0));

end complex_example;

architecture Behavioral of complex_example is

type fsm is (idle, powers, sum, result);

signal current_state : fsm := idle;
signal power_a : sfixed(35 downto 0):=(others=>'0');
signal power_b : sfixed(26 downto 0):=(others=>'0');
signal power_c : sfixed(17 downto 0):=(others=>'0');

signal calc  : sfixed(49 downto -32) :=(others=>'0');
signal store : sfixed(8 downto 0) := (others =>'0');

constant a : sfixed(9 downto -32):= to_sfixed( 2.00E-09, 9,-32 ); 
constant b : sfixed(9 downto -32):= to_sfixed( 4.00E-07, 9,-32 );
constant c : sfixed(9 downto -32):= to_sfixed( 0.0011, 9,-32 ); 
constant d : sfixed(9 downto -32):= to_sfixed( 2.403, 9,-32 ); 
constant e : sfixed(9 downto -32):= to_sfixed( 251.26, 9,-32 ); 

begin

cvd : process(clk)
begin 
 if rising_edge(clk) then 
  op_val <='0';
  case current_state is 
   when idle => 
    if ip_val = '1' then 
     store <= to_sfixed('0'&ip,store);
     current_state <= powers;
    end if;
   when powers =>
    power_a <= store * store * store * store;
    power_b <= store * store * store;
    power_c <= store * store;
    current_state <= sum;
   when sum =>
    calc <= (power_a*a) - (power_b * b) + (power_c * c) + (store * d) - e;
    current_state <= result;
   when result =>
    current_state <= idle;
    op <= to_slv(calc(8 downto 0));
    op_val <='1';
   end case;
  end if;
end process;

end Behavioral;

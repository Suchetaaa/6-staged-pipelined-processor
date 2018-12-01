library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity write_back is
  port (
	clk : in std_logic;
	reset: in std_logic;
    
    write_signal : in std_logic;   
    write_reg : in std_logic_vector(2 downto 0); 
    c_write : in std_logic;
    z_write : in std_logic;
    
  ) ;
end entity ; -- instruction_fetch

architecture arch of instruction_fetch is

begin


end architecture ; -- arch
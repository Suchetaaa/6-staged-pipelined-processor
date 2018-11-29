library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity instruction_decode is
  port (
	clk : in std_logic
  ) ;
end entity ; -- instruction_decode
library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity if_id_reg is
  port (
	clk : in std_logic
  ) ;
end entity ; -- if_id_reg
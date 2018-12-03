--block to forward data from the MM-WB stage to the execution stage if there is a dependency
library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity forwarding_mm is
	port(
		clk : in std_logic;
		reset : in std_logic;
		mm_f_en : in std_logic;
		)
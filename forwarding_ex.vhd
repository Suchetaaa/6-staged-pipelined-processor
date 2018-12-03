-- block to forward data from the EX-MM register to the execution stage of the previous register
library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity forwarding_ex is
	port(
		clk : in std_logic;
		reset : in std_logic;
		ex_f_en : in std_logic;
		)
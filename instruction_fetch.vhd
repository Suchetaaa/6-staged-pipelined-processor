library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity instruction_fetch is
  port (
	clk : in std_logic;

	--Tells if the next PC should be PC+1 or some other complicated thing
	pc_normal : in std_logic;
	--Control signals to the MUX given to PC_in in case of a complicated logic
	--00 - alu1_out 
	--01 - alu2_out
	--10 - mem_data_out (Different from the register out)
	pc_select : in std_logic_vector(2 downto 0);
	--Enable pin for PC register 
	pc_register_enable : in std_logic;

	--enable pin for IR
	ir_enable : in std_logic

  ) ;
end entity ; -- instruction_fetch

architecture arch of instruction_fetch is

	signal 

begin

end architecture ; -- arch
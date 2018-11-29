library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use work.components_init.all;
use work.memory.all;

entity instruction_memory is
  port (
  	--Input address of the instruction
	address_in : in std_logic_vector(15 downto 0);

	--Instruction which is coming out 
	instruction_out : out std_logic_vector(15 downto 0)
  ) ;
end entity ; -- instruction_memory

architecture arch of instruction_memory is

	signal memory_database : memory_database_type := memory;

begin

	instruction_out <= memory_database(to_integer(unsigned(address_in)));

end architecture ; -- arch
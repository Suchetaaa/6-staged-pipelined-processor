library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use work.components_init.all;

entity incrementer_pc is
  port (
	incrementer_pc_in : in std_logic_vector(15 downto 0);
	incrementer_pc_out : out std_logic_vector(15 downto 0)
  ) ;
end entity ; -- incrementer_pc

architecture arch of incrementer_pc is

	signal 

begin

	incrementer_pc_out <= std_logic_vector(unsigned(incrementer_pc_in) + 1);

end architecture ; -- arch
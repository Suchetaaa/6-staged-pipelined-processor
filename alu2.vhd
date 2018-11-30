library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity alu2 is
  port (
	--No clock and no register
	alu2_a : in std_logic_vector(15 downto 0);
	alu2_b : in std_logic_vector(15 downto 0);
	alu2_out : out std_logic_vector(15 downto 0)
  ) ;
end entity ; -- alu2

architecture arch of alu2 is

begin

	alu2_out <= std_logic_vector(unsigned(alu2_a) + unsigned(alu2_b));

end architecture ; -- arch
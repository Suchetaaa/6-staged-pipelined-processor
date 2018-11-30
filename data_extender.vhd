library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity data_extender is
  port (
	data_extender_in : in std_logic_vector(8 downto 0);
	data_extender_out : out std_logic_vector(15 downto 0)
  ) ;
end entity ; -- data_extender

architecture arch of data_extender is

begin

	data_extender_out(15 downto 7) <= data_extender_in(8 downto 0);
	data_extender_out(6) <= "0";
	data_extender_out(5) <= "0";
	data_extender_out(4) <= "0";
	data_extender_out(3) <= "0";
	data_extender_out(2) <= "0";
	data_extender_out(1) <= "0";
	data_extender_out(0) <= "0";

end architecture ; -- arch
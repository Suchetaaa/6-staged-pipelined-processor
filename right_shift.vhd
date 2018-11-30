library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity right_shift is
  port (
	right_shift_in : in std_logic_vector(7 downto 0);
	right_shift_out : out std_logic_vector(7 downto 0)
  ) ;
end entity ; -- right_shift

architecture arch of right_shift is

begin

	right_shift_out(0) <= right_shift_in(1);
	right_shift_out(1) <= right_shift_in(2);
	right_shift_out(2) <= right_shift_in(3);
	right_shift_out(3) <= right_shift_in(4);
	right_shift_out(4) <= right_shift_in(5);
	right_shift_out(5) <= right_shift_in(6);
	right_shift_out(6) <= right_shift_in(7);
	right_shift_out(7) <= "0";


end architecture ; -- arch
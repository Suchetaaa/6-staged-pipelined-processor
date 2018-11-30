library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity sign_extender_6 is
  port (
	se6_in : in std_logic_vector(5 downto 0);
	se6_out : out std_logic_vector(15 downto 0)
  ) ;
end entity ; -- sign_extender_6

architecture arch of sign_extender_6 is

begin

	se6_out(5 downto 0) <= se6_in(5 downto 0);
	se6_out(6) <= se6_in(5);
	se6_out(7) <= se6_in(5);
	se6_out(8) <= se6_in(5);
	se6_out(9) <= se6_in(5);
	se6_out(10) <= se6_in(5);
	se6_out(11) <= se6_in(5);
	se6_out(12) <= se6_in(5);
	se6_out(13) <= se6_in(5);
	se6_out(14) <= se6_in(5);
	se6_out(15) <= se6_in(5);

end architecture ; -- arch
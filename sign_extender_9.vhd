library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity sign_extender_9 is
  port (
	se9_in : in std_logic_vector(8 downto 0);
	se9_out : out std_logic_vector(15 downto 0)
  ) ;
end entity ; -- sign_extender_9

architecture arch of sign_extender_9 is

begin

	se9_out(8 downto 0) <= se9_in(8 downto 0);
	se9_out(9) <= se9_in(8);
	se9_out(10) <= se9_in(8);
	se9_out(11) <= se9_in(8);
	se9_out(12) <= se9_in(8);
	se9_out(13) <= se9_in(8);
	se9_out(14) <= se9_in(8);
	se9_out(15) <= se9_in(8);

end architecture ; -- arch
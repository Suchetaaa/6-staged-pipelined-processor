library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity decoder is
  port (
	decoder_in : in std_logic_vector(7 downto 0);
	decoder_out : out std_logic_vector(2 downto 0)
  ) ;
end entity ; -- decoder

architecture arch of decoder is

begin

	if decoder_in = "00000001" then 
		decoder_out <= "111";
	elsif decoder_in = "00000010" then
		decoder_out <= "110";
	elsif decoder_in = "00000100" then
		decoder_out <= "101";
	elsif decoder_in = "00001000" then
		decoder_out <= "100";
	elsif decoder_in = "00010000" then
		decoder_out <= "011";
	elsif decoder_in = "00100000" then
		decoder_out <= "010";
	elsif decoder_in = "01000000" then
		decoder_out <= "001";
	elsif decoder_in = "10000000" then
		decoder_out <= "000";
	end if;
	

end architecture ; -- arch
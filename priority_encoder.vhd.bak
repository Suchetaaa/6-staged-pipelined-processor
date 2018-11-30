library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity priority_encoder is
  port (
	priority_in : in std_logic_vector(7 downto 0);
	priority_enable : in std_logic;
	priority_out : out std_logic_vector(7 downto 0)
  ) ;
end entity ; -- priority_encoder

architecture arch of priority_encoder is

signal priority_out_signal : std_logic_vector(7 downto 0) := "00000000";

begin
	if priority_enable = '1' then 
		if priority_in(0) = "1" then 
			priority_out_signal = "00000001";
		elsif priority_in(1) = "1" then
			priority_out_signal = "00000010";
		elsif priority_in(2) = "1" then
			priority_out_signal = "00000100";
		elsif priority_in(3) = "1" then
			priority_out_signal = "00001000";
		elsif priority_in(4) = "1" then
			priority_out_signal = "00010000";
		elsif priority_in(5) = "1" then
			priority_out_signal = "00100000";
		elsif priority_in(6) = "1" then
			priority_out_signal = "01000000";
		elsif priority_in(7) = "1" then
			priority_out_signal = "10000000";
		end if;
	end if;

	priority_out <= priority_out_signal;
	
end architecture ; -- arch
library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity lm_sm_adder is
  port (
	clk : in std_logic;
	data_ra : in std_logic_vector(15 downto 0);
	lm_sm_adder_out_old : in std_logic_vector(15 downto 0);
	lm_detect : in std_logic;
	first_last_check : in std_logic;
	write_enable : in std_logic;
	lm_sm_adder_out : out std_logic_vector(15 downto 0)
  ) ;
end entity ; -- lm_sm_adder

architecture arch of lm_sm_adder is

begin

	adder_lm_sm : process(clk, data_ra, first_last_check, write_enable, lm_sm_adder_out_old, lm_detect)
	--variable lm_sm_adder_out_variable : std_logic_vector(15 downto 0);
	begin	
		if lm_detect = '1' then 
			if first_last_check = '0' and write_enable = '0' then 
				lm_sm_adder_out <= std_logic_vector(unsigned(data_ra) - 1);
			elsif first_last_check = '0' and write_enable = '1' then
				lm_sm_adder_out <= std_logic_vector(unsigned(data_ra));
			elsif write_enable = '1' then 
				lm_sm_adder_out <= std_logic_vector(unsigned(lm_sm_adder_out_old) + 1);
			elsif write_enable = '0' then 
				lm_sm_adder_out <= lm_sm_adder_out_old;
			end if;
		else 
			lm_sm_adder_out <= "0000000000000000";
		end if;
	end process ; -- adder_lm_sm

end architecture ; -- arch




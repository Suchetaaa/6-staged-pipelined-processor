library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity register_2 is
  port (
  	reg_data_in : in std_logic_vector(1 downto 0);
  	reg_enable : in std_logic;
	clk : in std_logic;
  	reg_data_out : out std_logic_vector(1 downto 0)
  ) ;
end entity ; -- register_1

architecture arch of register_1 is
begin
identifier : process (clk) 
begin

	if (clk'event and clk = '1') then 
		if reg_enable = '1' then 
			reg_data_out <= reg_data_in;
		end if;
	end if;
	
end process ; -- identifier

end architecture ; -- arch
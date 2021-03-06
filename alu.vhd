library std;
library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity alu1 is
  port (
	
	alu_a : in std_logic_vector(15 downto 0);
	alu_b : in std_logic_vector(15 downto 0);

	--Carries the operation ALU has to perform
	--00 - Addition
	--01 - Subtraction
	--10 - NAND
	alu_op : in std_logic_vector(1 downto 0);
	alu_out : out std_logic_vector(15 downto 0);
	carry : out std_logic;
	zero : out std_logic
  ) ;
end entity ; -- ALU1

architecture alu of alu1 is

	signal negative_a : std_logic_vector(15 downto 0);
	signal negative_b : std_logic_vector(15 downto 0);
	signal alu_out_sig : std_logic_vector(15 downto 0);
	signal tmp : std_logic_vector(16 downto 0);
	signal carry_when_pos : std_logic;
	signal carry_when_neg : std_logic;
	signal neg_addition : std_logic_vector(15 downto 0);

begin

	negative_a <= std_logic_vector(unsigned(not alu_a) + 1);
	negative_b <= std_logic_vector(unsigned(not alu_b) + 1);

	process(alu_a, alu_b, alu_op)
	begin 
		if alu_op = "10" then 
			alu_out_sig <= alu_a nand alu_b;
			neg_addition <= "0000000000000000";
		elsif alu_op = "01" then 
			alu_out_sig <= std_logic_vector(unsigned(alu_a) + unsigned(negative_b));
			neg_addition <= std_logic_vector(unsigned(negative_a) + unsigned(alu_b));
		elsif alu_op = "00" then 
			alu_out_sig <= std_logic_vector(unsigned(alu_a) + unsigned(alu_b));
			neg_addition <= std_logic_vector(unsigned(negative_a) + unsigned(negative_b));
		end if;
	
	end process;

		alu_out <= alu_out_sig;

	zero <= '1' when alu_out_sig = "0000000000000000" else '0';

	--carry_when_pos <= '1' when alu_a(15) = '0' and alu_b(15) = '0' and (alu_a(14 downto 0) > alu_out_sig(14 downto 0)) else
		--'0';
	--carry_when_neg <= '1' when alu_a(15) = '1' and alu_b(15) = '1' and (alu_a(15 downto 0) > alu_out_sig(15 downto 0)) else
		--'0';
		
		--carry <= '1' when carry_when_neg = '1' or carry_when_pos = '1' else '0';
		tmp <= ('0' & alu_a) + ('0' & alu_b);
		carry <= tmp(16);

end architecture ; -- alu
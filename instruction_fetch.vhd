library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity instruction_fetch is
  port (
	clk : in std_logic;

	--Tells if the next PC should be PC+1 or some other complicated thing
	pc_normal : in std_logic;
	--Control signals to the MUX given to PC_in in case of a complicated logic
	--00 - alu1_out 
	--01 - alu2_out
	--10 - mem_data_out (Different from the register out)
	pc_select : in std_logic_vector(2 downto 0);
	--Enable pin for PC register 
	pc_register_enable : in std_logic;

	--enable pin for IR
	ir_enable : in std_logic;

	--16 bits coming from memory
	mem_data_out : in std_logic_vector(15 downto 0);

	--16 bits coming from alu1_out
	alu1_out : in std_logic_vector(15 downto 0);

	--16 bits coming in from alu2 - PC + 6 bit imm
	alu2_out : in std_logic_vector(15 downto 0);

	--instruction coming out 
	instruction_int_out : out std_logic_vector(15 downto 0);

	--PC value going out (address of present instruction)
	pc_register_int : out std_logic_vector(15 downto 0)

  ) ;
end entity ; -- instruction_fetch

architecture arch of instruction_fetch is

	--PC register in and out 
	signal pc_register_in : std_logic_vector(15 downto 0);
	signal pc_register_out : std_logic_vector(15 downto 0);

	--instruction register in and out signals 
	signal instruction_reg_in : std_logic_vector(15 downto 0);
	signal instruction_reg_out : std_logic_vector(15 downto 0);

	--incrementer pc out 
	signal incrementer_pc_out : std_logic_vector(15 downto 0);


begin

	PC : process(clk)
	begin
		if (clk'event and clk = '1') then 
			if pc_normal = '1' then 
				pc_register_in <= incrementer_pc_out;
			end if;

			if pc_normal = '0' then 
				if pc_select = "00" then 
					pc_register_in <= alu1_out;
				end if;
				if pc_select = "01" then 
					pc_register_in <= alu2_out;
				end if;
				if pc_select = "10" then 
					pc_register_in <= mem_data_out;
				end if;
			end if;
		end if;
		
	end process ; -- PC

	pc_reg : register_16
		port map (
			reg_data_in => pc_register_in,
			reg_enable => pc_register_enable,
			clk => clk,
			reg_data_out => pc_register_out
		);

	incrementer : incrementer_pc 
		port map (
			incrementer_pc_in => pc_register_out,
			incrementer_pc_out => incrementer_pc_out
		);

	InstructionMemory : instruction_memory
		port map (
			address_in => pc_register_out,
			instruction_out => instruction_reg_in
		);

	InstructionRegister : register_16 
		port map (
			reg_data_in => instruction_reg_in,
			reg_enable => ir_enable,
			clk => clk,
			reg_data_out => instruction_int_out
		);
	pc_register_int <= pc_register_out;

end architecture ; -- arch
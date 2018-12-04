library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity instruction_fetch is
  port (
	clk : in std_logic;

	reset: in std_logic;
	--Tells if the next PC should be PC+1 or some other complicated thing
	--pc_normal : in std_logic;
	--Control signals to the MUX given to PC_in in case of a complicated logic
	--00 - alu1_out 
	--01 - alu2_out
	--10 - mem_data_out (Different from the register out)
	--11 - PC+1
	pc_select : in std_logic_vector(1 downto 0);
	--Enable pin for PC register 

	stall_if : in std_logic;

	--enable pin for IR
	--ir_enable : in std_logic;

	--16 bits coming from memory
	mem_data_out : in std_logic_vector(15 downto 0);

	--16 bits coming from alu1_out
	alu1_out : in std_logic_vector(15 downto 0);

	--16 bits coming in from alu2 - PC + 6 bit imm
	alu2_out : in std_logic_vector(15 downto 0);

	--instruction coming out 
	instruction_int_out : out std_logic_vector(15 downto 0);

	--PC value going out (address of present instruction)
	pc_register_int_out : out std_logic_vector(15 downto 0);

	valid_bit : out std_logic;

	------------------------------------------------------------------input pins for flushing------------------------------------------------------------------
	stall_from_rr : in std_logic;
	lw_lhi_dep_done : in std_logic;

	----------------------beq--------------------------
	pc_imm_from_ex : in std_logic_vector(15 downto 0);
	beq_taken : in std_logic


  ) ;
end entity ; -- instruction_fetch

architecture arch of instruction_fetch is

	--PC register in and out 
	signal pc_register_in : std_logic_vector(15 downto 0);
	signal pc_register_out : std_logic_vector(15 downto 0);

	--instruction register in and out signals 
	signal instruction_reg_in : std_logic_vector(15 downto 0);

	--incrementer pc out 
	signal incrementer_pc_out : std_logic_vector(15 downto 0);

	signal enables_the_reg_if_one : std_logic;
	signal valid_bit_signal : std_logic;

	signal ir_enable : std_logic;


begin
---------------------------beq--------------------------------------
	process(clk, reset, beq_taken, pc_imm_from_ex)
	begin 
		if reset = '1' then 
			valid_bit_signal <= '1';
		elsif beq_taken = '1' then 
			valid_bit_signal <= '1';
		else 
			valid_bit_signal <= '0';
		end if;
	end process;

	------------------------------beq--------------------------------

	PC : process(clk, incrementer_pc_out, mem_data_out, pc_select, alu1_out, alu2_out)
	begin
		if reset = '1' then
			pc_register_in <= "0000000000000000";
		-- reset = 0 
		elsif pc_select = "00" then 
			pc_register_in <= alu1_out;
		elsif pc_select = "01" then 
			pc_register_in <= pc_imm_from_ex;
		elsif pc_select = "10" then 
			pc_register_in <= mem_data_out;
		else -- pc_select = 11 and reset = 0
			pc_register_in <= incrementer_pc_out;
		end if;

	end process ; -- PC

	ir_enable <= enables_the_reg_if_one;


	--pc_reg : register_16
	--	port map (
	--		reg_data_in => pc_register_in,
	--		reg_enable => pc_register_enable,
	--		clk => clk,
	--		reg_data_out => pc_register_out
	--	);
	enableregister : process(clk,ir_enable, stall_if,stall_from_rr,lw_lhi_dep_done)
	begin
		if reset = '1' then 
			enables_the_reg_if_one <= '1';
		elsif stall_from_rr = '1' and lw_lhi_dep_done = '0' then
			enables_the_reg_if_one <= '0';
		elsif stall_from_rr = '1' and lw_lhi_dep_done = '1' then
			enables_the_reg_if_one <= '1';
		elsif stall_if = '1' then
			enables_the_reg_if_one <= '0';
		else 
			enables_the_reg_if_one <= '1';
		end if;
	end process ; -- enableregister
	--enables_the_reg_if_one <= (ir_enable and (not stall_if) and (not stall_from_rr));

	incrementer : incrementer_pc 
		port map (
			incrementer_pc_in => pc_register_out,
			incrementer_pc_out => incrementer_pc_out
		);

	InstructionMemory : instruction_memory
		port map (
			address_in => pc_register_in,
			instruction_out => instruction_reg_in
		);

	InstructionRegister : register_16 
		port map (
			reg_data_in => instruction_reg_in,
			reg_enable => enables_the_reg_if_one,
			clk => clk,
			reg_data_out => instruction_int_out
		);

	PC_int_Register : register_16 
		port map (
			reg_data_in => pc_register_in,
			reg_enable => enables_the_reg_if_one,
			clk => clk,
			reg_data_out => pc_register_out
		);

	valid_bit_reg : register_1
		port map(
			reg_data_in => valid_bit_signal,
			reg_enable => enables_the_reg_if_one,
			clk => clk,
			reg_data_out => valid_bit
		);
	
		pc_register_int_out <= pc_register_out;
end architecture ; -- arch
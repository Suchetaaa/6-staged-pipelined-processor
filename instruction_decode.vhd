library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity instruction_decode is
  port (
	clk : in std_logic;
	reset : in std_logic;

	--PC (address of the present instruction given by IF stage)
	pc_register_int_out : in std_logic_vector(15 downto 0);

	--instruction 
	instruction_int_out : in std_logic_vector(15 downto 0);

	--Tells what operation has to be performed by ALU1
	--00 - Addition 
	--01 - Subtraction 
	--10 - NAND
	alu1_op : out std_logic_vector(1 downto 0);
	--Select signals for alu1 - a
	--0 - D1
	--1 - D2
	alu1_a_select : out std_logic_vector(0 downto 0);
	--0 - D2
	--1 - SE6
	alu1_b_select : out std_logic_vector(0 downto 0);

	--alu2 - b select
	alu2_b_select : out std_logic_vector(1 downto 0);

	--Register File 
	rf_write : out std_logic;
	--Tells if A1 has to be read 
	rf_a1_read : out std_logic;
	--Tells if A2 has to be read
	rf_a2_read : out std_logic;
	--address of the register to which writing is taking place
	rf_a3 : out std_logic_vector(2 downto 0);
	--selection signals for data which is to be written back to RF 
	rf_data_select : out std_logic_vector(2 downto 0);

	--Memory 
	mem_write : out std_logic;
	mem_read : out std_logic;
	mem_data_sel : out std_logic;
	mem_address_sel : out std_logic;

	--RA
	ir_11_9 : out std_logic_vector(2 downto 0);
	--RB
	ir_8_6 : out std_logic_vector(2 downto 0);
	--RC
	ir_5_3 : out std_logic_vector(2 downto 0);
	--After sign extensions 6 and 9 respectively
	ir_5_0 : out std_logic_vector(15 downto 0);
	ir_8_0 : out std_logic_vector(15 downto 0);
	--Data coming out of data extender block 
	data_extender_out : out std_logic_vector(15 downto 0);

	--Carry and zero enables
	carry_en : out std_logic;
	zero_en_alu : out std_logic;
	zero_en_mem : out std_logic;

	--Other stuff 
	cz : out std_logic_vector(1 downto 0);
	opcode : out std_logic_vector(3 downto 0);

	--LM/SM signals 
	lm_detect : out std_logic;
	sm_detect : out std_logic;

	lw_sw_stop : out std_logic;

	first_lw_sw : out std_logic;

	right_shift_lm_sm_bit : out std_logic;

	lm_sm_reg_write : out std_logic_vector(2 downto 0);

	lm_sm_write_load : out std_logic;

	--alu2_out to IF stage
	alu2_out : out std_logic_vector(15 downto 0)

  ) ;
end entity ; -- instruction_decode

architecture arch of instruction_decode is

	signal alu2_a : std_logic_vector(15 downto 0);
	signal alu2_b : std_logic_vector(15 downto 0);
	--Has the PC + Imm value always
	signal alu2_out_signal : std_logic_vector(15 downto 0);

	signal se6_out : std_logic_vector(15 downto 0);

	signal se9_out : std_logic_vector(15 downto 0);

	--LM signals 
	signal first_later_check_in : std_logic;
	signal first_later_check_out : std_logic;
	signal first_later_check_enable : std_logic;

	--XOR signals 
	signal xor_1_in : std_logic_vector(7 downto 0);
	signal xor_2_in : std_logic_vector(7 downto 0);
	signal xor_out : std_logic_vector(7 downto 0);
	signal xor_reg_out : std_logic_vector(7 downto 0);

	--Right shift signals 
	signal right_shift_in : std_logic_vector(7 downto 0);
	signal right_shift_out : std_logic_vector(7 downto 0);
	signal right_shift_reg_out : std_logic_vector(7 downto 0);

	--Priotity encoder signals 
	signal priority_enc_in : std_logic_vector(7 downto 0);
	signal priority_enc_out : std_logic_vector(7 downto 0);
	signal priority_enable : std_logic;

begin

	alu2_a <= pc_register_int;

	alu2_b <= se6_out when alu2_b_select = "0" else 
		se9_out when alu2_b_select = "1";

	alu2_out <= alu2_out_signal;

	--0000 - ADD, ADC, ADZ, 
	--0001 - ADI
	--0100 - LW
	--0101 - SW
	--0110 - lm
	--0111 - sm

	--00 - ADDITION 
	--01 - SUBTRACTION 
	--10 - NAND
	alu1_op <= "00" when instruction_int_out(15 downto 12) = "0000" or instruction_int_out(15 downto 12) = "0001" or instruction_int_out(15 downto 12) = "0100" or instruction_int_out(15 downto 12) = "0101" or instruction_int_out(15 downto 12) = "0110" or instruction_int_out(15 downto 12) = "0111" else 
		--BEQ instruction
		"01" when instruction_int_out(15 downto 12) = "1100" else 
		--NAND instruction
		"10" when instruction_int_out(15 downto 12) = "0010" else

		"11";

	--0 - Data1 
	--1 - Data2
	alu1_a_select <= '0' when instruction_int_out(15 downto 12) = "0000" or instruction_int_out(15 downto 12) = "0001" or instruction_int_out(15 downto 12) = "0010" or instruction_int_out(15 downto 12) = "0110" or instruction_int_out(15 downto 12) = "0111" or instruction_int_out(15 downto 12) = "1100" else 
		'1';

	--00 - Data2
	--01 - SE6 out
	--10 - constant 1
	--11 - constant 0
	alu2_b_select <= "00" when instruction_int_out(15 downto 12) = "0000" or instruction_int_out(15 downto 12) = "0010"  or instruction_int_out(15 downto 12) = "1100" else 
		"01" when instruction_int_out(15 downto 12) = "0001" or instruction_int_out(15 downto 12) = "0100" or instruction_int_out(15 downto 12) = "0101" else 
		"10" when instruction_int_out(15 downto 12) = "0110" or instruction_int_out(15 downto 12) = "0111" else 
		"11";


	--Register file read and write, write to where, data from where 
	rf_a1_read <= '1' when instruction_int_out(15 downto 12) = "0000" or instruction_int_out(15 downto 12) = "0001" or instruction_int_out(15 downto 12) = "0010" or instruction_int_out(15 downto 12) = "0101" or instruction_int_out(15 downto 12) = "0110" or instruction_int_out(15 downto 12) = "0111" or instruction_int_out(15 downto 12) = "1100" else 
		'0';

	rf_a2_read <= '1' when instruction_int_out(15 downto 12) = "0000" or instruction_int_out(15 downto 12) = "0010" or instruction_int_out(15 downto 12) = "0100" or instruction_int_out(15 downto 12) = "0101" or instruction_int_out(15 downto 12) = "1100" or instruction_int_out(15 downto 12) = "1001" else 
		'0';

	--Tells where data has to be written 
	--RC 
	rf_a3 <= instruction_int_out(5 downto 3) when instruction_int_out(15 downto 12) = "0000" or instruction_int_out(15 downto 12) = "0010" else 
		--RA
		instruction_int_out(11 downto 9) when instruction_int_out(15 downto 12) = "0011" or instruction_int_out(15 downto 12) = "0100" or instruction_int_out(15 downto 12) = "1000" or instruction_int_out(15 downto 12) = "1001" or  else 
		--RB
		instruction_int_out(8 downto 6) when instruction_int_out(15 downto 12) = "0001" else 
		--Decoder output which gives the register to which data is written for LM/SM
		decoder_out when instruction_int_out(15 downto 12) = "0110" else 
		"1111"; -- for rf_write = 0

	--Tells what data has to be written 
	--000 - alu1_out
	--001 - data_extender_out
	--010 - memory_out
	--011 - pc 
	rf_data_select <= "000" when instruction_int_out(15 downto 12) = "0000" or instruction_int_out(15 downto 12) = "0001" or instruction_int_out(15 downto 12) = "0010" else
		"001" when instruction_int_out(15 downto 12) = "0011" else 
		"010" when instruction_int_out(15 downto 12) = "0100" or instruction_int_out(15 downto 12) = "0110" else 
		"011" when instruction_int_out(15 downto 12) = "1000" or instruction_int_out(15 downto 12) = "1001" else 
		"100";

	--rf_write
	rf_write <= '1' when instruction_int_out(15 downto 12) = "0000" or instruction_int_out(15 downto 12) = "0001" or instruction_int_out(15 downto 12) = "0010" or instruction_int_out(15 downto 12) = "0011" or instruction_int_out(15 downto 12) = "0100" or instruction_int_out(15 downto 12) = "0110" or instruction_int_out(15 downto 12) = "1000" or instruction_int_out(15 downto 12) = "1001" else 
		'0';

	--Memory read and write signals 
	mem_read <= '1' when instruction_int_out(15 downto 12) = "0100" or instruction_int_out(15 downto 12) = "0110" else 
		'0';
	mem_write <= '1' when instruction_int_out(15 downto 12) = "0101" or instruction_int_out(15 downto 12) = "0111" else
		'0';
	--memory address and data select pins
	--0 - ALU1_out
	--1 - Not yet decided 
	mem_address_sel <= '0';
	--0 - Data1
	--1 - not yet decided
	mem_data_sel <= '0'; 

	--Carry and zero enable 
	carry_en <= '1' when instruction_int_out(15 downto 12) = "0000" or instruction_int_out(15 downto 12) = "0001" else 
		'0';

	zero_en_alu <= '1' when instruction_int_out(15 downto 12) = "0000" or instruction_int_out(15 downto 12) = "0001" or instruction_int_out(15 downto 12) = "0010" else 
		'0';

	zero_en_mem <= '1' when instruction_int_out(15 downto 12) = "0100" else 
		'0';

	--Instruction values 
	ir_8_0 <= se9_out;
	ir_5_0 <= se6_out;
	--RA
	ir_11_9 <= instruction_int_out(11 downto 9); 
	--RB 
	ir_8_6 <= instruction_int_out(8 downto 6);
	--RC 
	ir_5_3 <= instruction_int_out(5 downto 3);

	--Other stuff 
	cz <= instruction_int_out(1 downto 0);
	opcode <= instruction_int_out(15 downto 12);

	--LM signals 
	lm_detect <= '1' when instruction_int_out(15 downto 12) = "0110" else 
		0;

	lw_sw_stop <= '1' when xor_reg_out = "00000000" and first_later_check_out = '1' else 
		'0';

	--Right shift signals 
	right_shift_in <= instruction_int_out(7 downto 0) when first_later_check_out = '0' else 
		right_shift_reg_out;

	--First later check tells if it is the first stage LM is encountered
	first_later_check_in <= '1' when instruction_int_out(15 downto 12) = "0110";

	if reset = '1' then 
		xor_reg_out <= "00000000";
		priority_enc_out <= "00000000"; 
	end if;

	--XOR in signals 
	xor_1_in <= instruction_int_out(7 downto 0) when first_later_check_out = '0' else 
		xor_reg_out;
	xor_2_in <= priority_enc_out;

	--Priority encoder in and enable signals 
	priority_enc_in <= instruction_int_out(7 downto 0) when first_later_check_out = '0' else 
		xor_reg_out;

	priority_enable <= instruction_int_out(0) when first_later_check_out = '0' else 
		right_shift_reg_out(0);

	--Port mapping 

	decoder_wb : decoder 
		port map (
			decoder_in => priority_enc_out, 
			decoder_out => lm_sm_reg_write
		);

	rightshift : right_shift
		port map (
			right_shift_in => right_shift_in,
			right_shift_out => right_shift_out
		);

	priorityencoder : priority_encoder 
		port map (
			priority_in => priority_enc_in,
			priority_enable => priority_enable,
			priority_out => priority_enc_out
		);

	xor_register : register_8 
		port map (
			reg_data_in => xor_out,
			reg_enable => priority_enable,
			clk => clk,
			reg_data_out => xor_reg_out
		);

	right_shift_reg : register_8 
		port map (
			reg_data_in => right_shift_out,
			reg_enable => '1',
			clk => clk,
			reg_data_out => right_shift_reg_out
		);


	signextend_6 : se6 
		port map (
			se6_in => instruction_int_out(5 downto 0),
			se6_out => se6_out
		);

	signextend_9 : se9 
		port map (
			se9_in => instruction_int_out(8 downto 0),
			se9_out => se9_out
		);

	alu_pc_imm : alu2 
		port map (
			alu2_a => alu2_a,
			alu2_b => alu2_b,
			alu2_out => alu2_out_signal
		);

	de : data_extender 
		port map (
			data_extender_in => instruction_int_out(8 downto 0),
			data_extender_out => data_extender_out
		);

	first_later : register_1 
		port map (
			reg_data_in => first_later_check_in,
			reg_enable => first_later_check_enable,
			clk => clk,
			reg_data_out => first_later_check_out
		);

end architecture ; -- arch






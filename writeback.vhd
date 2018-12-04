library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity write_back is
  port (
	clk : in std_logic;
	reset: in std_logic;
    
  mem_data_out : in std_logic_vector(15 downto 0);
  --from alu-out
  alu1_out_wb : in std_logic_vector(15 downto 0);
  alu1_carry_wb : in std_logic;
  alu1_zero_wb : in std_logic;
  cond_carry_wb : in std_logic;
  cond_zero_wb : in std_logic;

  --Carry forward signals 
  data_ra_wb : in std_logic_vector(15 downto 0);
  data_rb_wb : in std_logic_vector(15 downto 0);
  pc_out_wb : in std_logic_vector(15 downto 0);
  rf_write_wb : std_logic;
  rf_a3_wb : in std_logic_vector(2 downto 0);
  rf_data_select_wb : in std_logic_vector(2 downto 0);
  --mem_write_wb : in std_logic;
  --mem_read_wb : in std_logic;
  --mem_data_sel_wb : in std_logic;
  --mem_address_sel_wb : in std_logic;
  --ir_5_0_wb : in std_logic_vector(15 downto 0);
  --ir_8_0_wb : in std_logic_vector(15 downto 0);
  data_extender_out_wb : in std_logic_vector(15 downto 0);
  carry_en_wb : in std_logic;
  zero_en_alu_wb : in std_logic;
  zero_en_mem_wb : in std_logic;
  cz_wb : in std_logic_vector(1 downto 0);
  opcode_wb : in std_logic_vector(3 downto 0);
  lm_detect_wb : in std_logic;
  sm_detect_wb : in std_logic;
  lw_sw_stop_wb : in std_logic;
  first_lw_sw_wb : in std_logic;
  right_shift_lm_sm_bit_wb : std_logic;
  lm_sm_reg_wb : in std_logic_vector(2 downto 0);
  lm_sm_write_load_wb : in std_logic;
  alu2_out_wb : in std_logic_vector(15 downto 0);
  --Input signals from RF 
  rf_carry_reg_out : in std_logic;
  rf_zero_reg_out : in std_logic;


  --------------------------------------------stalling--------------------------------------------
  lw_lhi_dep_reg_wb : in std_logic;

  --------------------------------------------stalling--------------------------------------------

  --Output signals 
  --Going to RF or RR block 
  --All these signals should NOT come out of register but as normal signals 
  rf_write_final : out std_logic;
  carry_en_final : out std_logic;
  zero_en_final : out std_logic;
  carry_val_final : out std_logic;
  zero_val_final : out std_logic;
  rf_data_final : out std_logic_vector(15 downto 0);
  rf_a3_final : out std_logic_vector(2 downto 0);

  --------------------------------------------stalling--------------------------------------------
  --going as a signal
  lw_lhi_dep_done : out std_logic;

  --------------------------------------------stalling--------------------------------------------
  ----------------------------data hazards-------------------------
  rf_a3_from_wb : out std_logic_vector(2 downto 0);
  opcode_from_wb : out std_logic_vector(3 downto 0);
  alu1_out_from_wb : out std_logic_vector(15 downto 0);

  ------------------beq-------------------------

  valid_bit_mem_wb : in std_logic;
  valid_bit_id_mem_wb : in std_logic;
  valid_bit_or_mem_wb : in std_logic


  ) ;
end entity ; -- instruction_fetch

architecture arch of write_back is

begin

	process(clk, reset, lw_lhi_dep_reg_wb)
	begin 
		if reset = '1' then 
			lw_lhi_dep_done <= '0'; 
		elsif lw_lhi_dep_reg_wb = '1' then
			lw_lhi_dep_done <= '1';
		else 
			lw_lhi_dep_done <= '0';
		end if; 
	end process;

	final_write_signal : process(clk, rf_carry_reg_out, rf_zero_reg_out, alu1_carry_wb, alu1_zero_wb, right_shift_lm_sm_bit_wb, data_extender_out_wb, pc_out_wb, alu1_out_wb, mem_data_out)
	begin
		--ADC  
		if opcode_wb = "0000" and cz_wb = "10" then 
			rf_write_final <=  (rf_carry_reg_out and valid_bit_mem_wb and valid_bit_or_mem_wb and valid_bit_id_mem_wb);
			carry_en_final <= (rf_carry_reg_out and valid_bit_mem_wb and valid_bit_or_mem_wb and valid_bit_id_mem_wb);
			zero_en_final <= (rf_carry_reg_out and valid_bit_mem_wb and valid_bit_or_mem_wb and valid_bit_id_mem_wb);
			carry_val_final <= alu1_carry_wb;
			zero_val_final <= alu1_zero_wb;
		--ADZ
		elsif opcode_wb = "0000" and cz_wb = "01" then 
			rf_write_final <= (rf_zero_reg_out and valid_bit_mem_wb and valid_bit_or_mem_wb and valid_bit_id_mem_wb);
			carry_en_final <= (rf_zero_reg_out and valid_bit_mem_wb and valid_bit_or_mem_wb and valid_bit_id_mem_wb);
			zero_en_final <= (rf_zero_reg_out and valid_bit_mem_wb and valid_bit_or_mem_wb and valid_bit_id_mem_wb);
			carry_val_final <= alu1_carry_wb;
			zero_val_final <= alu1_zero_wb;
		--NDC
		elsif opcode_wb = "0010" and cz_wb = "10" then
			rf_write_final <= (rf_carry_reg_out and valid_bit_mem_wb and valid_bit_or_mem_wb and valid_bit_id_mem_wb);
			zero_en_final <= (rf_carry_reg_out and valid_bit_mem_wb and valid_bit_or_mem_wb and valid_bit_id_mem_wb);
			carry_en_final <= '0';
			zero_val_final <= alu1_zero_wb;
			carry_val_final <= '0';
		--NDZ
		elsif opcode_wb = "0010" and cz_wb = "01" then
			rf_write_final <= (rf_zero_reg_out and valid_bit_mem_wb and valid_bit_or_mem_wb and valid_bit_id_mem_wb);
			zero_en_final <= (rf_zero_reg_out and valid_bit_mem_wb and valid_bit_or_mem_wb and valid_bit_id_mem_wb);
			carry_en_final <= '0';
			zero_val_final <= alu1_zero_wb;
			carry_val_final <= '0';
		--LM SM done 
		elsif (opcode_wb = "0110" or opcode_wb = "0111") then 
			rf_write_final <= (right_shift_lm_sm_bit_wb and valid_bit_mem_wb and valid_bit_or_mem_wb and valid_bit_id_mem_wb);
			zero_en_final <= '0';
			carry_en_final <= '0';
			carry_val_final <= '0';
			zero_val_final <= '0';
		elsif (opcode_wb = "0100" and mem_data_out = "0000000000000000") then
			rf_write_final <= '1';
			carry_en_final <= '0';
			zero_en_final <= '1';
			carry_val_final <= '0';
			zero_val_final <= '1';
		else 
			rf_write_final <= (rf_write_wb and valid_bit_mem_wb and valid_bit_or_mem_wb and valid_bit_id_mem_wb);
			carry_en_final <= (carry_en_wb and valid_bit_mem_wb and valid_bit_or_mem_wb and valid_bit_id_mem_wb);
			zero_en_final <= ((zero_en_mem_wb or zero_en_alu_wb) and valid_bit_mem_wb and valid_bit_or_mem_wb and valid_bit_id_mem_wb);
			zero_val_final <= alu1_zero_wb;
			carry_val_final <= alu1_carry_wb;
		end if;
		
		if rf_data_select_wb = "000" then 
			rf_data_final <= alu1_out_wb;
		elsif rf_data_select_wb = "001" then
			rf_data_final <= data_extender_out_wb;
		elsif rf_data_select_wb = "010" then
			rf_data_final <= mem_data_out;
		elsif rf_data_select_wb = "011" then
			rf_data_final <= pc_out_wb;
		end if;

		rf_a3_final <= rf_a3_wb; 

	end process ; 

	
	-----------------data hazards-----------------------
	rf_a3_from_wb <= rf_a3_wb;
	opcode_from_wb <= opcode_wb;
	alu1_out_from_wb <= alu1_out_wb;

	





end architecture ; -- arch
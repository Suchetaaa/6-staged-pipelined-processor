library std;
library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity top_level is
  port(
    clk : in std_logic;
    reset: in std_logic;

    external_r0 : std_logic_vector(15 downto 0);
    external_r1 : std_logic_vector(15 downto 0);
    external_r2 : std_logic_vector(15 downto 0);
    external_r3 : std_logic_vector(15 downto 0);
    external_r4 : std_logic_vector(15 downto 0);
    external_r5 : std_logic_vector(15 downto 0);
    external_r6 : std_logic_vector(15 downto 0);
    external_r7 : std_logic_vector(15 downto 0)
  );
end entity;
architecture at of top_level is	
  
  -- stage 1 to 2
  signal pc_if_id : std_logic_vector(15 downto 0);
  signal ir_if_id : std_logic_vector(15 downto 0);
  signal stall_if : std_logic;
  signal valid_bit : std_logic;
  -- stage 2 to 3
  signal alu2_out : std_logic_vector(15 downto 0);
  signal pc_out : std_logic_vector(15 downto 0);
  signal alu1_op : std_logic_vector(1 downto 0);
  signal alu1_a_select : std_logic;
  signal alu1_b_select : std_logic_vector(1 downto 0);
  signal rf_write : std_logic;
  signal rf_a1_read : std_logic;
  signal rf_a2_read : std_logic;
  signal rf_a3 : std_logic_vector(2 downto 0);
  signal rf_data_select : std_logic_vector(2 downto 0);
  signal mem_write : std_logic;
  signal mem_read : std_logic;
  signal mem_data_sel : std_logic;
  signal mem_address_sel : std_logic;
  signal ir_11_9 : std_logic_vector(2 downto 0);
  signal ir_8_6 : std_logic_vector(2 downto 0);
  signal ir_5_3 : std_logic_vector(2 downto 0);
  signal ir_5_0 : std_logic_vector(15 downto 0);
  signal ir_8_0 : std_logic_vector(15 downto 0);
  signal data_extender_out : std_logic_vector(15 downto 0);
  signal carry_en : std_logic;
  signal zero_en_alu : std_logic;
  signal zero_en_mem : std_logic;
  signal cz : std_logic_vector(1 downto 0);
  signal opcode : std_logic_vector(3 downto 0);
  signal lm_detect : std_logic;
  signal sm_detect : std_logic;
  signal lw_sw_stop : std_logic;
  signal first_lw_sw : std_logic;
  signal right_shift_lm_sm_bit : std_logic;
  signal lm_sm_reg_write : std_logic_vector(2 downto 0);
  signal lm_sm_write_load : std_logic;
  signal valid_bit_id_or : std_logic;
  --Stage 3 to 4
  signal data_ra : std_logic_vector(15 downto 0);
  signal data_rb : std_logic_vector(15 downto 0);
  signal data_carry : std_logic;
  signal data_zero : std_logic;
  signal pc_out_ex : std_logic_vector(15 downto 0);
  signal alu1_op_ex : std_logic_vector(1 downto 0);
  signal alu1_a_select_ex : std_logic;
  signal alu1_b_select_ex : std_logic_vector(1 downto 0);
  signal rf_write_ex : std_logic;
  signal rf_a3_ex : std_logic_vector(2 downto 0);
  signal rf_data_select_ex : std_logic_vector(2 downto 0);
  signal mem_write_ex : std_logic;
  signal mem_read_ex : std_logic;
  signal mem_data_sel_ex : std_logic;
  signal mem_address_sel_ex : std_logic;
  signal ir_11_9_ex : std_logic_vector(2 downto 0);
  signal ir_8_6_ex : std_logic_vector(2 downto 0);
  signal ir_5_0_ex : std_logic_vector(15 downto 0);
  signal ir_8_0_ex : std_logic_vector(15 downto 0);
  signal data_extender_out_ex : std_logic_vector(15 downto 0);
  signal carry_en_ex : std_logic;
  signal zero_en_alu_ex : std_logic;
  signal zero_en_mem_ex : std_logic;
  signal cz_ex : std_logic_vector(1 downto 0);
  signal opcode_ex : std_logic_vector(3 downto 0);
  signal lm_detect_ex : std_logic;
  signal sm_detect_ex : std_logic;
  signal lw_sw_stop_ex : std_logic;
  signal first_lw_sw_ex : std_logic;
  signal right_shift_lm_sm_bit_ex : std_logic;
  signal lm_sm_reg_write_ex : std_logic_vector(2 downto 0);
  signal lm_sm_write_load_ex : std_logic;
  signal alu2_out_ex : std_logic_vector(15 downto 0);
  signal rf_carry_reg_out : std_logic;
  signal rf_zero_reg_out : std_logic;
  signal valid_bit_or_ex : std_logic;
  --Stage 4 to 5
  signal alu1_out_mem : std_logic_vector(15 downto 0); -- output of ALU
  signal alu1_carry_mem : std_logic;
  signal alu1_zero_mem : std_logic;
  signal cond_carry_mem : std_logic;
  signal cond_zero_mem : std_logic;
  signal lm_sm_adder_out : std_logic_vector(15 downto 0);

  --Output signals rom older stages 
  signal data_ra_mem : std_logic_vector(15 downto 0);
  signal data_rb_mem : std_logic_vector(15 downto 0);
  signal pc_out_mem : std_logic_vector(15 downto 0);
  signal rf_write_mem : std_logic;
  signal rf_a3_mem : std_logic_vector(2 downto 0);
  signal rf_data_select_mem : std_logic_vector(2 downto 0);
  signal mem_write_mem : std_logic;
  signal mem_read_mem : std_logic;
  signal mem_data_sel_mem : std_logic;
  signal mem_address_sel_mem : std_logic;
  signal ir_5_0_mem : std_logic_vector(15 downto 0);
  signal ir_8_0_mem : std_logic_vector(15 downto 0);
  signal data_extender_out_mem : std_logic_vector(15 downto 0);
  signal carry_en_mem : std_logic;
  signal zero_en_alu_mem : std_logic;
  signal zero_en_mem_mem : std_logic;
  signal cz_mem : std_logic_vector(1 downto 0);
  signal opcode_mem : std_logic_vector(3 downto 0);
  signal lm_detect_mem : std_logic; --LM/SM signals 
  signal sm_detect_mem : std_logic;
  signal lw_sw_stop_mem : std_logic;
  signal first_lw_sw_mem : std_logic;
  signal right_shift_lm_sm_bit_mem : std_logic;
  signal lm_sm_reg_write_mem : std_logic_vector(2 downto 0);
  signal lm_sm_write_load_mem : std_logic;
  signal alu2_out_mem : std_logic_vector(15 downto 0);   
  signal valid_bit_ex_mem : std_logic;
  --Stage 5 to 6
  signal mem_data_out : std_logic_vector(15 downto 0);
  signal alu1_out_wb : std_logic_vector(15 downto 0);
  signal alu1_carry_wb : std_logic;
  signal alu1_zero_wb : std_logic;
  signal cond_carry_wb : std_logic;
  signal cond_zero_wb : std_logic; 
  signal data_ra_wb : std_logic_vector(15 downto 0);
  signal data_rb_wb : std_logic_vector(15 downto 0);
  signal pc_out_wb : std_logic_vector(15 downto 0);
  signal rf_write_wb : std_logic;
  signal rf_a3_wb : std_logic_vector(2 downto 0);
  signal rf_data_select_wb : std_logic_vector(2 downto 0);
  --mem_write_wb : out std_logic;
  --mem_read_wb : out std_logic;
  --mem_data_sel_wb : out std_logic;
  --mem_address_sel_wb : out std_logic;
  --ir_5_0_wb : out std_logic_vector(15 downto 0);
  --ir_8_0_wb : out std_logic_vector(15 downto 0);
  signal data_extender_out_wb : std_logic_vector(15 downto 0);
  signal carry_en_wb : std_logic;
  signal zero_en_alu_wb : std_logic;
  signal zero_en_mem_wb : std_logic;
  signal cz_wb : std_logic_vector(1 downto 0);
  signal opcode_wb : std_logic_vector(3 downto 0);
  signal lm_detect_wb : std_logic;
  signal sm_detect_wb : std_logic;
  signal lw_sw_stop_wb : std_logic;
  signal first_lw_sw_wb : std_logic;
  signal right_shift_lm_sm_bit_wb : std_logic;
  signal lm_sm_reg_write_wb : std_logic_vector(2 downto 0);
  signal lm_sm_write_load_wb : std_logic;
  signal alu2_out_wb : std_logic_vector(15 downto 0);
  signal valid_bit_mem_wb : std_logic;
  signal lm_sm_reg_wb : std_logic_vector(2 downto 0);
  signal rf_write_final : std_logic;
  signal carry_en_final : std_logic;
  signal zero_en_final : std_logic;
  signal carry_val_final : std_logic;
  signal zero_val_final : std_logic;
  signal rf_data_final : std_logic_vector(15 downto 0);
  signal rf_a3_final : std_logic_vector(2 downto 0);

  --signal external_r0 : std_logic_vector(15 downto 0);
  --signal external_r1 : std_logic_vector(15 downto 0);
  --signal external_r2 : std_logic_vector(15 downto 0);
  --signal external_r3 : std_logic_vector(15 downto 0);
  --signal external_r4 : std_logic_vector(15 downto 0);
  --signal external_r5 : std_logic_vector(15 downto 0);
  --signal external_r6 : std_logic_vector(15 downto 0);
  --signal external_r7 : std_logic_vector(15 downto 0);


  -------------------stalling--------------------------
  signal lw_lhi_dep_reg_out : std_logic;
  signal lw_lhi_dep_reg_mem : std_logic;
  signal lw_lhi_dep_reg_wb : std_logic;
  signal stall_from_rr : std_logic;
  signal instruction_to_rr : std_logic_vector(15 downto 0);
  signal lw_lhi_dep_done : std_logic;

  --------------data hazards---------------------
  signal rf_a3_from_mem : std_logic_vector(2 downto 0);
  signal rf_a3_from_wb : std_logic_vector(2 downto 0);
  signal rf_a3_from_ex : std_logic_vector(2 downto 0);
  signal opcode_from_mem : std_logic_vector(3 downto 0);
  signal opcode_from_wb : std_logic_vector(3 downto 0);
  signal opcode_from_ex : std_logic_vector(3 downto 0);
  signal data_a_from_wb_ex : std_logic_vector(15 downto 0);
  signal data_b_from_wb_ex : std_logic_vector(15 downto 0);
  signal alu1_a_select_final : std_logic_vector(2 downto 0);
  signal alu1_b_select_final : std_logic_vector(2 downto 0);
  signal alu1_out_from_mem : std_logic_vector(15 downto 0);
  signal alu1_out_from_wb : std_logic_vector(15 downto 0);



begin
  if_stage : instruction_fetch
    port map (
      clk => clk,
      reset => reset,
      pc_select => "11",
      stall_if =>  stall_if,
		  stall_from_rr => stall_from_rr,
      lw_lhi_dep_done => lw_lhi_dep_done,
      --ir_enable => stall_from_rr,
      mem_data_out => "0000000000000000",
      alu1_out => "0000000000000000",
      alu2_out => alu2_out,
      instruction_int_out => ir_if_id,
      pc_register_int_out => pc_if_id,
      valid_bit => valid_bit
    ) ;

  id_stage : instruction_decode 
    port map (
      clk => clk, 
      reset => reset,
      pc_register_int_out => pc_if_id,
      instruction_int_out => ir_if_id,
      valid_bit => valid_bit,
      pc_out => pc_out,
      alu1_op => alu1_op,
      alu1_a_select => alu1_a_select,
      alu1_b_select => alu1_b_select,
      rf_write => rf_write,
      rf_a1_read => rf_a1_read,
      rf_a2_read => rf_a2_read,
      rf_a3 => rf_a3,
      rf_data_select => rf_data_select,
      mem_write => mem_write,
      mem_read => mem_read,
      mem_data_sel => mem_data_sel,
      mem_address_sel => mem_address_sel,
      ir_11_9 => ir_11_9,
      ir_8_6 => ir_8_6,
      ir_5_3 => ir_5_3,
      ir_5_0 => ir_5_0,
      ir_8_0 => ir_8_0,
      data_extender_out => data_extender_out,
      carry_en => carry_en,
      zero_en_alu => zero_en_alu,
      zero_en_mem => zero_en_mem,
      cz => cz,
      opcode => opcode,
      lm_detect => lm_detect,
      sm_detect => sm_detect,
      lw_sw_stop => lw_sw_stop,
      first_lw_sw => first_lw_sw,
      right_shift_lm_sm_bit => right_shift_lm_sm_bit,
      lm_sm_reg_write => lm_sm_reg_write,
      lm_sm_write_load => lm_sm_write_load,
      alu2_out => alu2_out,
      stall_if => stall_if,
		  stall_from_rr => stall_from_rr,
      valid_bit_id_or => valid_bit_id_or,
		  instruction_to_rr => instruction_to_rr,
      lw_lhi_dep_done => lw_lhi_dep_done
    ) ;

  operandread : operand_read 
    port map (
      clk => clk,
      reset => reset, 
      ---------------------- From ID Stage -----------------------------
      pc_out => pc_out,
      alu1_op => alu1_op,
      alu1_a_select => alu1_a_select,
      alu1_b_select => alu1_b_select,
      rf_write => rf_write,
      rf_a1_read => rf_a1_read,
      rf_a2_read => rf_a2_read,
      rf_a3 => rf_a3,
      rf_data_select => rf_data_select,
      mem_write => mem_write,
      mem_read => mem_read,
      mem_data_sel => mem_data_sel,
      mem_address_sel => mem_address_sel,
      ir_11_9 => ir_11_9,
      ir_8_6 => ir_8_6,
      ir_5_3 => ir_5_3,
      ir_5_0 => ir_5_0,
      ir_8_0 => ir_8_0,  
      data_extender_out => data_extender_out, --Data out from extender
      carry_en => carry_en,     --Carry and zero enables
      zero_en_alu => zero_en_alu,
      zero_en_mem => zero_en_mem,
      cz => cz,
      opcode => opcode, --
      lm_detect => lm_detect, --LM/SM signals 
      sm_detect => sm_detect,
      lw_sw_stop => lw_sw_stop,
      first_lw_sw => first_lw_sw,
      right_shift_lm_sm_bit => right_shift_lm_sm_bit,
      lm_sm_reg_write => lm_sm_reg_write,
      lm_sm_write_load => lm_sm_write_load,
      alu2_out => alu2_out, --alu2_out to IF stage
      valid_bit_id_or => valid_bit_id_or,
      ------------------ From Write Back Stage -----------------------------
      rf_write_final => rf_write_final, -- should actually come from wb stage
      carry_en_final => carry_en_final,
      zero_en_final => zero_en_final,
      carry_val_final => carry_val_final, 
      zero_val_final => zero_val_final,
      rf_data_final => rf_data_final,
      rf_a3_final => rf_a3_final,
      --------------------- Outputs -----------------------------------------
      -- the register values read 
      data_ra => data_ra,
      data_rb => data_rb,
      data_carry => data_carry,
      data_zero => data_zero,
      pc_out_ex => pc_out_ex,
      alu1_op_ex => alu1_op_ex,
      alu1_a_select_ex => alu1_a_select_ex,
      alu1_b_select_ex => alu1_b_select_ex,
      rf_write_ex => rf_write_ex,
      rf_a3_ex => rf_a3_ex,   
      rf_data_select_ex => rf_data_select_ex,
      mem_write_ex => mem_write_ex,
      mem_read_ex => mem_read_ex,
      mem_data_sel_ex => mem_data_sel_ex,
      mem_address_sel_ex => mem_address_sel_ex,
      ir_11_9_ex => ir_11_9_ex, 
      ir_8_6_ex => ir_8_6_ex, 
      ir_5_0_ex => ir_5_0_ex,
      ir_8_0_ex => ir_8_0_ex,
      data_extender_out_ex => data_extender_out_ex,
      carry_en_ex => carry_en_ex,
      zero_en_alu_ex => zero_en_alu_ex,
      zero_en_mem_ex => zero_en_mem_ex,
      cz_ex => cz_ex,
      opcode_ex => opcode_ex,
      lm_detect_ex => lm_detect_ex,
      sm_detect_ex => sm_detect_ex,
      lw_sw_stop_ex => lw_sw_stop_ex,
      first_lw_sw_ex => first_lw_sw_ex,
      right_shift_lm_sm_bit_ex => right_shift_lm_sm_bit_ex,
      lm_sm_reg_write_ex => lm_sm_reg_write_ex,
      lm_sm_write_load_ex => lm_sm_write_load_ex,
      alu2_out_ex => alu2_out_ex,
      rf_carry_reg_out => rf_carry_reg_out,
      rf_zero_reg_out => rf_zero_reg_out,
      valid_bit_or_ex => valid_bit_or_ex,

      external_r0 => external_r0, 
      external_r1 => external_r1, 
      external_r2 => external_r2, 
      external_r3 => external_r3, 
      external_r4 => external_r4, 
      external_r5 => external_r5, 
      external_r6 => external_r6, 
      external_r7 => external_r7, 

      --------------stalling--------------
      instruction_to_rr => instruction_to_rr,
		  lw_lhi_dep_reg_out => lw_lhi_dep_reg_out,
		  stall_from_rr => stall_from_rr,
      -------------data hazards ----------------
      rf_a3_from_mem => rf_a3_from_mem,
      rf_a3_from_wb => rf_a3_from_wb,
      rf_a3_from_ex => rf_a3_from_ex,
      opcode_from_mem => opcode_from_mem, 
      opcode_from_wb => opcode_from_wb,
      opcode_from_ex => opcode_from_ex,
      data_a_from_wb_ex => data_a_from_wb_ex,
      data_b_from_wb_ex => data_b_from_wb_ex,
      alu1_a_select_final => alu1_a_select_final,
      alu1_b_select_final => alu1_b_select_final,
		alu1_out_from_wb => alu1_out_from_wb
    );

  executestage : execute 
    port map (
      clk => clk,
      reset => reset,
      -- the register values read 
      data_ra => data_ra,
      data_rb => data_rb,
      data_carry => data_carry,
      data_zero => data_zero,
		  lm_sm_adder_out => lm_sm_adder_out,
      --signals coming from earlier stages 
      pc_out_ex => pc_out_ex,
      alu1_op_ex => alu1_op_ex,
      alu1_a_select_ex => alu1_a_select_ex,
      alu1_b_select_ex => alu1_b_select_ex,
      rf_write_ex => rf_write_ex,
      rf_a3_ex => rf_a3_ex,
      rf_data_select_ex => rf_data_select_ex,
      mem_write_ex => mem_write_ex,
      mem_read_ex => mem_read_ex,
      mem_data_sel_ex => mem_data_sel_ex,
      mem_address_sel_ex => mem_address_sel_ex,
      ir_11_9_ex => ir_11_9_ex, 
      ir_8_6_ex => ir_8_6_ex, 
      ir_5_0_ex => ir_5_0_ex, 
      ir_8_0_ex => ir_8_0_ex,  
      data_extender_out_ex => data_extender_out_ex,
      carry_en_ex => carry_en_ex,
      zero_en_alu_ex => zero_en_alu_ex,
      zero_en_mem_ex => zero_en_mem_ex,
      cz_ex => cz_ex, 
      opcode_ex => opcode_ex,
      lm_detect_ex => lm_detect_ex,
      sm_detect_ex => sm_detect_ex,
      lw_sw_stop_ex => lw_sw_stop_ex,
      first_lw_sw_ex => first_lw_sw_ex,
      right_shift_lm_sm_bit_ex => right_shift_lm_sm_bit_ex,
      lm_sm_reg_write_ex => lm_sm_reg_write_ex,
      lm_sm_write_load_ex => lm_sm_write_load_ex,
      alu2_out_ex => alu2_out_ex,
      valid_bit_or_ex => valid_bit_or_ex,
      --Output signals from this stage
      alu1_out_mem => alu1_out_mem,
      alu1_carry_mem => alu1_carry_mem,
      alu1_zero_mem => alu1_zero_mem,
      cond_carry_mem => cond_carry_mem,
      cond_zero_mem => cond_zero_mem,
      --Output signals rom older stages 
      data_ra_mem => data_ra_mem,
      data_rb_mem => data_rb_mem,
      pc_out_mem => pc_out_mem,
      rf_write_mem => rf_write_mem,
      rf_a3_mem => rf_a3_mem,
      rf_data_select_mem => rf_data_select_mem,
      mem_write_mem => mem_write_mem,
      mem_read_mem => mem_read_mem,
      mem_data_sel_mem => mem_data_sel_mem,
      mem_address_sel_mem => mem_address_sel_mem,
      ir_5_0_mem => ir_5_0_mem,
      ir_8_0_mem => ir_8_0_mem,
      data_extender_out_mem => data_extender_out_mem,
      carry_en_mem => carry_en_mem,
      zero_en_alu_mem => zero_en_alu_mem,
      zero_en_mem_mem => zero_en_mem_mem,
      cz_mem => cz_mem,
      opcode_mem => opcode_mem,
      lm_detect_mem => lm_detect_mem, --LM/SM signals 
      sm_detect_mem => sm_detect_mem,
      lw_sw_stop_mem => lw_sw_stop_mem,
      first_lw_sw_mem => first_lw_sw_mem,
      right_shift_lm_sm_bit_mem => right_shift_lm_sm_bit_mem,
      lm_sm_reg_write_mem => lm_sm_reg_write_mem,
      lm_sm_write_load_mem => lm_sm_write_load_mem,
      alu2_out_mem => alu2_out_mem, --alu2_in to IF stage
      valid_bit_ex_mem => valid_bit_ex_mem,
      -------------stalling------------
      lw_lhi_dep_reg_out => lw_lhi_dep_reg_out,
		  lw_lhi_dep_reg_mem => lw_lhi_dep_reg_mem,
      -----------data hazards---------------------
      alu1_a_select_final => alu1_a_select_final,
      alu1_b_select_final => alu1_b_select_final,
      data_a_from_wb_ex => data_a_from_wb_ex,
      data_b_from_wb_ex => data_b_from_wb_ex,
      alu1_out_from_mem => alu1_out_from_mem,
      alu1_out_from_wb => alu1_out_from_wb,
		opcode_from_ex => opcode_from_ex,
		rf_a3_from_ex => rf_a3_from_ex
    );

  memstageportmap : mem_access_stage 
    port map (
      clk => clk,
      reset => reset,
      --signals from previous stages 
      alu1_out_mem => alu1_out_mem, 
      alu1_carry_mem => alu1_carry_mem,
      alu1_zero_mem => alu1_zero_mem,
      cond_carry_mem => cond_carry_mem,
      cond_zero_mem => cond_zero_mem,
		  lm_sm_adder_out => lm_sm_adder_out,
      data_ra_mem => data_ra_mem,
      data_rb_mem => data_rb_mem,
      pc_out_mem => pc_out_mem,
      rf_write_mem => rf_write_mem,
      rf_a3_mem => rf_a3_mem,
      rf_data_select_mem => rf_data_select_mem,
      mem_write_mem => mem_write_mem,
      mem_read_mem => mem_read_mem,
      mem_data_sel_mem => mem_data_sel_mem,
      mem_address_sel_mem => mem_address_sel_mem,
  --    ir_5_0_mem : in std_logic_vector(15 downto 0);
  --    ir_8_0_mem : in std_logic_vector(15 downto 0);
      data_extender_out_mem => data_extender_out_mem,
      carry_en_mem => carry_en_mem,
      zero_en_alu_mem => zero_en_alu_mem,
      zero_en_mem_mem => zero_en_mem_mem,
      cz_mem => cz_mem,
      opcode_mem => opcode_mem,
      lm_detect_mem => lm_detect_mem,
      sm_detect_mem => sm_detect_mem,
      lw_sw_stop_mem => lw_sw_stop_mem,
      first_lw_sw_mem => first_lw_sw_mem,
      right_shift_lm_sm_bit_mem => right_shift_lm_sm_bit_mem,
      lm_sm_reg_write_mem => lm_sm_reg_write_mem,
      lm_sm_write_load_mem => lm_sm_write_load_ex,
      alu2_out_mem => alu2_out_mem,
      valid_bit_ex_mem => valid_bit_ex_mem,
      -----Outputs----
      mem_data_out => mem_data_out,
      alu1_out_wb => alu1_out_wb,
      alu1_carry_wb => alu1_carry_wb,
      alu1_zero_wb => alu1_zero_wb,
		  cond_carry_wb => cond_carry_wb,
      cond_zero_wb => cond_zero_wb,
      data_ra_wb => data_ra_wb,
      data_rb_wb => data_rb_wb,
      pc_out_wb => pc_out_wb,
      rf_write_wb => rf_write_wb,
      rf_a3_wb => rf_a3_wb,
      rf_data_select_wb => rf_data_select_wb,
      --mem_write_wb : out std_logic;
      --mem_read_wb : out std_logic;
      --mem_data_sel_wb : out std_logic;
      --mem_address_sel_wb : out std_logic;
      --ir_5_0_wb : out std_logic_vector(15 downto 0);
      --ir_8_0_wb : out std_logic_vector(15 downto 0);
      data_extender_out_wb => data_extender_out_wb,
      carry_en_wb => carry_en_wb,
      zero_en_alu_wb => zero_en_alu_wb,
      zero_en_mem_wb => zero_en_mem_wb,
      cz_wb => cz_wb,
      opcode_wb => opcode_wb,
      lm_detect_wb => lm_detect_wb,
      sm_detect_wb => sm_detect_wb,
      lw_sw_stop_wb => lw_sw_stop_wb,
      first_lw_sw_wb => first_lw_sw_wb,
      right_shift_lm_sm_bit_wb => right_shift_lm_sm_bit_wb,
      lm_sm_reg_write_wb => lm_sm_reg_write_wb,
      lm_sm_write_load_wb => lm_sm_write_load_wb,
      alu2_out_wb => alu2_out_wb,
      valid_bit_mem_wb => valid_bit_mem_wb,

      --------------stalling-----------------
      lw_lhi_dep_reg_mem => lw_lhi_dep_reg_mem,
		  lw_lhi_dep_reg_wb => lw_lhi_dep_reg_wb,

      -----------------data hazards----------------
      rf_a3_from_mem => rf_a3_from_mem,
      opcode_from_mem => opcode_from_mem,
      alu1_out_from_mem => alu1_out_from_mem
    );

  writeback : write_back 
    port map (
      clk  => clk ,
      reset => reset,
        
      mem_data_out => mem_data_out,
      --from alu-out
      alu1_out_wb => alu1_out_wb,
      alu1_carry_wb => alu1_carry_wb,
      alu1_zero_wb => alu1_zero_wb,
      cond_carry_wb => cond_carry_wb,
      cond_zero_wb => cond_zero_wb,

      --Carry forward signals 
      data_ra_wb => data_ra_wb,
      data_rb_wb => data_rb_wb,
      pc_out_wb => pc_out_wb,
      rf_write_wb => rf_write_wb,
      rf_a3_wb => rf_a3_wb,
      rf_data_select_wb => rf_data_select_wb,
      --mem_write_wb : in std_logic;
      --mem_read_wb : in std_logic;
      --mem_data_sel_wb : in std_logic;
      --mem_address_sel_wb : in std_logic;
      --ir_5_0_wb : in std_logic_vector(15 downto 0);
      --ir_8_0_wb : in std_logic_vector(15 downto 0);
      data_extender_out_wb => data_extender_out_wb,
      carry_en_wb => carry_en_wb,
      zero_en_alu_wb => zero_en_alu_wb,
      zero_en_mem_wb => zero_en_mem_wb,
      cz_wb => cz_wb,
      opcode_wb => opcode_wb,
      lm_detect_wb => lm_detect_wb,
      sm_detect_wb => sm_detect_wb,
      lw_sw_stop_wb => lw_sw_stop_wb,
      first_lw_sw_wb => first_lw_sw_wb,
      right_shift_lm_sm_bit_wb => right_shift_lm_sm_bit_wb,
      lm_sm_reg_wb => lm_sm_reg_wb,
      lm_sm_write_load_wb => lm_sm_write_load_wb,
      alu2_out_wb => alu2_out_wb,
      --Input signals from RF 
      rf_carry_reg_out => rf_carry_reg_out,
      rf_zero_reg_out => rf_zero_reg_out,
      valid_bit_mem_wb => valid_bit_mem_wb,
      --Output signals 
      --Going to RF or RR block 
      --All these signals should NOT come out of register but as normal signals 
      rf_write_final => rf_write_final,
      carry_en_final => carry_en_final,
      zero_en_final => zero_en_final,
      carry_val_final => carry_val_final,
      zero_val_final => zero_val_final,
      rf_data_final => rf_data_final,
      rf_a3_final => rf_a3_final,
      -----------stalling-------------
      lw_lhi_dep_reg_wb => lw_lhi_dep_reg_wb,
      lw_lhi_dep_done => lw_lhi_dep_done,

      --------------data hazards---------------
      rf_a3_from_wb => rf_a3_from_wb,
      opcode_from_wb => opcode_from_wb,
      alu1_out_from_wb => alu1_out_from_wb

      );



end architecture ; -- at
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
    data_ra : out std_logic_vector(15 downto 0);
    data_rb : out std_logic_vector(15 downto 0);
    data_carry : out std_logic;
    data_zero : out std_logic;
    pc_out_ex : out std_logic_vector(15 downto 0);
    alu1_op_ex : out std_logic_vector(1 downto 0);
    alu1_a_select_ex : out std_logic;
    alu1_b_select_ex : out std_logic;
    rf_write_ex : out std_logic;
    rf_a3_ex : out std_logic_vector(2 downto 0);
    rf_data_select_ex : out std_logic_vector(2 downto 0);
    mem_write_ex : out std_logic;
    mem_read_ex : out std_logic;
    mem_data_sel_ex : out std_logic;
    mem_address_sel_ex : out std_logic;
    ir_5_0_ex : out std_logic_vector(15 downto 0);
    ir_8_0_ex : out std_logic_vector(15 downto 0);
    data_extender_out_ex : out std_logic_vector(15 downto 0);
    carry_en_ex : out std_logic;
    zero_en_alu_ex : out std_logic;
    zero_en_mem_ex : out std_logic;
    cz_ex : out std_logic_vector(1 downto 0);
    opcode_ex : out std_logic_vector(3 downto 0);
    lm_detect_ex : out std_logic;
    sm_detect_ex : out std_logic;
    lw_sw_stop_ex : out std_logic;
    first_lw_sw_ex : out std_logic;
    right_shift_lm_sm_bit_ex : out std_logic;
    lm_sm_reg_write_ex : out std_logic_vector(2 downto 0);
    lm_sm_write_load_ex : out std_logic;
    alu2_out_ex : out std_logic_vector(15 downto 0)
  );
end entity;
architecture at of top_level is

  signal pc_if_id : std_logic_vector(15 downto 0);
  signal ir_if_id : std_logic_vector(15 downto 0);
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
  signal lm_sm_write_load : std_logic


begin
  if_stage : instruction_fetch
    port map (
      clk => clk,
      reset => reset,
      pc_select => "11",
      pc_register_enable =>  '1',
      ir_enable => '1',
      mem_data_out => "0000000000000000",
      alu1_out => "0000000000000000",
      alu2_out => alu2_out,
      instruction_int_out => ir_if_id,
      pc_register_int_out => pc_if_id
    ) ;

  id_stage : instruction_decode 
    port map (
      clk => clk, 
      reset => reset,
      pc_register_int_out => pc_if_id,
      instruction_int_out => ir_if_id,
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
      alu2_out => alu2_out
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
      alu2_out => alu2_out --alu2_out to IF stage
      ------------------ From Write Back Stage -----------------------------
      rf_write_final => rf_write, -- should actually come from wb stage
      carry_en_final => carry_en,
      zero_en_final => '1',
      carry_val_final => '1', 
      zero_val_final => '1',
      rf_data_final => "0000000000000000",
      rf_a3_final => "000",
      --------------------- Outputs -----------------------------------------
      -- the register values read 
      data_ra => data_ra;
      data_rb => data_rb,
      data_carry => data_carry;
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
      lm_sm_write_load_ex => lm_sm_reg_write_ex,
      alu2_out_ex => alu2_out_ex
    )

end architecture ; -- at
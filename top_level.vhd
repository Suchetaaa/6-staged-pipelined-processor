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

    pc_out : out std_logic_vector(15 downto 0);
    alu1_op : out std_logic_vector(1 downto 0);
    alu1_a_select : out std_logic;
    alu1_b_select : out std_logic_vector(1 downto 0);
    rf_write : out std_logic;
    rf_a1_read : out std_logic;
    rf_a2_read : out std_logic;
    rf_a3 : out std_logic_vector(2 downto 0);
    rf_data_select : out std_logic_vector(2 downto 0);
    mem_write : out std_logic;
    mem_read : out std_logic;
    mem_data_sel : out std_logic;
    mem_address_sel : out std_logic;
    ir_11_9 : out std_logic_vector(2 downto 0);
    ir_8_6 : out std_logic_vector(2 downto 0);
    ir_5_3 : out std_logic_vector(2 downto 0);
    ir_5_0 : out std_logic_vector(15 downto 0);
    ir_8_0 : out std_logic_vector(15 downto 0);
    data_extender_out : out std_logic_vector(15 downto 0);
    carry_en : out std_logic;
    zero_en_alu : out std_logic;
    zero_en_mem : out std_logic;
    cz : out std_logic_vector(1 downto 0);
    opcode : out std_logic_vector(3 downto 0);
    lm_detect : out std_logic;
    sm_detect : out std_logic;
    lw_sw_stop : out std_logic;
    first_lw_sw : out std_logic;
    right_shift_lm_sm_bit : out std_logic;
    lm_sm_reg_write : out std_logic_vector(2 downto 0);
    lm_sm_write_load : out std_logic
  );
end entity;
architecture at of top_level is

  signal pc_if_id : std_logic_vector(15 downto 0);
  signal ir_if_id : std_logic_vector(15 downto 0);
  signal alu2_out : std_logic_vector(15 downto 0);


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

end architecture ; -- at
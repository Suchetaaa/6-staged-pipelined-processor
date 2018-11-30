library std;
library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.components_init.all;
entity execute is 
  port(
    -- the register values read 
    data_ra : in std_logic_vector(15 downto 0)
    data_rb : in std_logic_vector(15 downto 0)
    data_carry : in std_logic;
    data_zero : in std_logic;
    -- signals to forward
    rf_write_ex : in std_logic;
    rf_a3_ex : in std_logic_vector(2 downto 0);
    alu1_op_ex : in std_logic_vector(1 downto 0);
    alu1_a_select_ex : in std_logic;
    alu1_b_select_ex : in std_logic_vector(1 downto 0);
    alu2_b_select_ex : in std_logic_vector(1 downto 0);
    rf_data_select_ex : in std_logic_vector(2 downto 0);
    mem_write_ex : in std_logic;
    mem_read_ex : in std_logic;
    mem_data_sel_ex : in std_logic;
    mem_address_sel_ex : in std_logic;
    ir_5_0_ex : in std_logic_vector(15 downto 0); -- Sign extended
    ir_8_0_ex : in std_logic_vector(15 downto 0); -- Sign extended 
    data_extender_in_ex : in std_logic_vector(15 downto 0); --Data for LHI
    carry_en_ex : in std_logic;     --Carry and zero enables
    zero_en_alu_ex : in std_logic;
    zero_en_mem_ex : in std_logic;
    cz_ex : in std_logic_vector(1 downto 0); -- 
    opcode_ex : in std_logic_vector(3 downto 0); --
    lm_detect_ex : in std_logic; --LM/SM signals 
    sm_detect_ex : in std_logic;
    lw_stop_ex : in std_logic;
    sw_stop_ex : in std_logic;
    first_lw_sw_ex : in std_logic;
    right_shift_lm_sm_bit_ex : in std_logic;
    lm_sm_reg_write_ex : in std_logic_vector(2 downto 0);
    alu2_in_ex : in std_logic_vector(15 downto 0) --alu2_in to IF stage
  );
end entity;
architecture arch of execute is
  signal 
begin
end architecture ; -- arch
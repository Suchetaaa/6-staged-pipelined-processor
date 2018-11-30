library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components_init.all;

enti

entity operand_read is
  port(
    -- clock and reset
    clk : in std_logic;
    reset : in std_logic;

    ---------------------- From ID Stage -----------------------------
    alu1_op : in std_logic_vector(1 downto 0);
    alu1_a_select : in std_logic_vector(0 downto 0);
    alu1_b_select : in std_logic_vector(0 downto 0);
    alu2_b_select : in std_logic_vector(1 downto 0);
    rf_write : in std_logic;
    rf_a1_read : in std_logic;
    rf_a2_read : in std_logic;
    rf_a3 : in std_logic_vector(2 downto 0);
    rf_data_select : in std_logic_vector(2 downto 0);
    mem_write : in std_logic;
    mem_read : in std_logic;
    mem_data_sel : in std_logic;
    mem_address_sel : in std_logic;
    ir_11_9 : in std_logic_vector(2 downto 0); -- Ra
    ir_8_6 : in std_logic_vector(2 downto 0); -- Rb
    ir_5_3 : in std_logic_vector(2 downto 0); -- Rc, Might be redundant ------------
    ir_5_0 : in std_logic_vector(15 downto 0); -- Sign extended
    ir_8_0 : in std_logic_vector(15 downto 0); -- Sign extended   
    data_extender_out : in std_logic_vector(15 downto 0); --Data out from extender
    carry_en : in std_logic;     --Carry and zero enables
    zero_en_alu : in std_logic;
    zero_en_mem : in std_logic;
    cz : in std_logic_vector(1 downto 0); -- 
    opcode : in std_logic_vector(3 downto 0); --
    lm_detect : in std_logic; --LM/SM signals 
    sm_detect : in std_logic;
    lw_stop : in std_logic;
    sw_stop : in std_logic;
    first_lw_sw : in std_logic;
    right_shift_lm_sm_bit : in std_logic;
    lm_sm_reg_write : in std_logic_vector(2 downto 0);
    alu2_out : in std_logic_vector(15 downto 0); --alu2_out to IF stage

    ------------------ From Execute Stage ----------------------------------
    -- the address of the write back reg (and if write back)
    rf_a3_ex_in : in std_logic_vector(2 downto 0);
    rf_write_ex_in : in std_logic;
    valid_bit_ex_in : in std_logic;
    if_write_back_from_alu : in std_logic;
    -- the carry and zero info, if editing them and the like 

    ------------------ From Memory Access Stage ---------------------------------
    -- the address of the write back reg (and if write back)
    rf_a3_mem_in : in std_logic_vector(2 downto 0);
    rf_write_mem_in : in std_logic;
    valid_bit_mem_in : in std_logic;

    ------------------ From Write Back Stage -----------------------------
    -- the address of the write back reg (and if write back)
    rf_a3_wb_in : in std_logic_vector(2 downto 0);
    rf_write_wb_in : in std_logic;
    valid_bit_wb_in : in std_logic;

    --------------------- Outputs -----------------------------------------

    -- the register values read 
    data_ra : out std_logic_vector(15 downto 0)
    data_rb : out std_logic_vector(15 downto 0)
    data_carry : out std_logic;
    data_zero : out std_logic;

    -- signals to forward
    rf_write_ex : out std_logic;
    rf_a3_ex : out std_logic_vector(2 downto 0);
    alu1_op_ex : out std_logic_vector(1 downto 0);
    alu1_a_select_ex : out std_logic_vector(0 downto 0);
    alu1_b_select_ex : out std_logic_vector(0 downto 0);
    alu2_b_select_ex : out std_logic_vector(1 downto 0);
    rf_data_select_ex : out std_logic_vector(2 downto 0);
    mem_write_ex : out std_logic;
    mem_read_ex : out std_logic;
    mem_data_sel_ex : out std_logic;
    mem_address_sel_ex : out std_logic;
    ir_5_0_ex : out std_logic_vector(15 downto 0); -- Sign extended
    ir_8_0_ex : out std_logic_vector(15 downto 0); -- Sign extended 
    data_extender_out_ex : out std_logic_vector(15 downto 0); --Data for LHI
    carry_en_ex : out std_logic;     --Carry and zero enables
    zero_en_alu_ex : out std_logic;
    zero_en_mem_ex : out std_logic;
    cz_ex : out std_logic_vector(1 downto 0); -- 
    opcode_ex : out std_logic_vector(3 downto 0); --
    lm_detect_ex : out std_logic; --LM/SM signals 
    sm_detect_ex : out std_logic;
    lw_stop_ex : out std_logic;
    sw_stop_ex : out std_logic;
    first_lw_sw_ex : out std_logic;
    right_shift_lm_sm_bit_ex : out std_logic;
    lm_sm_reg_write_ex : out std_logic_vector(2 downto 0);
    alu2_out_ex : out std_logic_vector(15 downto 0) --alu2_out to IF stage

  );
end entity;

architecture op_read of operand_read is

  signal ra_read_temp : std_logic_vector(15 downto 0);
  signal rb_read_temp : std_logic_vector(15 downto 0);
  signal carry_temp : std_logic;
  signal zero_temp : std_logic;

begin
  reg_access : reg_file 
    port map(
      --Clock 
      clk => clk,
      reset => reset,

      --Register file read and write signals 
      --1 corresponds to read and 0 nothing for both
      reg_file_read_ra => rf_a1_read,
      reg_file_read_rb => rf_a2_read,
      carry_read => '1',
      zero_read => '1',

      reg_file_write => , -- from WB stage
      carry_write => , -- from WB stage
      zero_write => , -- from WB stage


      address_1 => ir_11_9,
      --Address - 2 signal value 
      address_2 => ir_8_6,
      --Address - 3 signal value for writing to A3
      address_3 => , -- from WB stage

      --Data in and out signal values 
      data_in : in std_logic_vector(15 downto 0);  -- from WB stage
      carry_in : in std_logic;  -- from WB stage
      zero_in : in std_logic;  -- from WB stage

      data_out_ra => ra_read_temp,
      data_out_rb => rb_read_temp,
      carry_out => carry_temp,
      zero_out => zero_temp
    ) ;


end architecture ; -- op_read
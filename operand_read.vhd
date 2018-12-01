library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity operand_read is
  port(
    -- clock and reset
    clk : in std_logic;
    reset : in std_logic;
    ---------------------- From ID Stage -----------------------------
    pc_out : in std_logic_vector(15 downto 0);
    alu1_op : in std_logic_vector(1 downto 0);
    alu1_a_select : in std_logic;
    alu1_b_select : in std_logic_vector(1 downto 0);
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
    lw_sw_stop : in std_logic;
    first_lw_sw : in std_logic;
    right_shift_lm_sm_bit : in std_logic;
    lm_sm_reg_write : in std_logic_vector(2 downto 0);
    lm_sm_write_load : out std_logic;
    alu2_out : in std_logic_vector(15 downto 0); --alu2_out to IF stage
    
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
    pc_out_ex : out std_logic_vector(15 downto 0);
    alu1_op_ex : out std_logic_vector(1 downto 0);
    alu1_a_select_ex : out std_logic;
    alu1_b_select_ex : out std_logic_vector(1 downto 0);
    rf_write_ex : out std_logic;
    rf_a3_ex : out std_logic_vector(2 downto 0);   
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
    lw_sw_stop_ex : out std_logic;
    first_lw_sw_ex : out std_logic;
    right_shift_lm_sm_bit_ex : out std_logic;
    lm_sm_reg_write_ex : out std_logic_vector(2 downto 0);
    lm_sm_write_load_ex : out std_logic;
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
  rf_ra_reg_out : register_16 
     port map(
      reg_data_in => ra_read_temp,
      reg_enable => ,
      clk => clk,
      reg_data_out => data_ra
    );
  rf_rb_reg_out : register_16 
    port map(
      reg_data_in => rb_read_temp,
      reg_enable => ,
      clk => clk,
      reg_data_out => data_rb
    );
  rf_c_reg_out : register_1 
    port map(
      reg_data_in => carry_temp,
      reg_enable => ,
      clk => clk,
      reg_data_out => data_carry
    );
  rf_z_reg_out : register_1 
    port map(
      reg_data_in => zero_temp,
      reg_enable => ,
      clk => clk,
      reg_data_out => data_zero
    );
    ------------ Interfacing Register for ID/Ex stage ------------------------
    pc_out_ex_reg_out : register_16
      port map(
        reg_data_in => pc_out,
        reg_enable => ,
        clk => clk,
        reg_data_out => pc_out_ex
      );
    alu1_op_ex_reg_out : register_2
      port map(
        reg_data_in => alu1_op,
        reg_enable => ,
        clk => clk,
        reg_data_out => alu1_op_ex
      );
    alu1_a_select_ex_reg_out : register_1
      port map(
        reg_data_in => alu1_a_select,
        reg_enable => ,
        clk => clk,
        reg_data_out => alu1_a_select_ex
      );
    alu1_b_select_ex_reg_out : register_2
      port map(
        reg_data_in => alu1_b_select,
        reg_enable => ,
        clk => clk,
        reg_data_out => alu1_b_select_ex
      );
    rf_write_ex_reg_out : register_1
      port map(
        reg_data_in => rf_write,
        reg_enable => ,
        clk => clk,
        reg_data_out => rf_write_ex
      );
    rf_a3_ex_reg_out : register_3
      port map(
        reg_data_in => rf_a3,
        reg_enable => ,
        clk => clk,
        reg_data_out => rf_a3_ex
      );
    rf_data_select_ex_reg_out : register_3
      port map(
        reg_data_in => rf_data_select,
        reg_enable => ,
        clk => clk,
        reg_data_out => rf_data_select_ex
      );
    mem_write_ex_reg_out : register_1
      port map(
        reg_data_in => mem_write,
        reg_enable => ,
        clk => clk,
        reg_data_out => mem_write_ex
      );
    mem_read_ex_reg_out : register_1
      port map(
        reg_data_in => mem_read,
        reg_enable => ,
        clk => clk,
        reg_data_out => mem_read_ex
      );
    mem_data_sel_ex_reg_out : register_1
      port map(
        reg_data_in => mem_data_sel,
        reg_enable => ,
        clk => clk,
        reg_data_out => mem_data_sel_ex
      );
    mem_address_sel_ex_reg_out : register_1
      port map(
        reg_data_in => mem_address_sel,
        reg_enable => ,
        clk => clk,
        reg_data_out => mem_address_sel_ex
      );
    ir_5_0_ex_reg_out : register_16 -- Sign extended
      port map(
        reg_data_in => ir_5_0,
        reg_enable => ,
        clk => clk,
        reg_data_out => ir_5_0_ex
      );
    ir_8_0_ex_reg_out : register_16 -- Sign extended 
      port map(
        reg_data_in => ir_8_0,
        reg_enable => ,
        clk => clk,
        reg_data_out => ir_8_0_ex
      );
    data_extender_out_ex_reg_out : register_16 --Data for LHI
      port map(
        reg_data_in => data_extender_out,
        reg_enable => ,
        clk => clk,
        reg_data_out => data_extender_out_ex
      );
    carry_en_ex_reg_out : register_1     --Carry and zero enables
      port map(
        reg_data_in => carry_en,
        reg_enable => ,
        clk => clk,
        reg_data_out => carry_en_ex
      );
    zero_en_alu_ex_reg_out : register_1
      port map(
        reg_data_in => zero_en_alu,
        reg_enable => ,
        clk => clk,
        reg_data_out => zero_en_alu_ex
      );
    zero_en_mem_ex_reg_out : register_1
      port map(
        reg_data_in => zero_en_mem,
        reg_enable => ,
        clk => clk,
        reg_data_out => zero_en_mem_ex
      );
    cz_ex_reg_out : register_2
      port map(
        reg_data_in => cz,
        reg_enable => ,
        clk => clk,
        reg_data_out => cz_ex
      );
    opcode_ex_reg_out : out std_logic_vector(3 downto 0); --
      port map(
        reg_data_in => opcode,
        reg_enable => ,
        clk => clk,
        reg_data_out => opcode_ex
      );
    lm_detect_ex_reg_out : register_1
      port map (
        reg_data_in => lm_detect,
        reg_enable => ,
        clk => clk,
        reg_data_out => lm_detect_ex
      );

    sm_detect_ex_reg_out : register_1
      port map (
        reg_data_in => sm_detect,
        reg_enable => ,
        clk => clk,
        reg_data_out => sm_detect_ex
      );

    lw_sw_stop_ex_reg_out : register_1
      port map (
        reg_data_in => lw_sw_stop,
        reg_enable => ,
        clk => clk,
        reg_data_out => lw_sw_stop_ex
      );

    first_lw_sw_ex_reg_out : register_1
      port map (
        reg_data_in => first_lw_sw,
        reg_enable => ,
        clk => clk,
        reg_data_out => first_lw_sw_ex
      );

    right_shift_lm_sm_bit_ex_reg_out : register_1
      port map (
        reg_data_in => right_shift_lm_sm_bit,
        reg_enable => ,
        clk => clk,
        reg_data_out => right_shift_lm_sm_bit_ex
      );

    lm_sm_reg_write_ex_reg_out : register_3
      port map (
        reg_data_in => lm_sm_reg_write,
        reg_enable => ,
        clk => clk,
        reg_data_out => lm_sm_reg_write_ex
      );

    lm_sm_write_load_ex_reg_out : register_1
      port map (
        reg_data_in => lm_sm_write_load,
        reg_enable => ,
        clk => clk,
        reg_data_out => lm_sm_write_load_ex
      );

    alu2_out_ex_reg_out : register_16 --alu2_out to IF stage
      port map(
        reg_data_in => alu2_out,
        reg_enable => ,
        clk => clk,
        reg_data_out => alu2_out_ex
      );
end architecture ; -- op_read
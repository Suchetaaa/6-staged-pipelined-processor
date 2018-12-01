library std;
library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity execute is 
  port(
    clk : in std_logic;
    reset : in std_logic;

    -- the register values read 
    data_ra : in std_logic_vector(15 downto 0);
    data_rb : in std_logic_vector(15 downto 0);
    data_carry : in std_logic;
    data_zero : in std_logic;
    --signals coming from earlier stages 
    pc_out_ex : in std_logic_vector(15 downto 0);
    alu1_op_ex : in std_logic_vector(1 downto 0);
    alu1_a_select_ex : in std_logic;
    alu1_b_select_ex : in std_logic_vector(1 downto 0);
    rf_write_ex : in std_logic;
    rf_a3_ex : in std_logic_vector(2 downto 0);
    rf_data_select_ex : in std_logic_vector(2 downto 0);
    mem_write_ex : in std_logic;
    mem_read_ex : in std_logic;
    mem_data_sel_ex : in std_logic;
    mem_address_sel_ex : in std_logic;
    ir_5_0_ex : in std_logic_vector(15 downto 0); -- Sign extended 
    ir_8_0_ex : in std_logic_vector(15 downto 0); -- Sign extended  
    data_extender_out_ex : in std_logic_vector(15 downto 0); --Data for LHI
    carry_en_ex : in std_logic;     --Carry and zero enables
    zero_en_alu_ex : in std_logic;
    zero_en_mem_ex : in std_logic;
    cz_ex : in std_logic_vector(1 downto 0); -- 
    opcode_ex : in std_logic_vector(3 downto 0); --
    lm_detect_ex : in std_logic; --LM/SM signals 
    sm_detect_ex : in std_logic;
    lw_sw_stop_ex : in std_logic;
    first_lw_sw_ex : in std_logic;
    right_shift_lm_sm_bit_ex : in std_logic;
    lm_sm_reg_write_ex : in std_logic_vector(2 downto 0);
    lm_sm_write_load_ex : in std_logic;
    alu2_out_ex : in std_logic_vector(15 downto 0) --alu2_in to IF stage

    --Output signals from this stage
    alu1_out_mem : out std_logic_vector(15 downto 0); -- output of ALU
    alu1_carry_mem : out std_logic;
    alu1_zero_mem : out std_logic;
    cond_carry_mem : out std_logic;
    cond_zero_mem : out std_logic;

    --Output signals rom older stages 
    data_ra_mem : out std_logic_vector(15 downto 0);
    data_rb_mem : out std_logic_vector(15 downto 0);
    pc_out_mem : out std_logic_vector(15 downto 0);
    rf_write_mem : out std_logic;
    rf_a3_mem : out std_logic_vector(2 downto 0);
    rf_data_select_mem : out std_logic_vector(2 downto 0);
    mem_write_mem : out std_logic;
    mem_read_mem : out std_logic;
    mem_data_sel_mem : out std_logic;
    mem_address_sel_mem : out std_logic;
    ir_5_0_mem : out std_logic_vector(15 downto 0);
    ir_8_0_mem : out std_logic_vector(15 downto 0);
    data_extender_out_mem : out std_logic_vector(15 downto 0);
    carry_en_mem : out std_logic;
    zero_en_alu_mem : out std_logic;
    zero_en_mem_mem : out std_logic;
    --cz_mem : out std_logic_vector(1 downto 0);
    --opcode_mem : out std_logic_vector(3 downto 0);
    lm_detect_mem : out std_logic; --LM/SM signals 
    sm_detect_mem : out std_logic;
    lw_sw_stop_mem : out std_logic;
    first_lw_sw_mem : out std_logic;
    right_shift_lm_sm_bit_mem : out std_logic;
    lm_sm_reg_write_mem : out std_logic_vector(2 downto 0);
    lm_sm_write_load_mem : out std_logic;
    alu2_out_mem : out std_logic_vector(15 downto 0) --alu2_in to IF stage

  );
end entity;
architecture arch of execute is
  signal alu1_a_ip : std_logic_vector(15 downto 0); -- Inputs to ALU
  signal alu1_b_ip : std_logic_vector(15 downto 0); -- Inputs to ALU
  signal alu1_c_op : std_logic;
  signal alu1_z_op : std_logic;
  signal ra_temp : std_logic_vector(15 downto 0);
  signal rb_temp : std_logic_vector(15 downto 0);
  signal alu1_out_temp : std_logic_vector(15 downto 0);
  signal c_out : std_logic;
  signal z_out : std_logic;
  signal cond_carry : std_logic;
  signal cond_zero : std_logic;
begin
  logic_unit : alu1
    port map (
      alu_a => alu1_a_ip,
      alu_b => alu1_b_ip,
      alu_op => alu1_op_ex,
      alu_out => alu1_out_temp,
      carry => alu1_c_op,
      zero => alu1_z_op
    );
  muxing : process(ra_temp, rb_temp, data_ra, data_rb, data_carry, data_zero, ir_5_0_ex)
  begin
    if alu1_a_select_ex = '0' then
      alu1_a_ip <= ra_temp;
    else 
      alu1_a_ip <= rb_temp;
    end if;

    if alu1_b_select_ex = "00" then
      alu1_b_ip <= rb_temp;
    elsif alu1_b_select_ex = "01" then
      alu1_b_ip <= ir_5_0_ex;
    elsif alu1_b_select_ex = "10" then
      alu1_b_ip <= "0000000000000001";
    else
      alu1_b_ip <= "0000000000000000";
    end if;
  end process ; -- muxing

  carry_zero : process(opcode_ex, cz_ex, alu1_c_op, alu1_z_op, carry_en_ex, zero_en_alu_ex)
  begin
    if carry_en_ex = '1' then
      c_out <= alu1_c_op;
    else
      c_out <= '0';
    end if;

    if zero_en_alu_ex = '1' then
      z_out <= alu1_z_op;
    else 
      z_out <= '0';
    end if;

    if ((opcode_ex = "0000" or opcode_ex = "0010") and (cz_ex = "10")) then
      cond_carry <= 1;
    else
      cond_carry <= 0;
    end if;

    if ((opcode_ex = "0000" or opcode_ex = "0010") and (cz_ex = "01")) then
      cond_zero <= 1;
    else
      cond_zero <= 0;
    end if;

  end process ; -- carry_zero

  -- No hazard
  ra_temp <= data_ra;
  rb_temp <= data_rb;

-----------------Interfacing registers----------------------------------------
	alu1_out_reg_out : register_16 
		port map (
			reg_data_in => alu1_out_temp;
			reg_enable => '1';
			clk => clk;
			reg_data_out => alu1_out_mem
	);

	alu1_carry_reg_out : register_1 
		port map (
			reg_data_in => c_out;
			reg_enable => '1';
			clk => clk;
			reg_data_out => alu1_carry_mem
	);

	alu1_zero_reg_out : register_1
		port map (
			reg_data_in => z_out;
			reg_enable => '1';
			clk => clk;
			reg_data_out => alu1_zero_mem
	);

	cond_carry_reg_out : register_1
		port map (
			reg_data_in => cond_carry;
			reg_enable => '1';
			clk => clk;
			reg_data_out => cond_carry_mem
	);

	cond_zero_reg_out : register_1 
		port map (
			reg_data_in => cond_zero;
			reg_enable => '1';
			clk => clk;
			reg_data_out => cond_zero_mem
	);

	data_ra_reg_out : register_16
		port map (
			reg_data_in => data_ra;
			reg_enable => '1';
			clk => clk;
			reg_data_out => data_ra_mem
	);

	dat_rb_reg_out : register_16 
		port map (
			reg_data_in => data_rb;
			reg_enable => '1';
			clk => clk;
			reg_data_out => data_rb_mem
	);

	pc_out_reg_out : register_16 
		port map (
			reg_data_in => pc_out_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => pc_out_mem
	);

	rf_write_reg_out : register_1
		port map (
			reg_data_in => rf_write_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => rf_write_mem
	);

	rf_a3_reg_out : register_3 
		port map (
			reg_data_in => rf_a3_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => rf_a3_mem
	);

	rf_data_select_reg_out : register_3
		port map (
			reg_data_in => rf_data_select_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => rf_data_select_mem
	);

	mem_write_reg_out : register_1
		port map (
			reg_data_in => mem_write_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => mem_write_mem
	);

	mem_read_reg_out : register_1
		port map (
			reg_data_in => mem_read_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => mem_read_mem
	);

	mem_data_sel_reg_out : register_1
		port map (
			reg_data_in => mem_data_sel_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => mem_data_sel_mem
	);

	mem_address_sel_reg_out : register_1
		port map (
			reg_data_in => mem_address_sel_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => mem_address_sel_mem
	);

	ir_5_0_reg_out : register_16
		port map (
			reg_data_in => ir_5_0_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => ir_5_0_mem
	);

	ir_8_0_reg_out : register_16
		port map (
			reg_data_in => ir_8_0_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => ir_8_0_mem
	);

	data_extender_reg_out : register_16
		port map (
			reg_data_in => data_extender_out_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => data_extender_out_mem
	);

	carry_en_reg_out : register_1
		port map (
			reg_data_in => carry_en_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => carry_en_mem
	);

	zero_en_alu_reg_out : register_1
		port map (
			reg_data_in => zero_en_alu_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => zero_en_alu_mem
	);

	zero_en_mem_reg_out : register_1
		port map (
			reg_data_in => zero_en_mem_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => zero_en_mem_mem
	);

	lm_detect_reg_out : register_1
		port map (
			reg_data_in => lm_detect_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => lm_detect_mem
	);

	sm_detect_reg_out : register_1
		port map (
			reg_data_in => sm_detect_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => sm_detect_mem
	);

	sm_detect_reg_out : register_1
		port map (
			reg_data_in => sm_detect_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => sm_detect_mem
	);

	sm_detect_reg_out : register_1
		port map (
			reg_data_in => sm_detect_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => sm_detect_mem
	);

	lw_sw_reg_out : register_1
		port map (
			reg_data_in => lw_sw_stop_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => lw_sw_stop_mem
	);

	first_lw_sw_reg_out : register_1
		port map (
			reg_data_in => first_lw_sw_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => first_lw_sw_mem
	);

	right_shift_lm_sm_bit_reg_out : register_1
		port map (
			reg_data_in => right_shift_lm_sm_bit_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => right_shift_lm_sm_bit_mem
	);

	lm_sm_reg_write_reg_out : register_3
		port map (
			reg_data_in => lm_sm_reg_write_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => lm_sm_reg_write_mem
	);

	lm_sm_write_load_reg_out : register_1
		port map (
			reg_data_in => lm_sm_write_load_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => lm_sm_write_load_mem
	);

	alu2_out_reg_out : register_1
		port map (
			reg_data_in => alu2_out_ex;
			reg_enable => '1';
			clk => clk;
			reg_data_out => alu2_out_mem
	);












end architecture ; -- arch



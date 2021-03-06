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
    lw_lhi_dep_reg_out : in std_logic;
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
    ir_11_9_ex : in std_logic_vector(2 downto 0);
    ir_8_6_ex : in std_logic_vector(2 downto 0);
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
    alu2_out_ex : in std_logic_vector(15 downto 0); --alu2_in to IF stage

    --Output signals from this stage
    alu1_out_mem : out std_logic_vector(15 downto 0); -- output of ALU
    alu1_carry_mem : out std_logic;
    alu1_zero_mem : out std_logic;
    cond_carry_mem : out std_logic;
    cond_zero_mem : out std_logic;
	 lm_sm_adder_out : out std_logic_vector(15 downto 0);

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
    cz_mem : out std_logic_vector(1 downto 0);
    opcode_mem : out std_logic_vector(3 downto 0);
    lm_detect_mem : out std_logic; --LM/SM signals 
    sm_detect_mem : out std_logic;
    lw_sw_stop_mem : out std_logic;
    first_lw_sw_mem : out std_logic;
    right_shift_lm_sm_bit_mem : out std_logic;
    lm_sm_reg_write_mem : out std_logic_vector(2 downto 0);
    lm_sm_write_load_mem : out std_logic;
    alu2_out_mem : out std_logic_vector(15 downto 0); --alu2_in to IF stage

    ------------stalling----------
    lw_lhi_dep_reg_mem : out std_logic;

    --------data hazards-------------
    alu1_a_select_final : in std_logic_vector(2 downto 0);
    alu1_b_select_final : in std_logic_vector(2 downto 0);
    data_a_from_wb_ex : in std_logic_vector(15 downto 0);
		data_b_from_wb_ex : in std_logic_vector(15 downto 0);
		alu1_out_from_mem : in std_logic_vector(15 downto 0);
		alu1_out_from_wb : in std_logic_vector(15 downto 0);
		opcode_from_ex : out std_logic_vector(3 downto 0);
		rf_a3_from_ex : out std_logic_vector(2 downto 0);

		--------------------BEQ ports----------------------------
		pc_imm_from_ex : out std_logic_vector(15 downto 0);
		beq_taken : out std_logic;
		pc_select : out std_logic_vector(1 downto 0);

   	valid_bit_or_ex : in std_logic;
   	valid_bit_ex_mem : out std_logic;
   	valid_bit_id_or_ex : in std_logic;
   	valid_bit_id_ex_mem : out std_logic;
   	valid_bit_or_or_ex : in std_logic;
   	valid_bit_or_ex_mem : out std_logic

  );
end entity;
architecture arch of execute is
  signal alu1_a_ip : std_logic_vector(15 downto 0); -- Inputs to ALU
  signal alu1_b_ip : std_logic_vector(15 downto 0); -- Inputs to ALU
  signal alu1_c_op : std_logic;
  signal alu1_z_op : std_logic;
  --signal ra_temp : std_logic_vector(15 downto 0);
  --signal rb_temp : std_logic_vector(15 downto 0);
  signal alu1_out_temp : std_logic_vector(15 downto 0);
  signal c_out : std_logic;
  signal z_out : std_logic;
  signal cond_carry : std_logic;
  signal cond_zero : std_logic;
  signal lm_sm_adder_out_signal : std_logic_vector(15 downto 0);
  signal lm_sm_adder_out_old : std_logic_vector(15 downto 0);
  signal valid_bit_signal : std_logic;
  ----------------
begin

	opcode_from_ex <= opcode_ex;
	rf_a3_from_ex <= rf_a3_ex;

  logic_unit : alu1
    port map (
      alu_a => alu1_a_ip,
      alu_b => alu1_b_ip,
      alu_op => alu1_op_ex,
      alu_out => alu1_out_temp,
      carry => alu1_c_op,
      zero => alu1_z_op
    );

-------------------------------------beq-------------------------------------
  process(clk, reset, alu1_out_temp)
  begin 
  	if reset = '1' then 
  		beq_taken <= '0';
  		pc_select <= "11";
  		pc_imm_from_ex <= "0000000000000000";
  	elsif alu1_out_temp = "0000000000000000" and opcode_ex = "1100" then
  		beq_taken <= '1';
  		pc_select <= "01";
  		pc_imm_from_ex <= alu2_out_ex; 
  	else 
  		beq_taken <= '0';
  		pc_select <= "11";
  		pc_imm_from_ex <= alu2_out_ex; 
  	end if;
  end process;
  		
  -------------------------------------beq-------------------------------------


  assigning : process(data_ra, data_rb, ir_5_0_ex, clk, alu1_out_from_wb, alu1_out_from_mem, alu1_a_select_final, alu1_b_select_final, data_a_from_wb_ex, data_b_from_wb_ex, reset)
  begin 
  	if alu1_a_select_final = "000" then 
  		alu1_a_ip <= alu1_out_from_mem;
  	elsif alu1_a_select_final = "001" then
  		alu1_a_ip <= alu1_out_from_wb;
  	elsif alu1_a_select_final = "010" then
  		alu1_a_ip <= data_a_from_wb_ex;
  	elsif alu1_a_select_final = "011" then
  		alu1_a_ip <= data_ra;
  	else 
  		alu1_a_ip <= data_rb;
  	end if; 

  	if alu1_b_select_final = "000" then 
  		alu1_b_ip <= alu1_out_from_mem;
  	elsif alu1_b_select_final = "001" then
  		alu1_b_ip <= alu1_out_from_wb;
  	elsif alu1_b_select_final = "010" then
  		alu1_b_ip <= data_b_from_wb_ex;
  	elsif alu1_b_select_final = "011" then
  		alu1_b_ip <= data_rb;
  	else 
  		alu1_b_ip <= ir_5_0_ex;
  	end if;
  end process;

  --muxing : process(ra_temp, rb_temp, data_ra, data_rb, data_carry, data_zero, ir_5_0_ex)
  --begin
  --  if alu1_a_select_ex = '0' then
  --    alu1_a_ip <= ra_temp;
  --  else 
  --    alu1_a_ip <= rb_temp;
  --  end if;

  --  if alu1_b_select_ex = "00" then
  --    alu1_b_ip <= rb_temp;
  --  elsif alu1_b_select_ex = "01" then
  --    alu1_b_ip <= ir_5_0_ex;
  --  elsif alu1_b_select_ex = "10" then
  --    alu1_b_ip <= "0000000000000001";
  --  else
  --    alu1_b_ip <= "0000000000000000";
  --  end if;
  --end process ; -- muxing

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

    if (opcode_ex = "0000" or opcode_ex = "0010") then
      cond_carry <= cz_ex(1);
      cond_zero <= cz_ex(0);
    else
      cond_carry <= '0';
      cond_zero <= '0';
    end if;

  end process ; -- carry_zero
  
  process(clk, lm_sm_adder_out_signal)
  begin 
		if reset = '1' then 
			lm_sm_adder_out_old <= "0000000000000000";
		else 	
			lm_sm_adder_out_old <= lm_sm_adder_out_signal;
		end if;
	end process;
	
	lm_sm_adder_out <= lm_sm_adder_out_signal;
  
  --port mapping 
  lm_sm_adder_portmap : lm_sm_adder 
	port map (
		clk => clk,
		data_ra => data_ra,
		lm_sm_adder_out_old => lm_sm_adder_out_old,
		lm_detect => lm_detect_ex,
		first_last_check => first_lw_sw_ex,
		write_enable => right_shift_lm_sm_bit_ex,
		lm_sm_adder_out => lm_sm_adder_out_signal
	);

  -- No hazard

-----------------Interfacing registers----------------------------------------

-----------------stalling----------------------------------------

	lw_lhi_dep_reg_port_map : register_1 
    port map (
      reg_data_in => lw_lhi_dep_reg_out,
      reg_enable => '1',
      clk => clk,
      reg_data_out => lw_lhi_dep_reg_mem
    );


	alu1_out_reg_out : register_16 
		port map (
			reg_data_in => alu1_out_temp,
			reg_enable => '1',
			clk => clk,
			reg_data_out => alu1_out_mem
	);

	alu1_carry_reg_out : register_1 
		port map (
			reg_data_in => c_out,
			reg_enable => '1',
			clk => clk,
			reg_data_out => alu1_carry_mem
	);

	alu1_zero_reg_out : register_1
		port map (
			reg_data_in => z_out,
			reg_enable => '1',
			clk => clk,
			reg_data_out => alu1_zero_mem
	);

	cond_carry_reg_out : register_1
		port map (
			reg_data_in => cond_carry,
			reg_enable => '1',
			clk => clk,
			reg_data_out => cond_carry_mem
	);

	cond_zero_reg_out : register_1 
		port map (
			reg_data_in => cond_zero,
			reg_enable => '1',
			clk => clk,
			reg_data_out => cond_zero_mem
	);

	data_ra_reg_out : register_16
		port map (
			reg_data_in => data_ra,
			reg_enable => '1',
			clk => clk,
			reg_data_out => data_ra_mem
	);

	dat_rb_reg_out : register_16 
		port map (
			reg_data_in => data_rb,
			reg_enable => '1',
			clk => clk,
			reg_data_out => data_rb_mem
	);

	pc_out_reg_out : register_16 
		port map (
			reg_data_in => pc_out_ex,
			reg_enable => '1',
			clk => clk,
			reg_data_out => pc_out_mem
	);

	rf_write_reg_out : register_1
		port map (
			reg_data_in => rf_write_ex,
			reg_enable => '1',
			clk => clk,
			reg_data_out => rf_write_mem
	);

	rf_a3_reg_out : register_3 
		port map (
			reg_data_in => rf_a3_ex,
			reg_enable => '1',
			clk => clk,
			reg_data_out => rf_a3_mem
	);

	rf_data_select_reg_out : register_3
		port map (
			reg_data_in => rf_data_select_ex,
			reg_enable => '1',
			clk => clk,
			reg_data_out => rf_data_select_mem
	);

	mem_write_reg_out : register_1
		port map (
			reg_data_in => mem_write_ex,
			reg_enable => '1',
			clk => clk,
			reg_data_out => mem_write_mem
	);

	mem_read_reg_out : register_1
		port map (
			reg_data_in => mem_read_ex,
			reg_enable => '1',
			clk => clk,
			reg_data_out => mem_read_mem
	);

	mem_data_sel_reg_out : register_1
		port map (
			reg_data_in => mem_data_sel_ex,
			reg_enable => '1',
			clk => clk,
			reg_data_out => mem_data_sel_mem
	);

	mem_address_sel_reg_out : register_1
		port map (
			reg_data_in => mem_address_sel_ex,
			reg_enable => '1',
			clk => clk,
			reg_data_out => mem_address_sel_mem
	);

	ir_5_0_reg_out : register_16
		port map (
			reg_data_in => ir_5_0_ex,
			reg_enable => '1',
			clk => clk,
			reg_data_out => ir_5_0_mem
	);

	ir_8_0_reg_out : register_16
		port map (
			reg_data_in => ir_8_0_ex,
			reg_enable => '1',
			clk => clk,
			reg_data_out => ir_8_0_mem
	);

	data_extender_reg_out : register_16
		port map (
			reg_data_in => data_extender_out_ex,
			reg_enable => '1',
			clk => clk,
			reg_data_out => data_extender_out_mem
	);

	carry_en_reg_out : register_1
		port map (
			reg_data_in => carry_en_ex,
			reg_enable => '1',
			clk => clk,
			reg_data_out => carry_en_mem
	);

	zero_en_alu_reg_out : register_1
		port map (
			reg_data_in => zero_en_alu_ex,
			reg_enable => '1',
			clk => clk,
			reg_data_out => zero_en_alu_mem
	);

	zero_en_mem_reg_out : register_1
		port map (
			reg_data_in => zero_en_mem_ex,
			reg_enable => '1',
			clk => clk,
			reg_data_out => zero_en_mem_mem
	);

  cz_mem_reg_out : register_2
    port map(
      reg_data_in => cz_ex,
      reg_enable => '1',
      clk => clk,
      reg_data_out => cz_mem
    );

  opcode_mem_reg_out : register_4
    port map(
      reg_data_in => opcode_ex,
      reg_enable => '1',
      clk => clk,
      reg_data_out => opcode_mem
    );

	lm_detect_reg_out : register_1
		port map (
			reg_data_in => lm_detect_ex,
			reg_enable => '1',
			clk => clk,
			reg_data_out => lm_detect_mem
	);


	sm_detect_reg_out : register_1
		port map (
			reg_data_in => sm_detect_ex,
			reg_enable => '1',
			clk => clk,
			reg_data_out => sm_detect_mem
	);



	lw_sw_reg_out : register_1
		port map (
			reg_data_in => lw_sw_stop_ex,
			reg_enable => '1',
			clk => clk,
			reg_data_out => lw_sw_stop_mem
	);

	first_lw_sw_reg_out : register_1
		port map (
			reg_data_in => first_lw_sw_ex,
			reg_enable => '1',
			clk => clk,
			reg_data_out => first_lw_sw_mem
	);

	right_shift_lm_sm_bit_reg_out : register_1
		port map (
			reg_data_in => right_shift_lm_sm_bit_ex,
			reg_enable => '1',
			clk => clk,
			reg_data_out => right_shift_lm_sm_bit_mem
	);

	lm_sm_reg_write_reg_out : register_3
		port map (
			reg_data_in => lm_sm_reg_write_ex,
			reg_enable => '1',
			clk => clk,
			reg_data_out => lm_sm_reg_write_mem
	);

	lm_sm_write_load_reg_out : register_1
		port map (
			reg_data_in => lm_sm_write_load_ex,
			reg_enable => '1',
			clk => clk,
			reg_data_out => lm_sm_write_load_mem
	);

	alu2_out_reg_out : register_16
		port map (
			reg_data_in => alu2_out_ex,
			reg_enable => '1',
			clk => clk,
			reg_data_out => alu2_out_mem
	);

  valid_bit_ex_mem_reg : register_1
    port map(
      reg_data_in => valid_bit_or_ex,
      reg_enable => '1',
      clk => clk,
      reg_data_out => valid_bit_ex_mem
    );

  valid_bit_id_ex_mem_reg : register_1
    port map(
      reg_data_in => valid_bit_id_or_ex,
      reg_enable => '1',
      clk => clk,
      reg_data_out => valid_bit_id_ex_mem
    );

   valid_bit_or_ex_mem_reg : register_1
    port map(
      reg_data_in => valid_bit_or_or_ex,
      reg_enable => '1',
      clk => clk,
      reg_data_out => valid_bit_or_ex_mem
    );

   

end architecture ; -- arch



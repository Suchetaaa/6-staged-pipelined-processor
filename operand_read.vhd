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
    lm_sm_write_load : in std_logic;
    alu2_out : in std_logic_vector(15 downto 0); --alu2_out to IF stage
    
    ------------------ From Write Back Stage -----------------------------
    -- the address of the write back reg (and if write back)
    rf_write_final : in std_logic;
    carry_en_final : in std_logic;
    zero_en_final : in std_logic;
    carry_val_final : in std_logic;
    zero_val_final : in std_logic;
    rf_data_final : in std_logic_vector(15 downto 0);
    rf_a3_final : in std_logic_vector(2 downto 0);

    -----------------from RR for stalling----------------------------------

    instruction_to_rr : in std_logic_vector(15 downto 0);
  
    --------------------- Outputs -----------------------------------------
    -- the register values read 
    data_ra : out std_logic_vector(15 downto 0);
    data_rb : out std_logic_vector(15 downto 0);
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
    ir_11_9_ex : out std_logic_vector(2 downto 0);
    ir_8_6_ex : out std_logic_vector(2 downto 0);
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
    alu2_out_ex : out std_logic_vector(15 downto 0); --alu2_out to IF stage
    rf_carry_reg_out : out std_logic;
    rf_zero_reg_out : out std_logic;

    ------------------------------------output signals for stalling detection----------------------------
    --lw_lhi_dep : out std_logic;
    lw_lhi_dep_reg_out : out std_logic;
    stall_from_rr : out std_logic; -- going to IF and ID
    ------------------------------------output signals for stalling detection----------------------------

    external_r0 : out std_logic_vector(15 downto 0);
    external_r1 : out std_logic_vector(15 downto 0);
    external_r2 : out std_logic_vector(15 downto 0);
    external_r3 : out std_logic_vector(15 downto 0);
    external_r4 : out std_logic_vector(15 downto 0);
    external_r5 : out std_logic_vector(15 downto 0);
    external_r6 : out std_logic_vector(15 downto 0);
    external_r7 : out std_logic_vector(15 downto 0);

    -----------------data hazards----------------
    rf_a3_from_ex : in std_logic_vector(2 downto 0);
    rf_a3_from_mem : in std_logic_vector(2 downto 0);
    rf_a3_from_wb : in std_logic_vector(2 downto 0);

    opcode_from_ex : in std_logic_vector(3 downto 0);
    opcode_from_mem : in std_logic_vector(3 downto 0);
    opcode_from_wb : in std_logic_vector(3 downto 0);

    data_a_from_wb_ex : out std_logic_vector(15 downto 0);
    data_b_from_wb_ex : out std_logic_vector(15 downto 0);

    alu1_a_select_final : out std_logic_vector(2 downto 0);
    alu1_b_select_final : out std_logic_vector(2 downto 0);
	 
	 alu1_out_from_wb : in std_logic_vector(15 downto 0);

   ----------------------beq------------------------
   beq_taken : in std_logic;
   
   valid_bit_id_id_or : in std_logic;
   valid_bit_id_or : in std_logic;
   valid_bit_or_ex : out std_logic;
   valid_bit_id_or_ex : out std_logic;
   valid_bit_or_or_ex : out std_logic

  );


end entity;
architecture op_read of operand_read is
  signal ra_read_temp : std_logic_vector(15 downto 0);
  signal rb_read_temp : std_logic_vector(15 downto 0);
  signal carry_temp : std_logic;
  signal zero_temp : std_logic;
  signal lw_lhi_dep : std_logic;
  signal alu1_a_select_signal : std_logic_vector(2 downto 0);
  signal alu1_b_select_signal : std_logic_vector(2 downto 0);
  signal data_a_from_wb : std_logic_vector(15 downto 0);
  signal data_b_from_wb : std_logic_vector(15 downto 0);
  signal valid_bit_signal : std_logic;
  


begin

-----------------------beq-----------------------------

  process(clk, reset, beq_taken)
  begin 
    if reset = '1' then 
      valid_bit_signal = '1';
    elsif beq_taken = '1' then
      valid_bit_signal = '0';
    else 
      valid_bit_signal = '1';
    end if; 
  end process;
        
  ---------------------------data hazards-----------------------------------
  process (clk, rf_a3_from_ex, rf_a3_from_mem, rf_a3_from_wb, opcode_from_ex, opcode_from_mem, opcode_from_wb, opcode, ir_11_9)
  begin 
    --dependency in memory access 
    --AND instructions and NAND instructions
    if (opcode = "0000" or opcode = "0010" or opcode = "1100") then 
      --Execute given more pref
      if (opcode_from_ex = "0000" or opcode_from_ex = "0010" or opcode_from_ex = "0001") and (rf_a3_from_ex = ir_11_9) then  
        alu1_a_select_signal <= "000"; -- ALU1 OUT FROM EX
        data_a_from_wb <= "0000000000000000";
      --Memory
      elsif (opcode_from_mem = "0000" or opcode_from_mem = "0010" or opcode_from_mem = "0001") and (rf_a3_from_mem = ir_11_9) then 
        alu1_a_select_signal <= "001"; --ALU1 OUT FROM MEMORY
        data_a_from_wb <= "0000000000000000"; 
      --Write back 
      elsif (opcode_from_wb = "0000" or opcode_from_wb = "0010" or opcode_from_wb = "0001") and (rf_a3_from_wb = ir_11_9) then
        alu1_a_select_signal <= "010"; --ALU1 OUT FROM WB 
        data_a_from_wb <= alu1_out_from_wb;
      else 
        alu1_a_select_signal <= "011"; -- from data_ra 
        data_a_from_wb <= "0000000000000000";
      end if;

    elsif (opcode = "0001") then 
      if (opcode_from_ex = "0000" or opcode_from_ex = "0001" or opcode_from_ex = "0010") and (rf_a3_from_ex = ir_11_9) then 
        alu1_a_select_signal <= "000";
        data_a_from_wb <= "0000000000000000"; 
      elsif (opcode_from_mem = "0000" or opcode_from_mem = "0001" or opcode_from_mem = "0010") and (rf_a3_from_mem = ir_11_9) then
        alu1_a_select_signal <= "001";
        data_a_from_wb <= "0000000000000000";
      elsif (opcode_from_wb = "0000" or opcode_from_wb = "0001" or opcode_from_wb = "0010") and (rf_a3_from_wb = ir_11_9) then
        alu1_a_select_signal <= "010"; 
        data_a_from_wb <= alu1_out_from_wb;
      else 
        alu1_a_select_signal <= "011"; --from ra
        data_a_from_wb <= "0000000000000000";
      end if;

    --LW and SW and 
    elsif (opcode = "0100" or opcode = "0101") then 
      if (opcode_from_ex = "0000" or opcode_from_ex = "0001" or opcode_from_ex = "0010") and (rf_a3_from_ex = ir_8_6) then 
        alu1_a_select_signal <= "000";
        data_a_from_wb <= "0000000000000000";
      elsif (opcode_from_mem = "0000" or opcode_from_mem = "0001" or opcode_from_mem = "0010") and (rf_a3_from_mem = ir_8_6) then 
        alu1_a_select_signal <= "001";
        data_a_from_wb <= "0000000000000000";
      elsif (opcode_from_wb = "0000" or opcode_from_wb = "0001" or opcode_from_wb = "0010") and (rf_a3_from_wb = ir_8_6) then 
        alu1_a_select_signal <= "010";
        data_a_from_wb <= alu1_out_from_wb;
      else 
        alu1_a_select_signal <= "100"; -- from data rb
        data_a_from_wb <= "0000000000000000";
      end if;
    end if; 

  end process;

  process (clk, rf_a3_from_ex, rf_a3_from_mem, rf_a3_from_wb, opcode_from_ex, opcode_from_mem, opcode_from_wb, opcode, ir_8_6)
  begin 
    --dependency in memory access 
    --AND instructions and NAND instructions
    if (opcode = "0000" or opcode = "0010" or opcode = "1100") then 
      --Execute given more pref
      if (opcode_from_ex = "0000" or opcode_from_ex = "0010" or opcode_from_ex = "0001") and (rf_a3_from_ex = ir_8_6) then 
        alu1_b_select_signal <= "000"; -- ALU1 OUT FROM EX
        data_b_from_wb <= "0000000000000000";
      --Memory
      elsif (opcode_from_mem = "0000" or opcode_from_mem = "0010" or opcode_from_mem = "0001") and (rf_a3_from_mem = ir_8_6) then 
        alu1_b_select_signal <= "001"; --ALU1 OUT FROM MEMORY
        data_b_from_wb <= "0000000000000000"; 
      --Write back 
      elsif (opcode_from_wb = "0000" or opcode_from_wb = "0010" or opcode_from_wb = "0001") and (rf_a3_from_wb = ir_8_6) then 
        alu1_b_select_signal <= "010"; --ALU1 OUT FROM WB 
        data_b_from_wb <= alu1_out_from_wb;
      else 
        alu1_b_select_signal <= "011"; -- from data_rb 
        data_b_from_wb <= "0000000000000000";
      end if;

    elsif (opcode = "0001") then 
      alu1_b_select_signal <= "100"; --SE6 out
      data_b_from_wb <= "0000000000000000"; 

    --LW and SW and 
    elsif (opcode = "0100" or opcode = "0101") then 
      alu1_b_select_signal <= "100"; --se6 out 
      data_b_from_wb <= "0000000000000000";
    end if; 

  end process;

  ----------------------data hazards----------------------------------

    --JLR 
  ---------------------------------------------for stalling for lw and lhi------------------------------------------------
  --ir_11_9 is tha RA to which writing is taking place in case of LHI and LW
  process(clk, instruction_to_rr, opcode, ir_11_9, rf_a3, reset)
  begin 
    if reset = '1' then 
      lw_lhi_dep <= '0';
      stall_from_rr <= '0';
    --LW or LHI instruction
    elsif opcode = "0011" or opcode = "0100" then 
      if instruction_to_rr(15 downto 12) = "0000" or instruction_to_rr(15 downto 12) = "0010" or instruction_to_rr(15 downto 12) = "1100" or (rf_a3 = instruction_to_rr(11 downto 9) and rf_a3 = instruction_to_rr(8 downto 6)) then  
        lw_lhi_dep <= '1';
        stall_from_rr <= '1';
      --ADI and LM and SM - reading from RA
      elsif (instruction_to_rr(15 downto 12) = "0001" or instruction_to_rr(15 downto 12) = "0110" or instruction_to_rr(15 downto 12) = "0111") and (rf_a3 = instruction_to_rr(11 downto 9)) then
        lw_lhi_dep <= '1';
        stall_from_rr <= '1';
      elsif instruction_to_rr(15 downto 12) = "1001" and (rf_a3 = instruction_to_rr(8 downto 6)) then
        lw_lhi_dep <= '1';
        stall_from_rr <= '1';
      else 
        lw_lhi_dep <= '0';
        stall_from_rr <= '0';
      end if;
    end if;

  end process;

  lw_lhi_dep_reg_port_map : register_1 
    port map (
      reg_data_in => lw_lhi_dep,
      reg_enable => '1',
      clk => clk,
      reg_data_out => lw_lhi_dep_reg_out
    );

  --------------------------------------------------------------------------------------------------------------------------------


  reg_access_port : reg_file 
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
      reg_file_write => rf_write_final, -- from WB stage
      carry_write => carry_en_final, -- from WB stage
      zero_write => zero_en_final, -- from WB stage
      address_1 => ir_11_9,
      --Address - 2 signal value 
      address_2 => ir_8_6,
      --Address - 3 signal value for writing to A3
      address_3 => rf_a3_final, -- from WB stage
      --Data in and out signal values 
      data_in => rf_data_final,  -- from WB stage
      carry_in => carry_val_final,  -- from WB stage
      zero_in => zero_val_final,  -- from WB stage
      data_out_ra => ra_read_temp,
      data_out_rb => rb_read_temp,
      carry_out => carry_temp,
      zero_out => zero_temp,
      external_r0_sig => external_r0, 
      external_r1_sig => external_r1, 
      external_r2_sig => external_r2, 
      external_r3_sig => external_r3, 
      external_r4_sig => external_r4, 
      external_r5_sig => external_r5, 
      external_r6_sig => external_r6, 
      external_r7_sig => external_r7
    ) ;

  rf_carry_reg_out <= carry_temp;
  rf_zero_reg_out <= zero_temp;

  ------------interfacing regs for data forwarding-----------
  dataafromwb : register_16 
     port map(
      reg_data_in => data_a_from_wb,
      reg_enable => '1',
      clk => clk,
      reg_data_out => data_a_from_wb_ex
    );

  databfromwb : register_16 
     port map(
      reg_data_in => data_b_from_wb,
      reg_enable => '1',
      clk => clk,
      reg_data_out => data_b_from_wb_ex
    );

  alu1aselect : register_3 
     port map(
      reg_data_in => alu1_a_select_signal,
      reg_enable => '1',
      clk => clk,
      reg_data_out => alu1_a_select_final
    );

  alu1bselect : register_3 
     port map(
      reg_data_in => alu1_b_select_signal,
      reg_enable => '1',
      clk => clk,
      reg_data_out => alu1_b_select_final
    );

  ---------------------------------------------------------------

  rf_ra_reg_out : register_16 
     port map(
      reg_data_in => ra_read_temp,
      reg_enable => '1',
      clk => clk,
      reg_data_out => data_ra
    );
  rf_rb_reg_out : register_16 
    port map(
      reg_data_in => rb_read_temp,
      reg_enable => '1',
      clk => clk,
      reg_data_out => data_rb
    );
  rf_c_reg_out : register_1 
    port map(
      reg_data_in => carry_temp,
      reg_enable => '1',
      clk => clk,
      reg_data_out => data_carry
    );
  rf_z_reg_out : register_1 
    port map(
      reg_data_in => zero_temp,
      reg_enable => '1',
      clk => clk,
      reg_data_out => data_zero
    );
  ------------ Interfacing Register for ID/Ex stage ------------------------
  pc_out_ex_reg_out : register_16
    port map(
      reg_data_in => pc_out,
      reg_enable => '1',
      clk => clk,
      reg_data_out => pc_out_ex
    );
  alu1_op_ex_reg_out : register_2
    port map(
      reg_data_in => alu1_op,
      reg_enable => '1',
      clk => clk,
      reg_data_out => alu1_op_ex
    );
  alu1_a_select_ex_reg_out : register_1
    port map(
      reg_data_in => alu1_a_select,
      reg_enable => '1',
      clk => clk,
      reg_data_out => alu1_a_select_ex
    );
  alu1_b_select_ex_reg_out : register_2
    port map(
      reg_data_in => alu1_b_select,
      reg_enable => '1',
      clk => clk,
      reg_data_out => alu1_b_select_ex
    );
  rf_write_ex_reg_out : register_1
    port map(
      reg_data_in => rf_write,
      reg_enable => '1',
      clk => clk,
      reg_data_out => rf_write_ex
    );
  rf_a3_ex_reg_out : register_3
    port map(
    reg_data_in => rf_a3,
      reg_enable => '1',
      clk => clk,
      reg_data_out => rf_a3_ex
    );
  rf_data_select_ex_reg_out : register_3
    port map(
      reg_data_in => rf_data_select,
      reg_enable => '1',
      clk => clk,
      reg_data_out => rf_data_select_ex
    );
  mem_write_ex_reg_out : register_1
    port map(
      reg_data_in => mem_write,
      reg_enable => '1',
      clk => clk,
      reg_data_out => mem_write_ex
    );
    mem_read_ex_reg_out : register_1
    port map(
      reg_data_in => mem_read,
      reg_enable => '1',
      clk => clk,
      reg_data_out => mem_read_ex
    );
  mem_data_sel_ex_reg_out : register_1
    port map(
      reg_data_in => mem_data_sel,
      reg_enable => '1',
      clk => clk,
      reg_data_out => mem_data_sel_ex
    );
  mem_address_sel_ex_reg_out : register_1
    port map(
      reg_data_in => mem_address_sel,
      reg_enable => '1',
      clk => clk,
      reg_data_out => mem_address_sel_ex
    );
  ir_5_0_ex_reg_out : register_16 -- Sign extended
    port map(
      reg_data_in => ir_5_0,
      reg_enable => '1',
      clk => clk,
      reg_data_out => ir_5_0_ex
    );
  ir_8_0_ex_reg_out : register_16 -- Sign extended 
    port map(
      reg_data_in => ir_8_0,
      reg_enable => '1',
     clk => clk,
      reg_data_out => ir_8_0_ex
    );
  data_extender_out_ex_reg_out : register_16 --Data for LHI
    port map(
      reg_data_in => data_extender_out,
      reg_enable => '1',
      clk => clk,
      reg_data_out => data_extender_out_ex
    );
  carry_en_ex_reg_out : register_1     --Carry and zero enables
    port map(
      reg_data_in => carry_en,
      reg_enable => '1',
      clk => clk,
      reg_data_out => carry_en_ex
    );

  zero_en_alu_ex_reg_out : register_1
    port map(
      reg_data_in => zero_en_alu,
      reg_enable => '1',
     clk => clk,
      reg_data_out => zero_en_alu_ex
    );

  zero_en_mem_ex_reg_out : register_1
    port map(
      reg_data_in => zero_en_mem,
      reg_enable => '1',
      clk => clk,
      reg_data_out => zero_en_mem_ex
  );

  cz_ex_reg_out : register_2
    port map(
      reg_data_in => cz,
      reg_enable => '1',
      clk => clk,
      reg_data_out => cz_ex
    );

  opcode_ex_reg_out : register_4 --
    port map (
      reg_data_in => opcode,
      reg_enable => '1',
      clk => clk,
      reg_data_out => opcode_ex
    );

  lm_detect_ex_reg_out : register_1
    port map (
      reg_data_in => lm_detect,
      reg_enable => '1',
      clk => clk,
      reg_data_out => lm_detect_ex
    );

  sm_detect_ex_reg_out : register_1
    port map (
      reg_data_in => sm_detect,
      reg_enable => '1',
      clk => clk,
      reg_data_out => sm_detect_ex
    );

  lw_sw_stop_ex_reg_out : register_1
    port map (
      reg_data_in => lw_sw_stop,
      reg_enable => '1',
      clk => clk,
      reg_data_out => lw_sw_stop_ex
    );

first_lw_sw_ex_reg_out : register_1
  port map (
    reg_data_in => first_lw_sw,
    reg_enable => '1',
    clk => clk,      reg_data_out => first_lw_sw_ex    );

  right_shift_lm_sm_bit_ex_reg_out : register_1
    port map (
      reg_data_in => right_shift_lm_sm_bit,
      reg_enable => '1',
      clk => clk,
     reg_data_out => right_shift_lm_sm_bit_ex
    );

  lm_sm_reg_write_ex_reg_out : register_3
    port map (
      reg_data_in => lm_sm_reg_write,
      reg_enable => '1',
      clk => clk,
      reg_data_out => lm_sm_reg_write_ex
    );

  lm_sm_write_load_ex_reg_out : register_1
    port map (
      reg_data_in => lm_sm_write_load,
      reg_enable => '1',
      clk => clk,
      reg_data_out => lm_sm_write_load_ex
    );

  alu2_out_ex_reg_out : register_16 --alu2_out to IF stage
    port map(
      reg_data_in => alu2_out,
      reg_enable => '1',
      clk => clk,
      reg_data_out => alu2_out_ex
    );

  valid_bit_or_ex_reg : register_1
    port map(
      reg_data_in => valid_bit_id_or,
      reg_enable => '1',
      clk => clk,
      reg_data_out => valid_bit_or_ex
      );

  valid_bit_or_ex_reg : register_1
    port map(
      reg_data_in => valid_bit_id_id_or,
      reg_enable => '1',
      clk => clk,
      reg_data_out => valid_bit_id_or_ex
      );

  valid_bit_or_ex_reg : register_1
    port map(
      reg_data_in => valid_bit_signal,
      reg_enable => '1',
      clk => clk,
      reg_data_out => valid_bit_or_or_ex
      );


end architecture ; -- op_read
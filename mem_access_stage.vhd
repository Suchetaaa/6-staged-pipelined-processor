library ieee;
library work;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use work.components_init.all;
use work.memcomp.all;
entity mem_access_stage is
  port (
    clk : in std_logic;
    reset : in std_logic;
    --signals from previous stages 
    data_ra_mem : in std_logic_vector(15 downto 0);
    data_rb_mem : in std_logic_vector(15 downto 0);
    data_carry_mem : in std_logic;
    data_zero_mem : in std_logic;
    pc_out_mem : in std_logic_vector(15 downto 0);
    alu1_op_mem : in std_logic_vector(1 downto 0);
    alu1_a_select_mem : in std_logic;
    alu1_b_select_mem : in std_logic_vector(1 downto 0);
    rf_write_mem : std_logic;
    rf_a3_mem : in std_logic_vector(2 downto 0);
    rf_data_select_mem : in std_logic_vector(2 downto 0);
    mem_write_mem : in std_logic;
    mem_read_mem : in std_logic;
    mem_data_sel_mem : in std_logic;
    mem_address_sel_mem : in std_logic;
    ir_5_0_mem : in std_logic_vector(15 downto 0);
    ir_8_0_mem : in std_logic_vector(15 downto 0);
    data_extender_out_mem : in std_logic_vector(15 downto 0);
    carry_en_mem : in std_logic;
    zero_en_alu_mem : in std_logic;
    zero_en_mem_mem : in std_logic;
    cz_mem : in std_logic_vector(1 downto 0);
    opcode_mem : in std_logic_vector(3 downto 0);
    lm_detect_mem : in std_logic;
    sm_detect_mem : in std_logic;
    lw_sw_stop_mem : in std_logic;
    first_lw_sw_mem : in std_logic;
    right_shift_lm_sm_bit_mem : std_logic;
    lm_sm_reg_write_mem : in std_logic_vector(2 downto 0);
    lm_sm_write_load_mem : in std_logic;
    alu2_out_mem : in std_logic_vector(15 downto 0);

    -----Outputs----
    --From memory access stage
    mem_data_out : out std_logic_vector(15 downto 0);
    --Carry forward signals 
    data_ra_wb : in std_logic_vector(15 downto 0);
    data_rb_wb : in std_logic_vector(15 downto 0);
    data_carry_wb : in std_logic;
    data_zero_wb : in std_logic;
    pc_out_wb : in std_logic_vector(15 downto 0);
    alu1_op_wb : in std_logic_vector(1 downto 0);
    alu1_a_select_wb : in std_logic;
    alu1_b_select_wb : in std_logic_vector(1 downto 0);
    rf_write_wb : std_logic;
    rf_a3_wb : in std_logic_vector(2 downto 0);
    rf_data_select_wb : in std_logic_vector(2 downto 0);
    mem_write_wb : in std_logic;
    mem_read_wb : in std_logic;
    mem_data_sel_wb : in std_logic;
    mem_address_sel_wb : in std_logic;
    ir_5_0_wb : in std_logic_vector(15 downto 0);
    ir_8_0_wb : in std_logic_vector(15 downto 0);
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
    alu2_out_wb : in std_logic_vector(15 downto 0)

  ) ;
end entity ; -- instruction_memory

architecture arch of mem_access_stage is
    signal memcomp_database : data_memory_database_type := memcomp;
    signal mem_data_out_signal : std_logic_vector(15 downto 0);
begin

process(clk) is

begin
    if rising_edge(clk) then
      if valid_bit = '1' then -- Where is it coming from????
        if mem_write = '1' then
          if mem_data_sel = '0' then
            mem_array(to_integer(unsigned(alu1_out_mem(15 downto 0)))) <= Data1(15 downto 0);    
          end if;
        end if;
      end if;
    end if;
end process;

mem_data_out_signal(15 downto 0) <= mem_array(to_integer(unsigned(ALU1_out(15 downto 0)))); 

mem_data_out_reg : register_16 
  port map (
    reg_data_in => mem_data_out_signal,
    reg_enable => mem_read_mem,
    clk => clk,
    reg_data_out => mem_data_out
  );

mem_data_out_reg : register_16 
  port map (
    reg_data_in => mem_data_out_signal,
    reg_enable => mem_read_mem,
    clk => clk,
    reg_data_out => mem_data_out
  );

mem_data_out_reg : register_16 
  port map (
    reg_data_in => mem_data_out_signal,
    reg_enable => mem_read_mem,
    clk => clk,
    reg_data_out => mem_data_out
  );

mem_data_out_reg : register_16 
  port map (
    reg_data_in => mem_data_out_signal,
    reg_enable => mem_read_mem,
    clk => clk,
    reg_data_out => mem_data_out
  );

mem_data_out_reg : register_16 
  port map (
    reg_data_in => mem_data_out_signal,
    reg_enable => mem_read_mem,
    clk => clk,
    reg_data_out => mem_data_out
  );

mem_data_out_reg : register_16 
  port map (
    reg_data_in => mem_data_out_signal,
    reg_enable => mem_read_mem,
    clk => clk,
    reg_data_out => mem_data_out
  );

mem_data_out_reg : register_16 
  port map (
    reg_data_in => mem_data_out_signal,
    reg_enable => mem_read_mem,
    clk => clk,
    reg_data_out => mem_data_out
  );







end architecture ; -- arch
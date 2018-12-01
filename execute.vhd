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
    -- signals to forward
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
  );
end entity;
architecture arch of execute is
  signal alu1_a_ip : std_logic_vector(15 downto 0);
  signal alu1_b_ip : std_logic_vector(15 downto 0);
  signal alu1_c_op : std_logic;
  signal alu1_z_op : std_logic;
  signal ra_temp : std_logic_vector(15 downto 0);
  signal rb_temp : std_logic_vector(15 downto 0);
  signal alu1_out_temp : std_logic_vector(15 downto 0);
  signal c_out : std_logic;
  signal z_out : std_logic;
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

  carry_zero : process(alu1_c_op, alu1_z_op, carry_en_ex, zero_en_alu_ex)
  begin
    if carry_en_ex = '1' then
      c_out <= 
    end if;
  end process ; -- carry_zero

  -- No hazard
  ra_temp <= data_ra;
  rb_temp <= data_rb;

end architecture ; -- arch
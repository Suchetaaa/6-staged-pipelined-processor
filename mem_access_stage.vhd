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
    alu1_out_mem : in std_logic_vector(15 downto 0);
    alu1_carry_mem : in std_logic;
    alu1_zero_mem : in std_logic;
    cond_carry_mem : in std_logic;
    cond_zero_mem : in std_logic;

    data_ra_mem : in std_logic_vector(15 downto 0);
    data_rb_mem : in std_logic_vector(15 downto 0);
    pc_out_mem : in std_logic_vector(15 downto 0);
    rf_write_mem : std_logic;
    rf_a3_mem : in std_logic_vector(2 downto 0);
    rf_data_select_mem : in std_logic_vector(2 downto 0);
    mem_write_mem : in std_logic;
    mem_read_mem : in std_logic;
    mem_data_sel_mem : in std_logic;
    mem_address_sel_mem : in std_logic;
--    ir_5_0_mem : in std_logic_vector(15 downto 0);
--    ir_8_0_mem : in std_logic_vector(15 downto 0);
    data_extender_out_mem : in std_logic_vector(15 downto 0);
    carry_en_mem : in std_logic;
    zero_en_alu_mem : in std_logic;
    zero_en_mem_mem : in std_logic;
    lm_detect_mem : in std_logic;
    sm_detect_mem : in std_logic;
    lw_sw_stop_mem : in std_logic;
    first_lw_sw_mem : in std_logic;
    right_shift_lm_sm_bit_mem : std_logic;
    lm_sm_reg_write_mem : in std_logic_vector(2 downto 0);
    lm_sm_write_load_mem : in std_logic;
--    alu2_out_mem : in std_logic_vector(15 downto 0);

    -----Outputs----
    --From memory access stage
    mem_data_out : out std_logic_vector(15 downto 0);
    --from alu-out
    alu1_out_wb : out std_logic_vector(15 downto 0);
    alu1_carry_wb : out std_logic;
    alu1_zero_wb : out std_logic;
    cond_carry_wb : out std_logic;
    cond_zero_wb : out std_logic;

    --Carry forward signals 
    data_ra_wb : out std_logic_vector(15 downto 0);
    data_rb_wb : out std_logic_vector(15 downto 0);
    pc_out_wb : out std_logic_vector(15 downto 0);
    rf_write_wb : out std_logic;
    rf_a3_wb : out std_logic_vector(2 downto 0);
    rf_data_select_wb : out std_logic_vector(2 downto 0);
    --mem_write_wb : out std_logic;
    --mem_read_wb : out std_logic;
    --mem_data_sel_wb : out std_logic;
    --mem_address_sel_wb : out std_logic;
    --ir_5_0_wb : out std_logic_vector(15 downto 0);
    --ir_8_0_wb : out std_logic_vector(15 downto 0);
    data_extender_out_wb : out std_logic_vector(15 downto 0);
    carry_en_wb : out std_logic;
    zero_en_alu_wb : out std_logic;
    zero_en_mem_wb : out std_logic;
    lm_detect_wb : out std_logic;
    sm_detect_wb : out std_logic;
    lw_sw_stop_wb : out std_logic;
    first_lw_sw_wb : out std_logic;
    right_shift_lm_sm_bit_wb : out std_logic;
    lm_sm_reg_write_wb : out std_logic_vector(2 downto 0);
    lm_sm_write_load_wb : out std_logic
--    alu2_out_wb : out std_logic_vector(15 downto 0)

  ) ;
end entity ; -- instruction_memory

architecture arch of mem_access_stage is
    signal mem_array : data_memory_database_type := memcomp;
    signal mem_data_out_signal : std_logic_vector(15 downto 0);
begin

process(clk) is

begin
    if rising_edge(clk) then
      --if valid_bit = '1' then -- Where is it coming from????
        if mem_write_mem = '1' then
          if mem_data_sel_mem = '0' then
            mem_array(to_integer(unsigned(alu1_out_mem(15 downto 0)))) <= data_ra_mem(15 downto 0);    
          --end if;
        end if;
      end if;
    end if;
end process;

mem_data_out_signal(15 downto 0) <= mem_array(to_integer(unsigned(alu1_out_mem(15 downto 0)))); 

mem_data_out_reg : register_16 
  port map (
    reg_data_in => mem_data_out_signal,
    reg_enable => mem_read_mem,
    clk => clk,
    reg_data_out => mem_data_out
  );

alu1_out_reg_out : register_16 
    port map (
      reg_data_in => alu1_out_mem,
      reg_enable => '1',
      clk => clk,
      reg_data_out => alu1_out_wb
  );

alu1_carry_reg_out : register_1 
  port map (
    reg_data_in => alu1_carry_mem,
    reg_enable => '1',
    clk => clk,
    reg_data_out => alu1_carry_wb
);

alu1_zero_reg_out : register_1
  port map (
    reg_data_in => alu1_zero_mem,
    reg_enable => '1',
    clk => clk,
    reg_data_out => alu1_zero_wb
);

cond_carry_reg_out : register_1
  port map (
    reg_data_in => cond_carry_mem,
    reg_enable => '1',
    clk => clk,
    reg_data_out => cond_carry_wb
);

cond_zero_reg_out : register_1 
  port map (
    reg_data_in => cond_zero_mem,
    reg_enable => '1',
    clk => clk,
    reg_data_out => cond_zero_wb
);

data_ra_reg_out : register_16
  port map (
    reg_data_in => data_ra_mem,
    reg_enable => '1',
    clk => clk,
    reg_data_out => data_ra_wb
);

dat_rb_reg_out : register_16 
  port map (
    reg_data_in => data_rb_mem,
    reg_enable => '1',
    clk => clk,
    reg_data_out => data_rb_wb
);

pc_out_reg_out : register_16 
  port map (
    reg_data_in => pc_out_mem,
    reg_enable => '1',
    clk => clk,
    reg_data_out => pc_out_wb
);

rf_write_reg_out : register_1
  port map (
    reg_data_in => rf_write_mem,
    reg_enable => '1',
    clk => clk,
    reg_data_out => rf_write_wb
);

rf_a3_reg_out : register_3 
  port map (
    reg_data_in => rf_a3_mem,
    reg_enable => '1',
    clk => clk,
    reg_data_out => rf_a3_wb
);

rf_data_select_reg_out : register_3
  port map (
    reg_data_in => rf_data_select_mem,
    reg_enable => '1',
    clk => clk,
    reg_data_out => rf_data_select_wb
);

--mem_write_reg_out : register_1
--  port map (
--    reg_data_in => mem_write_mem,
--    reg_enable => '1',
--    clk => clk,
--    reg_data_out => mem_write_wb
--);
--
--  mem_read_reg_out : register_1
--    port map (
--      reg_data_in => mem_read_mem,
--      reg_enable => '1',
--      clk => clk,
--      reg_data_out => mem_read_wb
--  );
--
--  mem_data_sel_reg_out : register_1
--    port map (
--      reg_data_in => mem_data_sel_mem,
--      reg_enable => '1',
--      clk => clk,
--      reg_data_out => mem_data_sel_wb
--  );
--
--  mem_address_sel_reg_out : register_1
--    port map (
--      reg_data_in => mem_address_sel_mem,
--      reg_enable => '1',
--      clk => clk,
--      reg_data_out => mem_address_sel_wb
--  );
--
--  ir_5_0_reg_out : register_16
--    port map (
--      reg_data_in => ir_5_0_mem,
--      reg_enable => '1',
--      clk => clk,
--      reg_data_out => ir_5_0_wb
--  );
--
--  ir_8_0_reg_out : register_16
--    port map (
--      reg_data_in => ir_8_0_mem,
--      reg_enable => '1',
--      clk => clk,
--      reg_data_out => ir_8_0_wb
--  );

  data_extender_reg_out : register_16
    port map (
      reg_data_in => data_extender_out_mem,
      reg_enable => '1',
      clk => clk,
      reg_data_out => data_extender_out_wb
  );

  carry_en_reg_out : register_1
    port map (
      reg_data_in => carry_en_mem,
      reg_enable => '1',
      clk => clk,
      reg_data_out => carry_en_wb
  );

  zero_en_alu_reg_out : register_1
    port map (
      reg_data_in => zero_en_alu_mem,
      reg_enable => '1',
      clk => clk,
      reg_data_out => zero_en_alu_wb
  );

  zero_en_mem_reg_out : register_1
    port map (
      reg_data_in => zero_en_mem_mem,
      reg_enable => '1',
      clk => clk,
      reg_data_out => zero_en_mem_wb
  );

  lm_detect_reg_out : register_1
    port map (
      reg_data_in => lm_detect_mem,
      reg_enable => '1',
      clk => clk,
      reg_data_out => lm_detect_wb
  );

  sm_detect_reg_out : register_1
    port map (
      reg_data_in => sm_detect_mem,
      reg_enable => '1',
      clk => clk,
      reg_data_out => sm_detect_wb
  );

  lw_sw_reg_out : register_1
    port map (
      reg_data_in => lw_sw_stop_mem,
      reg_enable => '1',
      clk => clk,
      reg_data_out => lw_sw_stop_wb
  );

  first_lw_sw_reg_out : register_1
    port map (
      reg_data_in => first_lw_sw_mem,
      reg_enable => '1',
      clk => clk,
      reg_data_out => first_lw_sw_wb
  );

  right_shift_lm_sm_bit_reg_out : register_1
    port map (
      reg_data_in => right_shift_lm_sm_bit_mem,
      reg_enable => '1',
      clk => clk,
      reg_data_out => right_shift_lm_sm_bit_wb
  );

  lm_sm_reg_write_reg_out : register_3
    port map (
      reg_data_in => lm_sm_reg_write_mem,
      reg_enable => '1',
      clk => clk,
      reg_data_out => lm_sm_reg_write_wb
  );

  lm_sm_write_load_reg_out : register_1
    port map (
      reg_data_in => lm_sm_write_load_mem,
      reg_enable => '1',
      clk => clk,
      reg_data_out => lm_sm_write_load_wb
  );

--  alu2_out_reg_out : register_16
--    port map (
--      reg_data_in => alu2_out_mem,
--      reg_enable => '1',
--      clk => clk,
--      reg_data_out => alu2_out_wb
--  );







end architecture ; -- arch
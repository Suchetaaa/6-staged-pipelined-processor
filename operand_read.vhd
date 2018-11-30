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

    alu1_op : in std_logic_vector(1 downto 0);
    --Select signals for alu1 - a
    --0 - D1
    --1 - D2
    alu1_a_select : in std_logic_vector(0 downto 0);
    --0 - D2
    --1 - SE6
    alu1_b_select : in std_logic_vector(0 downto 0);

    --alu2 - b select
    alu2_b_select : in std_logic_vector(1 downto 0);

    --Register File 
    rf_write : in std_logic;
    --Tells if A1 has to be read 
    rf_a1_read : in std_logic;
    --Tells if A2 has to be read
    rf_a2_read : in std_logic;
    --address of the register to which writing is taking place
    rf_a3 : in std_logic_vector(2 downto 0);
    --selection signals for data which is to be written back to RF 
    rf_data_select : in std_logic_vector(2 downto 0);

    --Memory 
    mem_write : in std_logic;
    mem_read : in std_logic;
    mem_data_sel : in std_logic;
    mem_address_sel : in std_logic;

    --RA
    ir_11_9 : in std_logic_vector(2 downto 0);
    --RB
    ir_8_6 : in std_logic_vector(2 downto 0);
    --RC
    ir_5_3 : in std_logic_vector(2 downto 0);
    --After sign extensions 6 and 9 respectively
    ir_5_0 : in std_logic_vector(15 downto 0);
    ir_8_0 : in std_logic_vector(15 downto 0);
    --Data coming out of data extender block 
    data_extender_out : in std_logic_vector(15 downto 0);

    --Carry and zero enables
    carry_en : in std_logic;
    zero_en_alu : in std_logic;
    zero_en_mem : in std_logic;

    --Other stuff 
    cz : in std_logic_vector(1 downto 0);
    opcode : in std_logic_vector(3 downto 0);

    --LM/SM signals 
    lm_detect : in std_logic;
    sm_detect : in std_logic;

    lw_stop : in std_logic;
    sw_stop : in std_logic;

    first_lw_sw : in std_logic;

    right_shift_lm_sm_bit : in std_logic;

    lm_sm_reg_write : in std_logic_vector(2 downto 0);

    --alu2_out to IF stage
    alu2_out : in std_logic_vector(15 downto 0)

    -- the register values read 
    data_ra : out std_logic_vector(15 downto 0)
    data_rb : out std_logic_vector(15 downto 0)

  );
end entity;

architecture op_read of operand_read is

  signal ra_read_temp : std_logic_vector(15 downto 0);
  signal rb_read_temp : std_logic_vector(15 downto 0);

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
      carry_read : in std_logic;
      zero_read : in std_logic;

      reg_file_write => ,
      carry_write : in std_logic;
      zero_write : in std_logic;


      --Address - 1 signal value 
      address_1 => ir_11_9,
      --Address - 2 signal value 
      address_2 => ir_8_6,
      --Address - 3 signal value for writing to A3
      address_3 => ,

      --Data in and out signal values 
      data_in : in std_logic_vector(15 downto 0);
      carry_in : in std_logic;
      zero_in : in std_logic;

      data_out_ra => ,
      data_out_rb => ,
      carry_out => ,
      zero_out =>
    ) ;
end architecture ; -- op_read
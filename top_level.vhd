library std;
library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.components_init.all;

entity top_level is
  port(
    clk : in std_logic;
    reset: in std_logic;

  );
end entity;
architecture at of top_level is

  signal 

begin
  port (
  clk : in std_logic;
  reset: in std_logic;
  pc_select : in std_logic_vector(1 downto 0);
  pc_register_enable : in std_logic;
  ir_enable : in std_logic;
  mem_data_out : in std_logic_vector(15 downto 0);
  alu1_out : in std_logic_vector(15 downto 0);
  alu2_out : in std_logic_vector(15 downto 0);
  instruction_int_out : out std_logic_vector(15 downto 0);
  pc_register_int_out : out std_logic_vector(15 downto 0)
  ) ;

end architecture ; -- at
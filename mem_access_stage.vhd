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
    mem_out : out std_logic_vector(15 downto 0);
    mem_write : in std_logic;
    mem_read : in std_logic;
    valid_bit_mem : in std_logic;
    mem_data_sel : in std_logic;
    mem_address_sel : in std_logic;
        clk : in std_logic
  ) ;
end entity ; -- instruction_memory
architecture arch of mem_access_stage is
    signal memcomp_database : data_memory_database_type := memcomp;
begin
process(clk) is
begin
     if rising_edge(clk) then
            if valid_bit = '1' then
                 if mem_write = '1' then
                    if mem_data_sel = '0' then
                        mem_array(to_integer(unsigned(ALU1_out(15 downto 0)))) <= Data1(15 downto 0);    
                    end if;
                 end if;
       end if;
    end if;
end process;
mem_out(15 downto 0) <= mem_array(to_integer(unsigned(ALU1_out(15 downto 0))));  
end architecture ; -- arch
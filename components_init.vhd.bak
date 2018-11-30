library ieee;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

package components_init is 

	component incrementer_pc is 
		port (
			incrementer_pc_in : in std_logic_vector(15 downto 0);
			incrementer_pc_out : out std_logic_vector(15 downto 0)
		);
	end component incrementer_pc;
	
	component register_16 is 
		port (
			reg_data_in : in std_logic_vector(15 downto 0);
			reg_enable : in std_logic;
			clk : in std_logic;
			reg_data_out : out std_logic_vector(15 downto 0)
		);
	end component register_16;
	
	component instruction_memory is 
		port (
			address_in : in std_logic_vector(15 downto 0); 
			instruction_out : out std_logic_vector(15 downto 0)
		);
	end component instruction_memory;

	component priority_encoder is
  		port (
			priority_in : in std_logic_vector(7 downto 0);
			priority_enable : in std_logic;
			priority_out : out std_logic_vector(7 downto 0)
		) ;
	end component priority_encoder ; -- priority_encoder

	component right_shift is
		port (
			right_shift_in : in std_logic_vector(7 downto 0);
			right_shift_out : out std_logic_vector(7 downto 0)
		) ;
	end component right_shift ; -- right_shift

	component register_16 is
		port (
		  	reg_data_in : in std_logic_vector(15 downto 0);
		  	reg_enable : in std_logic;
			clk : in std_logic;
		  	reg_data_out : out std_logic_vector(15 downto 0)
		) ;
	end component register_16 ; -- register_16

	component register_1 is
	  	port (
		  	reg_data_in : in std_logic;
		  	reg_enable : in std_logic;
			clk : in std_logic;
		  	reg_data_out : out std_logic
	  	) ;
	end component register_1 ; -- register_1

	component register_2 is
		port (
			reg_data_in : in std_logic_vector(1 downto 0);
			reg_enable : in std_logic;
			clk : in std_logic;
		  	reg_data_out : out std_logic_vector(1 downto 0)
		) ;
	end component register_2; -- register_1

	component register_3 is
		port (
			reg_data_in : in std_logic_vector(2 downto 0);
			reg_enable : in std_logic;
			clk : in std_logic;
		  	reg_data_out : out std_logic_vector(2 downto 0)
		) ;
	end component register_3; -- register_1

	component register_4 is
		port (
			reg_data_in : in std_logic_vector(3 downto 0);
			reg_enable : in std_logic;
			clk : in std_logic;
		  	reg_data_out : out std_logic_vector(3 downto 0)
		) ;
	end component register_4; -- register_1

	component decoder is
  		port (
			decoder_in : in std_logic_vector(7 downto 0);
			decoder_out : out std_logic_vector(2 downto 0)
  		) ;
	end component decoder ; -- decoder


	component reg_file is
		port(
			clk : in std_logic;
			reset : in std_logic;
			reg_file_read_ra : in std_logic;
			reg_file_read_rb : in std_logic;
			reg_file_write : in std_logic;
			address_1 : in std_logic_vector(2 downto 0);
			address_2 : in std_logic_vector(2 downto 0);
			address_3 : in std_logic_vector(2 downto 0);
			data_in : in std_logic_vector(15 downto 0);
			data_out_ra : out std_logic_vector(15 downto 0);
			data_out_rb : out std_logic_vector(15 downto 0)
		);
	end component  reg_file;

	component instruction_fetch is
		port(
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
		);
	end component instruction_fetch;
	
end components_init;
	
	
	
	
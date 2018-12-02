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
	
	component data_extender is
	  port (
			data_extender_in : in std_logic_vector(8 downto 0);
			data_extender_out : out std_logic_vector(15 downto 0)
	  ) ;
	end component data_extender ; -- data_extender
	
	component alu2 is
		port (
			--No clock and no register
			alu2_a : in std_logic_vector(15 downto 0);
			alu2_b : in std_logic_vector(15 downto 0);
			alu2_out : out std_logic_vector(15 downto 0)
		) ;
	end component alu2 ; -- alu2
	
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
	
	component sign_extender_9 is
		port (
			se9_in : in std_logic_vector(8 downto 0);
			se9_out : out std_logic_vector(15 downto 0)
		) ;
	end component sign_extender_9 ; -- sign_extender_9
	
	component sign_extender_6 is
		port (
			se6_in : in std_logic_vector(5 downto 0);
			se6_out : out std_logic_vector(15 downto 0)
		) ;
	end component sign_extender_6 ; -- sign_extender_6

	component register_1 is
	  	port (
		  	reg_data_in : in std_logic;
		  	reg_enable : in std_logic;
			clk : in std_logic;
		  	reg_data_out : out std_logic
	  	) ;
	end component register_1 ; -- register_1
	
	component register_8 is
		port (
			reg_data_in : in std_logic_vector(7 downto 0);
			reg_enable : in std_logic;
			clk : in std_logic;
			reg_data_out : out std_logic_vector(7 downto 0)
		) ;
	end component register_8 ; -- register_8

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
			carry_read : in std_logic;
			zero_read : in std_logic;
			reg_file_read_ra : in std_logic;
			reg_file_read_rb : in std_logic;
			reg_file_write : in std_logic;
			carry_write : in std_logic;
			zero_write : in std_logic;
			address_1 : in std_logic_vector(2 downto 0);
			address_2 : in std_logic_vector(2 downto 0);
			address_3 : in std_logic_vector(2 downto 0);
			data_in : in std_logic_vector(15 downto 0);
			carry_in : in std_logic;
			zero_in : in std_logic;
			data_out_ra : out std_logic_vector(15 downto 0);
			data_out_rb : out std_logic_vector(15 downto 0);
			carry_out : out std_logic;
			zero_out : out std_logic
		);
	end component reg_file;

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

	component alu1 is
		port (
			alu_a : in std_logic_vector(15 downto 0);
			alu_b : in std_logic_vector(15 downto 0);
			alu_op : in std_logic_vector(1 downto 0);
			alu_out : out std_logic_vector(15 downto 0);
			carry : out std_logic;
			zero : out std_logic
  	) ;
  end component alu1;

  component instruction_decode is
	  port (
			clk : in std_logic;
			reset : in std_logic;
			pc_register_int_out : in std_logic_vector(15 downto 0);
			instruction_int_out : in std_logic_vector(15 downto 0);
			pc_out : out std_logic_vector(15 downto 0);
			alu1_op : out std_logic_vector(1 downto 0);
			alu1_a_select : out std_logic;
			alu1_b_select : out std_logic_vector(1 downto 0);
			rf_write : out std_logic;
			rf_a1_read : out std_logic;
			rf_a2_read : out std_logic;
			rf_a3 : out std_logic_vector(2 downto 0);
			rf_data_select : out std_logic_vector(2 downto 0);
			mem_write : out std_logic;
			mem_read : out std_logic;
			mem_data_sel : out std_logic;
			mem_address_sel : out std_logic;
			ir_11_9 : out std_logic_vector(2 downto 0);
			ir_8_6 : out std_logic_vector(2 downto 0);
			ir_5_3 : out std_logic_vector(2 downto 0);
			ir_5_0 : out std_logic_vector(15 downto 0);
			ir_8_0 : out std_logic_vector(15 downto 0);
			data_extender_out : out std_logic_vector(15 downto 0);
			carry_en : out std_logic;
			zero_en_alu : out std_logic;
			zero_en_mem : out std_logic;
			cz : out std_logic_vector(1 downto 0);
			opcode : out std_logic_vector(3 downto 0);
			lm_detect : out std_logic;
			sm_detect : out std_logic;
			lw_sw_stop : out std_logic;
			first_lw_sw : out std_logic;
			right_shift_lm_sm_bit : out std_logic;
			lm_sm_reg_write : out std_logic_vector(2 downto 0);
			lm_sm_write_load : out std_logic;
			alu2_out : out std_logic_vector(15 downto 0)
	  ) ;
	 end component instruction_decode;

	component operand_read is
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

	    --rf_a3_wb_in : in std_logic_vector(2 downto 0);
	    --rf_write_wb_in : in std_logic;
	    --valid_bit_wb_in : in std_logic;
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
	    alu2_out_ex : out std_logic_vector(15 downto 0) --alu2_out to IF stage
	  );
	end component;
	
end components_init;
	
	
	
	
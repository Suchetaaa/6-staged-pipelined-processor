-- Copyright (C) 1991-2016 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus Prime License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 16.0.0 Build 211 04/27/2016 SJ Lite Edition"

-- DATE "11/30/2018 17:47:29"

-- 
-- Device: Altera EP4CE6F17C6 Package FBGA256
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	instruction_fetch IS
    PORT (
	clk : IN std_logic;
	reset : IN std_logic;
	pc_select : IN std_logic_vector(1 DOWNTO 0);
	pc_register_enable : IN std_logic;
	ir_enable : IN std_logic;
	mem_data_out : IN std_logic_vector(15 DOWNTO 0);
	alu1_out : IN std_logic_vector(15 DOWNTO 0);
	alu2_out : IN std_logic_vector(15 DOWNTO 0);
	instruction_int_out : OUT std_logic_vector(15 DOWNTO 0);
	pc_register_int_out : OUT std_logic_vector(15 DOWNTO 0)
	);
END instruction_fetch;

-- Design Ports Information
-- instruction_int_out[0]	=>  Location: PIN_K1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction_int_out[1]	=>  Location: PIN_N1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction_int_out[2]	=>  Location: PIN_T6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction_int_out[3]	=>  Location: PIN_C8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction_int_out[4]	=>  Location: PIN_R6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction_int_out[5]	=>  Location: PIN_M6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction_int_out[6]	=>  Location: PIN_L7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction_int_out[7]	=>  Location: PIN_N8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction_int_out[8]	=>  Location: PIN_N5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction_int_out[9]	=>  Location: PIN_E8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction_int_out[10]	=>  Location: PIN_L2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction_int_out[11]	=>  Location: PIN_P6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction_int_out[12]	=>  Location: PIN_R7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction_int_out[13]	=>  Location: PIN_D8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction_int_out[14]	=>  Location: PIN_A8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction_int_out[15]	=>  Location: PIN_L4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pc_register_int_out[0]	=>  Location: PIN_L8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pc_register_int_out[1]	=>  Location: PIN_T5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pc_register_int_out[2]	=>  Location: PIN_N6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pc_register_int_out[3]	=>  Location: PIN_M8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pc_register_int_out[4]	=>  Location: PIN_M7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pc_register_int_out[5]	=>  Location: PIN_K5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pc_register_int_out[6]	=>  Location: PIN_R3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pc_register_int_out[7]	=>  Location: PIN_N2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pc_register_int_out[8]	=>  Location: PIN_R4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pc_register_int_out[9]	=>  Location: PIN_T4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pc_register_int_out[10]	=>  Location: PIN_T3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pc_register_int_out[11]	=>  Location: PIN_T2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pc_register_int_out[12]	=>  Location: PIN_T7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pc_register_int_out[13]	=>  Location: PIN_R5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pc_register_int_out[14]	=>  Location: PIN_F8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pc_register_int_out[15]	=>  Location: PIN_K8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_E1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ir_enable	=>  Location: PIN_P1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pc_register_enable	=>  Location: PIN_R9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu1_out[0]	=>  Location: PIN_L9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pc_select[0]	=>  Location: PIN_T10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pc_select[1]	=>  Location: PIN_P2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- mem_data_out[0]	=>  Location: PIN_R10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu2_out[0]	=>  Location: PIN_P14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reset	=>  Location: PIN_M2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu1_out[1]	=>  Location: PIN_P8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- mem_data_out[1]	=>  Location: PIN_B9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu2_out[1]	=>  Location: PIN_N3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu2_out[2]	=>  Location: PIN_N15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- mem_data_out[2]	=>  Location: PIN_D9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu1_out[2]	=>  Location: PIN_T15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu1_out[3]	=>  Location: PIN_T9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- mem_data_out[3]	=>  Location: PIN_P15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu2_out[3]	=>  Location: PIN_R14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu2_out[4]	=>  Location: PIN_P11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- mem_data_out[4]	=>  Location: PIN_N11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu1_out[4]	=>  Location: PIN_L11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu1_out[5]	=>  Location: PIN_T12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- mem_data_out[5]	=>  Location: PIN_C9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu2_out[5]	=>  Location: PIN_A9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu2_out[6]	=>  Location: PIN_N12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- mem_data_out[6]	=>  Location: PIN_K10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu1_out[6]	=>  Location: PIN_P16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu1_out[7]	=>  Location: PIN_E9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- mem_data_out[7]	=>  Location: PIN_M1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu2_out[7]	=>  Location: PIN_P3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu2_out[8]	=>  Location: PIN_R13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- mem_data_out[8]	=>  Location: PIN_R16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu1_out[8]	=>  Location: PIN_T13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu1_out[9]	=>  Location: PIN_B8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- mem_data_out[9]	=>  Location: PIN_T8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu2_out[9]	=>  Location: PIN_A10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu2_out[10]	=>  Location: PIN_L12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- mem_data_out[10]	=>  Location: PIN_R11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu1_out[10]	=>  Location: PIN_R1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu1_out[11]	=>  Location: PIN_L14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- mem_data_out[11]	=>  Location: PIN_R8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu2_out[11]	=>  Location: PIN_M9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu2_out[12]	=>  Location: PIN_L10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- mem_data_out[12]	=>  Location: PIN_M10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu1_out[12]	=>  Location: PIN_B10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu1_out[13]	=>  Location: PIN_P9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- mem_data_out[13]	=>  Location: PIN_T14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu2_out[13]	=>  Location: PIN_M11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu2_out[14]	=>  Location: PIN_R12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- mem_data_out[14]	=>  Location: PIN_T11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu1_out[14]	=>  Location: PIN_L1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu1_out[15]	=>  Location: PIN_N9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- mem_data_out[15]	=>  Location: PIN_K9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu2_out[15]	=>  Location: PIN_N14,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF instruction_fetch IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_reset : std_logic;
SIGNAL ww_pc_select : std_logic_vector(1 DOWNTO 0);
SIGNAL ww_pc_register_enable : std_logic;
SIGNAL ww_ir_enable : std_logic;
SIGNAL ww_mem_data_out : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_alu1_out : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_alu2_out : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_instruction_int_out : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_pc_register_int_out : std_logic_vector(15 DOWNTO 0);
SIGNAL \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0_PORTAADDR_bus\ : std_logic_vector(6 DOWNTO 0);
SIGNAL \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0_PORTADATAOUT_bus\ : std_logic_vector(17 DOWNTO 0);
SIGNAL \reset~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \clk~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \instruction_int_out[0]~output_o\ : std_logic;
SIGNAL \instruction_int_out[1]~output_o\ : std_logic;
SIGNAL \instruction_int_out[2]~output_o\ : std_logic;
SIGNAL \instruction_int_out[3]~output_o\ : std_logic;
SIGNAL \instruction_int_out[4]~output_o\ : std_logic;
SIGNAL \instruction_int_out[5]~output_o\ : std_logic;
SIGNAL \instruction_int_out[6]~output_o\ : std_logic;
SIGNAL \instruction_int_out[7]~output_o\ : std_logic;
SIGNAL \instruction_int_out[8]~output_o\ : std_logic;
SIGNAL \instruction_int_out[9]~output_o\ : std_logic;
SIGNAL \instruction_int_out[10]~output_o\ : std_logic;
SIGNAL \instruction_int_out[11]~output_o\ : std_logic;
SIGNAL \instruction_int_out[12]~output_o\ : std_logic;
SIGNAL \instruction_int_out[13]~output_o\ : std_logic;
SIGNAL \instruction_int_out[14]~output_o\ : std_logic;
SIGNAL \instruction_int_out[15]~output_o\ : std_logic;
SIGNAL \pc_register_int_out[0]~output_o\ : std_logic;
SIGNAL \pc_register_int_out[1]~output_o\ : std_logic;
SIGNAL \pc_register_int_out[2]~output_o\ : std_logic;
SIGNAL \pc_register_int_out[3]~output_o\ : std_logic;
SIGNAL \pc_register_int_out[4]~output_o\ : std_logic;
SIGNAL \pc_register_int_out[5]~output_o\ : std_logic;
SIGNAL \pc_register_int_out[6]~output_o\ : std_logic;
SIGNAL \pc_register_int_out[7]~output_o\ : std_logic;
SIGNAL \pc_register_int_out[8]~output_o\ : std_logic;
SIGNAL \pc_register_int_out[9]~output_o\ : std_logic;
SIGNAL \pc_register_int_out[10]~output_o\ : std_logic;
SIGNAL \pc_register_int_out[11]~output_o\ : std_logic;
SIGNAL \pc_register_int_out[12]~output_o\ : std_logic;
SIGNAL \pc_register_int_out[13]~output_o\ : std_logic;
SIGNAL \pc_register_int_out[14]~output_o\ : std_logic;
SIGNAL \pc_register_int_out[15]~output_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputclkctrl_outclk\ : std_logic;
SIGNAL \ir_enable~input_o\ : std_logic;
SIGNAL \mem_data_out[0]~input_o\ : std_logic;
SIGNAL \pc_select[0]~input_o\ : std_logic;
SIGNAL \pc_select[1]~input_o\ : std_logic;
SIGNAL \alu2_out[0]~input_o\ : std_logic;
SIGNAL \pc_register_in~1_combout\ : std_logic;
SIGNAL \pc_register_in[0]~0_combout\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[0]~0_combout\ : std_logic;
SIGNAL \alu1_out[0]~input_o\ : std_logic;
SIGNAL \pc_register_in~2_combout\ : std_logic;
SIGNAL \reset~input_o\ : std_logic;
SIGNAL \reset~inputclkctrl_outclk\ : std_logic;
SIGNAL \pc_register_enable~input_o\ : std_logic;
SIGNAL \alu1_out[1]~input_o\ : std_logic;
SIGNAL \alu2_out[1]~input_o\ : std_logic;
SIGNAL \mem_data_out[1]~input_o\ : std_logic;
SIGNAL \pc_register_in~3_combout\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[0]~1\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[1]~2_combout\ : std_logic;
SIGNAL \pc_register_in~4_combout\ : std_logic;
SIGNAL \alu2_out[2]~input_o\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[1]~3\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[2]~4_combout\ : std_logic;
SIGNAL \alu1_out[2]~input_o\ : std_logic;
SIGNAL \mem_data_out[2]~input_o\ : std_logic;
SIGNAL \pc_register_in~5_combout\ : std_logic;
SIGNAL \pc_register_in~6_combout\ : std_logic;
SIGNAL \alu1_out[3]~input_o\ : std_logic;
SIGNAL \alu2_out[3]~input_o\ : std_logic;
SIGNAL \mem_data_out[3]~input_o\ : std_logic;
SIGNAL \pc_register_in~7_combout\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[2]~5\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[3]~6_combout\ : std_logic;
SIGNAL \pc_register_in~8_combout\ : std_logic;
SIGNAL \alu2_out[4]~input_o\ : std_logic;
SIGNAL \mem_data_out[4]~input_o\ : std_logic;
SIGNAL \alu1_out[4]~input_o\ : std_logic;
SIGNAL \pc_register_in~9_combout\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[3]~7\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[4]~8_combout\ : std_logic;
SIGNAL \pc_register_in~10_combout\ : std_logic;
SIGNAL \mem_data_out[5]~input_o\ : std_logic;
SIGNAL \alu2_out[5]~input_o\ : std_logic;
SIGNAL \pc_register_in~11_combout\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[4]~9\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[5]~10_combout\ : std_logic;
SIGNAL \alu1_out[5]~input_o\ : std_logic;
SIGNAL \pc_register_in~12_combout\ : std_logic;
SIGNAL \alu2_out[6]~input_o\ : std_logic;
SIGNAL \alu1_out[6]~input_o\ : std_logic;
SIGNAL \mem_data_out[6]~input_o\ : std_logic;
SIGNAL \pc_register_in~13_combout\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[5]~11\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[6]~12_combout\ : std_logic;
SIGNAL \pc_register_in~14_combout\ : std_logic;
SIGNAL \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0~portadataout\ : std_logic;
SIGNAL \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a1\ : std_logic;
SIGNAL \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a2\ : std_logic;
SIGNAL \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a3\ : std_logic;
SIGNAL \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a4\ : std_logic;
SIGNAL \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a5\ : std_logic;
SIGNAL \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a6\ : std_logic;
SIGNAL \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a7\ : std_logic;
SIGNAL \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a8\ : std_logic;
SIGNAL \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a9\ : std_logic;
SIGNAL \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a10\ : std_logic;
SIGNAL \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a11\ : std_logic;
SIGNAL \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a12\ : std_logic;
SIGNAL \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a13\ : std_logic;
SIGNAL \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a14\ : std_logic;
SIGNAL \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a15\ : std_logic;
SIGNAL \PC_int_Register|reg_data_out[0]~feeder_combout\ : std_logic;
SIGNAL \PC_int_Register|reg_data_out[1]~feeder_combout\ : std_logic;
SIGNAL \PC_int_Register|reg_data_out[2]~feeder_combout\ : std_logic;
SIGNAL \PC_int_Register|reg_data_out[3]~feeder_combout\ : std_logic;
SIGNAL \PC_int_Register|reg_data_out[4]~feeder_combout\ : std_logic;
SIGNAL \PC_int_Register|reg_data_out[5]~feeder_combout\ : std_logic;
SIGNAL \PC_int_Register|reg_data_out[6]~feeder_combout\ : std_logic;
SIGNAL \alu1_out[7]~input_o\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[6]~13\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[7]~14_combout\ : std_logic;
SIGNAL \mem_data_out[7]~input_o\ : std_logic;
SIGNAL \alu2_out[7]~input_o\ : std_logic;
SIGNAL \pc_register_in~15_combout\ : std_logic;
SIGNAL \pc_register_in~16_combout\ : std_logic;
SIGNAL \PC_int_Register|reg_data_out[7]~feeder_combout\ : std_logic;
SIGNAL \alu1_out[8]~input_o\ : std_logic;
SIGNAL \mem_data_out[8]~input_o\ : std_logic;
SIGNAL \pc_register_in~17_combout\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[7]~15\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[8]~16_combout\ : std_logic;
SIGNAL \alu2_out[8]~input_o\ : std_logic;
SIGNAL \pc_register_in~18_combout\ : std_logic;
SIGNAL \PC_int_Register|reg_data_out[8]~feeder_combout\ : std_logic;
SIGNAL \alu1_out[9]~input_o\ : std_logic;
SIGNAL \mem_data_out[9]~input_o\ : std_logic;
SIGNAL \alu2_out[9]~input_o\ : std_logic;
SIGNAL \pc_register_in~19_combout\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[8]~17\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[9]~18_combout\ : std_logic;
SIGNAL \pc_register_in~20_combout\ : std_logic;
SIGNAL \PC_int_Register|reg_data_out[9]~feeder_combout\ : std_logic;
SIGNAL \alu2_out[10]~input_o\ : std_logic;
SIGNAL \alu1_out[10]~input_o\ : std_logic;
SIGNAL \mem_data_out[10]~input_o\ : std_logic;
SIGNAL \pc_register_in~21_combout\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[9]~19\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[10]~20_combout\ : std_logic;
SIGNAL \pc_register_in~22_combout\ : std_logic;
SIGNAL \PC_int_Register|reg_data_out[10]~feeder_combout\ : std_logic;
SIGNAL \mem_data_out[11]~input_o\ : std_logic;
SIGNAL \alu2_out[11]~input_o\ : std_logic;
SIGNAL \pc_register_in~23_combout\ : std_logic;
SIGNAL \alu1_out[11]~input_o\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[10]~21\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[11]~22_combout\ : std_logic;
SIGNAL \pc_register_in~24_combout\ : std_logic;
SIGNAL \PC_int_Register|reg_data_out[11]~feeder_combout\ : std_logic;
SIGNAL \alu1_out[12]~input_o\ : std_logic;
SIGNAL \mem_data_out[12]~input_o\ : std_logic;
SIGNAL \pc_register_in~25_combout\ : std_logic;
SIGNAL \alu2_out[12]~input_o\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[11]~23\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[12]~24_combout\ : std_logic;
SIGNAL \pc_register_in~26_combout\ : std_logic;
SIGNAL \PC_int_Register|reg_data_out[12]~feeder_combout\ : std_logic;
SIGNAL \mem_data_out[13]~input_o\ : std_logic;
SIGNAL \alu2_out[13]~input_o\ : std_logic;
SIGNAL \pc_register_in~27_combout\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[12]~25\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[13]~26_combout\ : std_logic;
SIGNAL \alu1_out[13]~input_o\ : std_logic;
SIGNAL \pc_register_in~28_combout\ : std_logic;
SIGNAL \PC_int_Register|reg_data_out[13]~feeder_combout\ : std_logic;
SIGNAL \alu2_out[14]~input_o\ : std_logic;
SIGNAL \alu1_out[14]~input_o\ : std_logic;
SIGNAL \mem_data_out[14]~input_o\ : std_logic;
SIGNAL \pc_register_in~29_combout\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[13]~27\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[14]~28_combout\ : std_logic;
SIGNAL \pc_register_in~30_combout\ : std_logic;
SIGNAL \PC_int_Register|reg_data_out[14]~feeder_combout\ : std_logic;
SIGNAL \mem_data_out[15]~input_o\ : std_logic;
SIGNAL \alu2_out[15]~input_o\ : std_logic;
SIGNAL \pc_register_in~31_combout\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[14]~29\ : std_logic;
SIGNAL \incrementer|incrementer_pc_out[15]~30_combout\ : std_logic;
SIGNAL \alu1_out[15]~input_o\ : std_logic;
SIGNAL \pc_register_in~32_combout\ : std_logic;
SIGNAL \PC_int_Register|reg_data_out[15]~feeder_combout\ : std_logic;
SIGNAL pc_register_in : std_logic_vector(15 DOWNTO 0);
SIGNAL \pc_reg|reg_data_out\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \PC_int_Register|reg_data_out\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \ALT_INV_reset~inputclkctrl_outclk\ : std_logic;

BEGIN

ww_clk <= clk;
ww_reset <= reset;
ww_pc_select <= pc_select;
ww_pc_register_enable <= pc_register_enable;
ww_ir_enable <= ir_enable;
ww_mem_data_out <= mem_data_out;
ww_alu1_out <= alu1_out;
ww_alu2_out <= alu2_out;
instruction_int_out <= ww_instruction_int_out;
pc_register_int_out <= ww_pc_register_int_out;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0_PORTAADDR_bus\ <= (\pc_reg|reg_data_out\(6) & \pc_reg|reg_data_out\(5) & \pc_reg|reg_data_out\(4) & \pc_reg|reg_data_out\(3) & \pc_reg|reg_data_out\(2) & 
\pc_reg|reg_data_out\(1) & \pc_reg|reg_data_out\(0));

\InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0~portadataout\ <= \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0_PORTADATAOUT_bus\(0);
\InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a1\ <= \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0_PORTADATAOUT_bus\(1);
\InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a2\ <= \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0_PORTADATAOUT_bus\(2);
\InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a3\ <= \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0_PORTADATAOUT_bus\(3);
\InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a4\ <= \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0_PORTADATAOUT_bus\(4);
\InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a5\ <= \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0_PORTADATAOUT_bus\(5);
\InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a6\ <= \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0_PORTADATAOUT_bus\(6);
\InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a7\ <= \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0_PORTADATAOUT_bus\(7);
\InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a8\ <= \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0_PORTADATAOUT_bus\(8);
\InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a9\ <= \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0_PORTADATAOUT_bus\(9);
\InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a10\ <= \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0_PORTADATAOUT_bus\(10);
\InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a11\ <= \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0_PORTADATAOUT_bus\(11);
\InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a12\ <= \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0_PORTADATAOUT_bus\(12);
\InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a13\ <= \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0_PORTADATAOUT_bus\(13);
\InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a14\ <= \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0_PORTADATAOUT_bus\(14);
\InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a15\ <= \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0_PORTADATAOUT_bus\(15);

\reset~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \reset~input_o\);

\clk~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clk~input_o\);
\ALT_INV_reset~inputclkctrl_outclk\ <= NOT \reset~inputclkctrl_outclk\;

-- Location: IOOBUF_X0_Y8_N9
\instruction_int_out[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0~portadataout\,
	devoe => ww_devoe,
	o => \instruction_int_out[0]~output_o\);

-- Location: IOOBUF_X0_Y7_N23
\instruction_int_out[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a1\,
	devoe => ww_devoe,
	o => \instruction_int_out[1]~output_o\);

-- Location: IOOBUF_X11_Y0_N16
\instruction_int_out[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a2\,
	devoe => ww_devoe,
	o => \instruction_int_out[2]~output_o\);

-- Location: IOOBUF_X13_Y24_N2
\instruction_int_out[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a3\,
	devoe => ww_devoe,
	o => \instruction_int_out[3]~output_o\);

-- Location: IOOBUF_X11_Y0_N23
\instruction_int_out[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a4\,
	devoe => ww_devoe,
	o => \instruction_int_out[4]~output_o\);

-- Location: IOOBUF_X7_Y0_N9
\instruction_int_out[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a5\,
	devoe => ww_devoe,
	o => \instruction_int_out[5]~output_o\);

-- Location: IOOBUF_X11_Y0_N9
\instruction_int_out[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a6\,
	devoe => ww_devoe,
	o => \instruction_int_out[6]~output_o\);

-- Location: IOOBUF_X16_Y0_N23
\instruction_int_out[7]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a7\,
	devoe => ww_devoe,
	o => \instruction_int_out[7]~output_o\);

-- Location: IOOBUF_X7_Y0_N23
\instruction_int_out[8]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a8\,
	devoe => ww_devoe,
	o => \instruction_int_out[8]~output_o\);

-- Location: IOOBUF_X13_Y24_N16
\instruction_int_out[9]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a9\,
	devoe => ww_devoe,
	o => \instruction_int_out[9]~output_o\);

-- Location: IOOBUF_X0_Y8_N16
\instruction_int_out[10]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a10\,
	devoe => ww_devoe,
	o => \instruction_int_out[10]~output_o\);

-- Location: IOOBUF_X7_Y0_N2
\instruction_int_out[11]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a11\,
	devoe => ww_devoe,
	o => \instruction_int_out[11]~output_o\);

-- Location: IOOBUF_X11_Y0_N2
\instruction_int_out[12]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a12\,
	devoe => ww_devoe,
	o => \instruction_int_out[12]~output_o\);

-- Location: IOOBUF_X13_Y24_N9
\instruction_int_out[13]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a13\,
	devoe => ww_devoe,
	o => \instruction_int_out[13]~output_o\);

-- Location: IOOBUF_X16_Y24_N16
\instruction_int_out[14]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a14\,
	devoe => ww_devoe,
	o => \instruction_int_out[14]~output_o\);

-- Location: IOOBUF_X0_Y6_N23
\instruction_int_out[15]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a15\,
	devoe => ww_devoe,
	o => \instruction_int_out[15]~output_o\);

-- Location: IOOBUF_X13_Y0_N16
\pc_register_int_out[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_int_Register|reg_data_out\(0),
	devoe => ww_devoe,
	o => \pc_register_int_out[0]~output_o\);

-- Location: IOOBUF_X9_Y0_N2
\pc_register_int_out[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_int_Register|reg_data_out\(1),
	devoe => ww_devoe,
	o => \pc_register_int_out[1]~output_o\);

-- Location: IOOBUF_X7_Y0_N16
\pc_register_int_out[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_int_Register|reg_data_out\(2),
	devoe => ww_devoe,
	o => \pc_register_int_out[2]~output_o\);

-- Location: IOOBUF_X13_Y0_N2
\pc_register_int_out[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_int_Register|reg_data_out\(3),
	devoe => ww_devoe,
	o => \pc_register_int_out[3]~output_o\);

-- Location: IOOBUF_X9_Y0_N23
\pc_register_int_out[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_int_Register|reg_data_out\(4),
	devoe => ww_devoe,
	o => \pc_register_int_out[4]~output_o\);

-- Location: IOOBUF_X0_Y6_N16
\pc_register_int_out[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_int_Register|reg_data_out\(5),
	devoe => ww_devoe,
	o => \pc_register_int_out[5]~output_o\);

-- Location: IOOBUF_X1_Y0_N9
\pc_register_int_out[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_int_Register|reg_data_out\(6),
	devoe => ww_devoe,
	o => \pc_register_int_out[6]~output_o\);

-- Location: IOOBUF_X0_Y7_N16
\pc_register_int_out[7]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_int_Register|reg_data_out\(7),
	devoe => ww_devoe,
	o => \pc_register_int_out[7]~output_o\);

-- Location: IOOBUF_X5_Y0_N23
\pc_register_int_out[8]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_int_Register|reg_data_out\(8),
	devoe => ww_devoe,
	o => \pc_register_int_out[8]~output_o\);

-- Location: IOOBUF_X5_Y0_N16
\pc_register_int_out[9]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_int_Register|reg_data_out\(9),
	devoe => ww_devoe,
	o => \pc_register_int_out[9]~output_o\);

-- Location: IOOBUF_X1_Y0_N2
\pc_register_int_out[10]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_int_Register|reg_data_out\(10),
	devoe => ww_devoe,
	o => \pc_register_int_out[10]~output_o\);

-- Location: IOOBUF_X3_Y0_N2
\pc_register_int_out[11]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_int_Register|reg_data_out\(11),
	devoe => ww_devoe,
	o => \pc_register_int_out[11]~output_o\);

-- Location: IOOBUF_X13_Y0_N23
\pc_register_int_out[12]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_int_Register|reg_data_out\(12),
	devoe => ww_devoe,
	o => \pc_register_int_out[12]~output_o\);

-- Location: IOOBUF_X9_Y0_N9
\pc_register_int_out[13]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_int_Register|reg_data_out\(13),
	devoe => ww_devoe,
	o => \pc_register_int_out[13]~output_o\);

-- Location: IOOBUF_X13_Y24_N23
\pc_register_int_out[14]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_int_Register|reg_data_out\(14),
	devoe => ww_devoe,
	o => \pc_register_int_out[14]~output_o\);

-- Location: IOOBUF_X9_Y0_N16
\pc_register_int_out[15]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \PC_int_Register|reg_data_out\(15),
	devoe => ww_devoe,
	o => \pc_register_int_out[15]~output_o\);

-- Location: IOIBUF_X0_Y11_N8
\clk~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: CLKCTRL_G2
\clk~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk~inputclkctrl_outclk\);

-- Location: IOIBUF_X0_Y4_N22
\ir_enable~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ir_enable,
	o => \ir_enable~input_o\);

-- Location: IOIBUF_X21_Y0_N8
\mem_data_out[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_mem_data_out(0),
	o => \mem_data_out[0]~input_o\);

-- Location: IOIBUF_X21_Y0_N1
\pc_select[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_pc_select(0),
	o => \pc_select[0]~input_o\);

-- Location: IOIBUF_X0_Y4_N15
\pc_select[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_pc_select(1),
	o => \pc_select[1]~input_o\);

-- Location: IOIBUF_X32_Y0_N22
\alu2_out[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu2_out(0),
	o => \alu2_out[0]~input_o\);

-- Location: LCCOMB_X17_Y4_N22
\pc_register_in~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~1_combout\ = (\pc_select[0]~input_o\ & (((\pc_select[1]~input_o\) # (\alu2_out[0]~input_o\)))) # (!\pc_select[0]~input_o\ & (\mem_data_out[0]~input_o\ & (\pc_select[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110011100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mem_data_out[0]~input_o\,
	datab => \pc_select[0]~input_o\,
	datac => \pc_select[1]~input_o\,
	datad => \alu2_out[0]~input_o\,
	combout => \pc_register_in~1_combout\);

-- Location: LCCOMB_X17_Y4_N8
\pc_register_in[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in[0]~0_combout\ = \pc_select[0]~input_o\ $ (\pc_select[1]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \pc_select[0]~input_o\,
	datac => \pc_select[1]~input_o\,
	combout => \pc_register_in[0]~0_combout\);

-- Location: LCCOMB_X18_Y4_N0
\incrementer|incrementer_pc_out[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \incrementer|incrementer_pc_out[0]~0_combout\ = \pc_reg|reg_data_out\(0) $ (VCC)
-- \incrementer|incrementer_pc_out[0]~1\ = CARRY(\pc_reg|reg_data_out\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \pc_reg|reg_data_out\(0),
	datad => VCC,
	combout => \incrementer|incrementer_pc_out[0]~0_combout\,
	cout => \incrementer|incrementer_pc_out[0]~1\);

-- Location: IOIBUF_X18_Y0_N1
\alu1_out[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu1_out(0),
	o => \alu1_out[0]~input_o\);

-- Location: LCCOMB_X17_Y4_N16
\pc_register_in~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~2_combout\ = (\pc_register_in~1_combout\ & ((\pc_register_in[0]~0_combout\) # ((\incrementer|incrementer_pc_out[0]~0_combout\)))) # (!\pc_register_in~1_combout\ & (!\pc_register_in[0]~0_combout\ & ((\alu1_out[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \pc_register_in~1_combout\,
	datab => \pc_register_in[0]~0_combout\,
	datac => \incrementer|incrementer_pc_out[0]~0_combout\,
	datad => \alu1_out[0]~input_o\,
	combout => \pc_register_in~2_combout\);

-- Location: IOIBUF_X0_Y11_N15
\reset~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reset,
	o => \reset~input_o\);

-- Location: CLKCTRL_G4
\reset~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \reset~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \reset~inputclkctrl_outclk\);

-- Location: FF_X17_Y4_N17
\pc_register_in[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pc_register_in~2_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pc_register_in(0));

-- Location: IOIBUF_X18_Y0_N22
\pc_register_enable~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_pc_register_enable,
	o => \pc_register_enable~input_o\);

-- Location: FF_X18_Y4_N1
\pc_reg|reg_data_out[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => pc_register_in(0),
	sload => VCC,
	ena => \pc_register_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \pc_reg|reg_data_out\(0));

-- Location: IOIBUF_X16_Y0_N15
\alu1_out[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu1_out(1),
	o => \alu1_out[1]~input_o\);

-- Location: IOIBUF_X1_Y0_N22
\alu2_out[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu2_out(1),
	o => \alu2_out[1]~input_o\);

-- Location: IOIBUF_X16_Y24_N8
\mem_data_out[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_mem_data_out(1),
	o => \mem_data_out[1]~input_o\);

-- Location: LCCOMB_X17_Y4_N28
\pc_register_in~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~3_combout\ = (\pc_select[1]~input_o\ & (((\pc_select[0]~input_o\) # (\mem_data_out[1]~input_o\)))) # (!\pc_select[1]~input_o\ & (\alu2_out[1]~input_o\ & (\pc_select[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110011100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \alu2_out[1]~input_o\,
	datab => \pc_select[1]~input_o\,
	datac => \pc_select[0]~input_o\,
	datad => \mem_data_out[1]~input_o\,
	combout => \pc_register_in~3_combout\);

-- Location: LCCOMB_X18_Y4_N2
\incrementer|incrementer_pc_out[1]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \incrementer|incrementer_pc_out[1]~2_combout\ = (\pc_reg|reg_data_out\(1) & (!\incrementer|incrementer_pc_out[0]~1\)) # (!\pc_reg|reg_data_out\(1) & ((\incrementer|incrementer_pc_out[0]~1\) # (GND)))
-- \incrementer|incrementer_pc_out[1]~3\ = CARRY((!\incrementer|incrementer_pc_out[0]~1\) # (!\pc_reg|reg_data_out\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \pc_reg|reg_data_out\(1),
	datad => VCC,
	cin => \incrementer|incrementer_pc_out[0]~1\,
	combout => \incrementer|incrementer_pc_out[1]~2_combout\,
	cout => \incrementer|incrementer_pc_out[1]~3\);

-- Location: LCCOMB_X17_Y4_N18
\pc_register_in~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~4_combout\ = (\pc_register_in~3_combout\ & (((\pc_register_in[0]~0_combout\) # (\incrementer|incrementer_pc_out[1]~2_combout\)))) # (!\pc_register_in~3_combout\ & (\alu1_out[1]~input_o\ & (!\pc_register_in[0]~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111011000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \alu1_out[1]~input_o\,
	datab => \pc_register_in~3_combout\,
	datac => \pc_register_in[0]~0_combout\,
	datad => \incrementer|incrementer_pc_out[1]~2_combout\,
	combout => \pc_register_in~4_combout\);

-- Location: FF_X17_Y4_N19
\pc_register_in[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pc_register_in~4_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pc_register_in(1));

-- Location: FF_X18_Y4_N3
\pc_reg|reg_data_out[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => pc_register_in(1),
	sload => VCC,
	ena => \pc_register_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \pc_reg|reg_data_out\(1));

-- Location: IOIBUF_X34_Y7_N15
\alu2_out[2]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu2_out(2),
	o => \alu2_out[2]~input_o\);

-- Location: LCCOMB_X18_Y4_N4
\incrementer|incrementer_pc_out[2]~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \incrementer|incrementer_pc_out[2]~4_combout\ = (\pc_reg|reg_data_out\(2) & (\incrementer|incrementer_pc_out[1]~3\ $ (GND))) # (!\pc_reg|reg_data_out\(2) & (!\incrementer|incrementer_pc_out[1]~3\ & VCC))
-- \incrementer|incrementer_pc_out[2]~5\ = CARRY((\pc_reg|reg_data_out\(2) & !\incrementer|incrementer_pc_out[1]~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \pc_reg|reg_data_out\(2),
	datad => VCC,
	cin => \incrementer|incrementer_pc_out[1]~3\,
	combout => \incrementer|incrementer_pc_out[2]~4_combout\,
	cout => \incrementer|incrementer_pc_out[2]~5\);

-- Location: IOIBUF_X30_Y0_N8
\alu1_out[2]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu1_out(2),
	o => \alu1_out[2]~input_o\);

-- Location: IOIBUF_X18_Y24_N15
\mem_data_out[2]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_mem_data_out(2),
	o => \mem_data_out[2]~input_o\);

-- Location: LCCOMB_X19_Y4_N16
\pc_register_in~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~5_combout\ = (\pc_select[1]~input_o\ & (((\pc_select[0]~input_o\) # (\mem_data_out[2]~input_o\)))) # (!\pc_select[1]~input_o\ & (\alu1_out[2]~input_o\ & (!\pc_select[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111011000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \alu1_out[2]~input_o\,
	datab => \pc_select[1]~input_o\,
	datac => \pc_select[0]~input_o\,
	datad => \mem_data_out[2]~input_o\,
	combout => \pc_register_in~5_combout\);

-- Location: LCCOMB_X19_Y4_N8
\pc_register_in~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~6_combout\ = (\pc_select[0]~input_o\ & ((\pc_register_in~5_combout\ & ((\incrementer|incrementer_pc_out[2]~4_combout\))) # (!\pc_register_in~5_combout\ & (\alu2_out[2]~input_o\)))) # (!\pc_select[0]~input_o\ & 
-- (((\pc_register_in~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \alu2_out[2]~input_o\,
	datab => \pc_select[0]~input_o\,
	datac => \incrementer|incrementer_pc_out[2]~4_combout\,
	datad => \pc_register_in~5_combout\,
	combout => \pc_register_in~6_combout\);

-- Location: FF_X19_Y4_N9
\pc_register_in[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pc_register_in~6_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pc_register_in(2));

-- Location: FF_X18_Y4_N5
\pc_reg|reg_data_out[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => pc_register_in(2),
	sload => VCC,
	ena => \pc_register_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \pc_reg|reg_data_out\(2));

-- Location: IOIBUF_X18_Y0_N15
\alu1_out[3]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu1_out(3),
	o => \alu1_out[3]~input_o\);

-- Location: IOIBUF_X30_Y0_N1
\alu2_out[3]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu2_out(3),
	o => \alu2_out[3]~input_o\);

-- Location: IOIBUF_X34_Y4_N15
\mem_data_out[3]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_mem_data_out(3),
	o => \mem_data_out[3]~input_o\);

-- Location: LCCOMB_X22_Y4_N12
\pc_register_in~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~7_combout\ = (\pc_select[0]~input_o\ & ((\alu2_out[3]~input_o\) # ((\pc_select[1]~input_o\)))) # (!\pc_select[0]~input_o\ & (((\pc_select[1]~input_o\ & \mem_data_out[3]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100011001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \alu2_out[3]~input_o\,
	datab => \pc_select[0]~input_o\,
	datac => \pc_select[1]~input_o\,
	datad => \mem_data_out[3]~input_o\,
	combout => \pc_register_in~7_combout\);

-- Location: LCCOMB_X18_Y4_N6
\incrementer|incrementer_pc_out[3]~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \incrementer|incrementer_pc_out[3]~6_combout\ = (\pc_reg|reg_data_out\(3) & (!\incrementer|incrementer_pc_out[2]~5\)) # (!\pc_reg|reg_data_out\(3) & ((\incrementer|incrementer_pc_out[2]~5\) # (GND)))
-- \incrementer|incrementer_pc_out[3]~7\ = CARRY((!\incrementer|incrementer_pc_out[2]~5\) # (!\pc_reg|reg_data_out\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \pc_reg|reg_data_out\(3),
	datad => VCC,
	cin => \incrementer|incrementer_pc_out[2]~5\,
	combout => \incrementer|incrementer_pc_out[3]~6_combout\,
	cout => \incrementer|incrementer_pc_out[3]~7\);

-- Location: LCCOMB_X17_Y4_N0
\pc_register_in~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~8_combout\ = (\pc_register_in[0]~0_combout\ & (((\pc_register_in~7_combout\)))) # (!\pc_register_in[0]~0_combout\ & ((\pc_register_in~7_combout\ & ((\incrementer|incrementer_pc_out[3]~6_combout\))) # (!\pc_register_in~7_combout\ & 
-- (\alu1_out[3]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001011000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \alu1_out[3]~input_o\,
	datab => \pc_register_in[0]~0_combout\,
	datac => \pc_register_in~7_combout\,
	datad => \incrementer|incrementer_pc_out[3]~6_combout\,
	combout => \pc_register_in~8_combout\);

-- Location: FF_X17_Y4_N1
\pc_register_in[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pc_register_in~8_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pc_register_in(3));

-- Location: FF_X18_Y4_N7
\pc_reg|reg_data_out[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => pc_register_in(3),
	sload => VCC,
	ena => \pc_register_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \pc_reg|reg_data_out\(3));

-- Location: IOIBUF_X28_Y0_N22
\alu2_out[4]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu2_out(4),
	o => \alu2_out[4]~input_o\);

-- Location: IOIBUF_X30_Y0_N22
\mem_data_out[4]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_mem_data_out(4),
	o => \mem_data_out[4]~input_o\);

-- Location: IOIBUF_X32_Y0_N15
\alu1_out[4]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu1_out(4),
	o => \alu1_out[4]~input_o\);

-- Location: LCCOMB_X19_Y4_N26
\pc_register_in~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~9_combout\ = (\pc_select[1]~input_o\ & ((\pc_select[0]~input_o\) # ((\mem_data_out[4]~input_o\)))) # (!\pc_select[1]~input_o\ & (!\pc_select[0]~input_o\ & ((\alu1_out[4]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \pc_select[1]~input_o\,
	datab => \pc_select[0]~input_o\,
	datac => \mem_data_out[4]~input_o\,
	datad => \alu1_out[4]~input_o\,
	combout => \pc_register_in~9_combout\);

-- Location: LCCOMB_X18_Y4_N8
\incrementer|incrementer_pc_out[4]~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \incrementer|incrementer_pc_out[4]~8_combout\ = (\pc_reg|reg_data_out\(4) & (\incrementer|incrementer_pc_out[3]~7\ $ (GND))) # (!\pc_reg|reg_data_out\(4) & (!\incrementer|incrementer_pc_out[3]~7\ & VCC))
-- \incrementer|incrementer_pc_out[4]~9\ = CARRY((\pc_reg|reg_data_out\(4) & !\incrementer|incrementer_pc_out[3]~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \pc_reg|reg_data_out\(4),
	datad => VCC,
	cin => \incrementer|incrementer_pc_out[3]~7\,
	combout => \incrementer|incrementer_pc_out[4]~8_combout\,
	cout => \incrementer|incrementer_pc_out[4]~9\);

-- Location: LCCOMB_X19_Y4_N14
\pc_register_in~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~10_combout\ = (\pc_select[0]~input_o\ & ((\pc_register_in~9_combout\ & ((\incrementer|incrementer_pc_out[4]~8_combout\))) # (!\pc_register_in~9_combout\ & (\alu2_out[4]~input_o\)))) # (!\pc_select[0]~input_o\ & 
-- (((\pc_register_in~9_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100000111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \alu2_out[4]~input_o\,
	datab => \pc_select[0]~input_o\,
	datac => \pc_register_in~9_combout\,
	datad => \incrementer|incrementer_pc_out[4]~8_combout\,
	combout => \pc_register_in~10_combout\);

-- Location: FF_X19_Y4_N15
\pc_register_in[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pc_register_in~10_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pc_register_in(4));

-- Location: FF_X18_Y4_N9
\pc_reg|reg_data_out[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => pc_register_in(4),
	sload => VCC,
	ena => \pc_register_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \pc_reg|reg_data_out\(4));

-- Location: IOIBUF_X18_Y24_N8
\mem_data_out[5]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_mem_data_out(5),
	o => \mem_data_out[5]~input_o\);

-- Location: IOIBUF_X16_Y24_N1
\alu2_out[5]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu2_out(5),
	o => \alu2_out[5]~input_o\);

-- Location: LCCOMB_X17_Y4_N10
\pc_register_in~11\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~11_combout\ = (\pc_select[1]~input_o\ & ((\mem_data_out[5]~input_o\) # ((\pc_select[0]~input_o\)))) # (!\pc_select[1]~input_o\ & (((\pc_select[0]~input_o\ & \alu2_out[5]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100011001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mem_data_out[5]~input_o\,
	datab => \pc_select[1]~input_o\,
	datac => \pc_select[0]~input_o\,
	datad => \alu2_out[5]~input_o\,
	combout => \pc_register_in~11_combout\);

-- Location: LCCOMB_X18_Y4_N10
\incrementer|incrementer_pc_out[5]~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \incrementer|incrementer_pc_out[5]~10_combout\ = (\pc_reg|reg_data_out\(5) & (!\incrementer|incrementer_pc_out[4]~9\)) # (!\pc_reg|reg_data_out\(5) & ((\incrementer|incrementer_pc_out[4]~9\) # (GND)))
-- \incrementer|incrementer_pc_out[5]~11\ = CARRY((!\incrementer|incrementer_pc_out[4]~9\) # (!\pc_reg|reg_data_out\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \pc_reg|reg_data_out\(5),
	datad => VCC,
	cin => \incrementer|incrementer_pc_out[4]~9\,
	combout => \incrementer|incrementer_pc_out[5]~10_combout\,
	cout => \incrementer|incrementer_pc_out[5]~11\);

-- Location: IOIBUF_X25_Y0_N22
\alu1_out[5]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu1_out(5),
	o => \alu1_out[5]~input_o\);

-- Location: LCCOMB_X17_Y4_N2
\pc_register_in~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~12_combout\ = (\pc_register_in~11_combout\ & ((\pc_register_in[0]~0_combout\) # ((\incrementer|incrementer_pc_out[5]~10_combout\)))) # (!\pc_register_in~11_combout\ & (!\pc_register_in[0]~0_combout\ & ((\alu1_out[5]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \pc_register_in~11_combout\,
	datab => \pc_register_in[0]~0_combout\,
	datac => \incrementer|incrementer_pc_out[5]~10_combout\,
	datad => \alu1_out[5]~input_o\,
	combout => \pc_register_in~12_combout\);

-- Location: FF_X17_Y4_N3
\pc_register_in[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pc_register_in~12_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pc_register_in(5));

-- Location: FF_X18_Y4_N11
\pc_reg|reg_data_out[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => pc_register_in(5),
	sload => VCC,
	ena => \pc_register_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \pc_reg|reg_data_out\(5));

-- Location: IOIBUF_X32_Y0_N1
\alu2_out[6]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu2_out(6),
	o => \alu2_out[6]~input_o\);

-- Location: IOIBUF_X34_Y5_N22
\alu1_out[6]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu1_out(6),
	o => \alu1_out[6]~input_o\);

-- Location: IOIBUF_X25_Y0_N15
\mem_data_out[6]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_mem_data_out(6),
	o => \mem_data_out[6]~input_o\);

-- Location: LCCOMB_X19_Y4_N4
\pc_register_in~13\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~13_combout\ = (\pc_select[0]~input_o\ & (((\pc_select[1]~input_o\)))) # (!\pc_select[0]~input_o\ & ((\pc_select[1]~input_o\ & ((\mem_data_out[6]~input_o\))) # (!\pc_select[1]~input_o\ & (\alu1_out[6]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001011000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \alu1_out[6]~input_o\,
	datab => \pc_select[0]~input_o\,
	datac => \pc_select[1]~input_o\,
	datad => \mem_data_out[6]~input_o\,
	combout => \pc_register_in~13_combout\);

-- Location: LCCOMB_X18_Y4_N12
\incrementer|incrementer_pc_out[6]~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \incrementer|incrementer_pc_out[6]~12_combout\ = (\pc_reg|reg_data_out\(6) & (\incrementer|incrementer_pc_out[5]~11\ $ (GND))) # (!\pc_reg|reg_data_out\(6) & (!\incrementer|incrementer_pc_out[5]~11\ & VCC))
-- \incrementer|incrementer_pc_out[6]~13\ = CARRY((\pc_reg|reg_data_out\(6) & !\incrementer|incrementer_pc_out[5]~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \pc_reg|reg_data_out\(6),
	datad => VCC,
	cin => \incrementer|incrementer_pc_out[5]~11\,
	combout => \incrementer|incrementer_pc_out[6]~12_combout\,
	cout => \incrementer|incrementer_pc_out[6]~13\);

-- Location: LCCOMB_X19_Y4_N20
\pc_register_in~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~14_combout\ = (\pc_select[0]~input_o\ & ((\pc_register_in~13_combout\ & ((\incrementer|incrementer_pc_out[6]~12_combout\))) # (!\pc_register_in~13_combout\ & (\alu2_out[6]~input_o\)))) # (!\pc_select[0]~input_o\ & 
-- (((\pc_register_in~13_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100000111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \alu2_out[6]~input_o\,
	datab => \pc_select[0]~input_o\,
	datac => \pc_register_in~13_combout\,
	datad => \incrementer|incrementer_pc_out[6]~12_combout\,
	combout => \pc_register_in~14_combout\);

-- Location: FF_X19_Y4_N21
\pc_register_in[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pc_register_in~14_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pc_register_in(6));

-- Location: FF_X18_Y4_N13
\pc_reg|reg_data_out[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => pc_register_in(6),
	sload => VCC,
	ena => \pc_register_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \pc_reg|reg_data_out\(6));

-- Location: M9K_X15_Y4_N0
\InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0\ : cycloneive_ram_block
-- pragma translate_off
GENERIC MAP (
	mem_init1 => X"0000000000000000000000000000000000000000000000000000000000000000",
	mem_init0 => X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
	clk0_core_clock_enable => "ena0",
	clk0_input_clock_enable => "ena0",
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	init_file => "db/instruction_fetch.ram0_instruction_memory_68fd8bb8.hdl.mif",
	init_file_layout => "port_a",
	logical_ram_name => "instruction_memory:InstructionMemory|altsyncram:memory_database_rtl_0|altsyncram_i3a1:auto_generated|ALTSYNCRAM",
	operation_mode => "rom",
	port_a_address_clear => "none",
	port_a_address_width => 7,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 18,
	port_a_first_address => 0,
	port_a_first_bit_number => 0,
	port_a_last_address => 127,
	port_a_logical_ram_depth => 128,
	port_a_logical_ram_width => 16,
	port_a_read_during_write_mode => "new_data_with_nbe_read",
	port_a_write_enable_clock => "none",
	port_b_address_width => 7,
	port_b_data_width => 18,
	ram_block_type => "M9K")
-- pragma translate_on
PORT MAP (
	portare => VCC,
	clk0 => \clk~inputclkctrl_outclk\,
	ena0 => \ir_enable~input_o\,
	portaaddr => \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0_PORTAADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portadataout => \InstructionMemory|memory_database_rtl_0|auto_generated|ram_block1a0_PORTADATAOUT_bus\);

-- Location: LCCOMB_X14_Y4_N24
\PC_int_Register|reg_data_out[0]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \PC_int_Register|reg_data_out[0]~feeder_combout\ = \pc_reg|reg_data_out\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \pc_reg|reg_data_out\(0),
	combout => \PC_int_Register|reg_data_out[0]~feeder_combout\);

-- Location: FF_X14_Y4_N25
\PC_int_Register|reg_data_out[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_int_Register|reg_data_out[0]~feeder_combout\,
	ena => \ir_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_int_Register|reg_data_out\(0));

-- Location: LCCOMB_X14_Y4_N26
\PC_int_Register|reg_data_out[1]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \PC_int_Register|reg_data_out[1]~feeder_combout\ = \pc_reg|reg_data_out\(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \pc_reg|reg_data_out\(1),
	combout => \PC_int_Register|reg_data_out[1]~feeder_combout\);

-- Location: FF_X14_Y4_N27
\PC_int_Register|reg_data_out[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_int_Register|reg_data_out[1]~feeder_combout\,
	ena => \ir_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_int_Register|reg_data_out\(1));

-- Location: LCCOMB_X14_Y4_N20
\PC_int_Register|reg_data_out[2]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \PC_int_Register|reg_data_out[2]~feeder_combout\ = \pc_reg|reg_data_out\(2)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \pc_reg|reg_data_out\(2),
	combout => \PC_int_Register|reg_data_out[2]~feeder_combout\);

-- Location: FF_X14_Y4_N21
\PC_int_Register|reg_data_out[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_int_Register|reg_data_out[2]~feeder_combout\,
	ena => \ir_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_int_Register|reg_data_out\(2));

-- Location: LCCOMB_X14_Y4_N30
\PC_int_Register|reg_data_out[3]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \PC_int_Register|reg_data_out[3]~feeder_combout\ = \pc_reg|reg_data_out\(3)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \pc_reg|reg_data_out\(3),
	combout => \PC_int_Register|reg_data_out[3]~feeder_combout\);

-- Location: FF_X14_Y4_N31
\PC_int_Register|reg_data_out[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_int_Register|reg_data_out[3]~feeder_combout\,
	ena => \ir_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_int_Register|reg_data_out\(3));

-- Location: LCCOMB_X14_Y4_N4
\PC_int_Register|reg_data_out[4]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \PC_int_Register|reg_data_out[4]~feeder_combout\ = \pc_reg|reg_data_out\(4)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \pc_reg|reg_data_out\(4),
	combout => \PC_int_Register|reg_data_out[4]~feeder_combout\);

-- Location: FF_X14_Y4_N5
\PC_int_Register|reg_data_out[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_int_Register|reg_data_out[4]~feeder_combout\,
	ena => \ir_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_int_Register|reg_data_out\(4));

-- Location: LCCOMB_X14_Y4_N10
\PC_int_Register|reg_data_out[5]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \PC_int_Register|reg_data_out[5]~feeder_combout\ = \pc_reg|reg_data_out\(5)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \pc_reg|reg_data_out\(5),
	combout => \PC_int_Register|reg_data_out[5]~feeder_combout\);

-- Location: FF_X14_Y4_N11
\PC_int_Register|reg_data_out[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_int_Register|reg_data_out[5]~feeder_combout\,
	ena => \ir_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_int_Register|reg_data_out\(5));

-- Location: LCCOMB_X9_Y4_N8
\PC_int_Register|reg_data_out[6]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \PC_int_Register|reg_data_out[6]~feeder_combout\ = \pc_reg|reg_data_out\(6)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \pc_reg|reg_data_out\(6),
	combout => \PC_int_Register|reg_data_out[6]~feeder_combout\);

-- Location: FF_X9_Y4_N9
\PC_int_Register|reg_data_out[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_int_Register|reg_data_out[6]~feeder_combout\,
	ena => \ir_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_int_Register|reg_data_out\(6));

-- Location: IOIBUF_X18_Y24_N22
\alu1_out[7]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu1_out(7),
	o => \alu1_out[7]~input_o\);

-- Location: LCCOMB_X18_Y4_N14
\incrementer|incrementer_pc_out[7]~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \incrementer|incrementer_pc_out[7]~14_combout\ = (\pc_reg|reg_data_out\(7) & (!\incrementer|incrementer_pc_out[6]~13\)) # (!\pc_reg|reg_data_out\(7) & ((\incrementer|incrementer_pc_out[6]~13\) # (GND)))
-- \incrementer|incrementer_pc_out[7]~15\ = CARRY((!\incrementer|incrementer_pc_out[6]~13\) # (!\pc_reg|reg_data_out\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \pc_reg|reg_data_out\(7),
	datad => VCC,
	cin => \incrementer|incrementer_pc_out[6]~13\,
	combout => \incrementer|incrementer_pc_out[7]~14_combout\,
	cout => \incrementer|incrementer_pc_out[7]~15\);

-- Location: IOIBUF_X0_Y11_N22
\mem_data_out[7]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_mem_data_out(7),
	o => \mem_data_out[7]~input_o\);

-- Location: IOIBUF_X1_Y0_N15
\alu2_out[7]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu2_out(7),
	o => \alu2_out[7]~input_o\);

-- Location: LCCOMB_X17_Y4_N20
\pc_register_in~15\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~15_combout\ = (\pc_select[0]~input_o\ & (((\alu2_out[7]~input_o\) # (\pc_select[1]~input_o\)))) # (!\pc_select[0]~input_o\ & (\mem_data_out[7]~input_o\ & ((\pc_select[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mem_data_out[7]~input_o\,
	datab => \alu2_out[7]~input_o\,
	datac => \pc_select[0]~input_o\,
	datad => \pc_select[1]~input_o\,
	combout => \pc_register_in~15_combout\);

-- Location: LCCOMB_X17_Y4_N24
\pc_register_in~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~16_combout\ = (\pc_register_in[0]~0_combout\ & (((\pc_register_in~15_combout\)))) # (!\pc_register_in[0]~0_combout\ & ((\pc_register_in~15_combout\ & ((\incrementer|incrementer_pc_out[7]~14_combout\))) # (!\pc_register_in~15_combout\ & 
-- (\alu1_out[7]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \alu1_out[7]~input_o\,
	datab => \pc_register_in[0]~0_combout\,
	datac => \incrementer|incrementer_pc_out[7]~14_combout\,
	datad => \pc_register_in~15_combout\,
	combout => \pc_register_in~16_combout\);

-- Location: FF_X17_Y4_N25
\pc_register_in[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pc_register_in~16_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pc_register_in(7));

-- Location: FF_X18_Y4_N15
\pc_reg|reg_data_out[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => pc_register_in(7),
	sload => VCC,
	ena => \pc_register_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \pc_reg|reg_data_out\(7));

-- Location: LCCOMB_X14_Y4_N0
\PC_int_Register|reg_data_out[7]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \PC_int_Register|reg_data_out[7]~feeder_combout\ = \pc_reg|reg_data_out\(7)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \pc_reg|reg_data_out\(7),
	combout => \PC_int_Register|reg_data_out[7]~feeder_combout\);

-- Location: FF_X14_Y4_N1
\PC_int_Register|reg_data_out[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_int_Register|reg_data_out[7]~feeder_combout\,
	ena => \ir_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_int_Register|reg_data_out\(7));

-- Location: IOIBUF_X28_Y0_N8
\alu1_out[8]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu1_out(8),
	o => \alu1_out[8]~input_o\);

-- Location: IOIBUF_X34_Y5_N15
\mem_data_out[8]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_mem_data_out(8),
	o => \mem_data_out[8]~input_o\);

-- Location: LCCOMB_X19_Y4_N6
\pc_register_in~17\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~17_combout\ = (\pc_select[0]~input_o\ & (((\pc_select[1]~input_o\)))) # (!\pc_select[0]~input_o\ & ((\pc_select[1]~input_o\ & ((\mem_data_out[8]~input_o\))) # (!\pc_select[1]~input_o\ & (\alu1_out[8]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001011000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \alu1_out[8]~input_o\,
	datab => \pc_select[0]~input_o\,
	datac => \pc_select[1]~input_o\,
	datad => \mem_data_out[8]~input_o\,
	combout => \pc_register_in~17_combout\);

-- Location: LCCOMB_X18_Y4_N16
\incrementer|incrementer_pc_out[8]~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \incrementer|incrementer_pc_out[8]~16_combout\ = (\pc_reg|reg_data_out\(8) & (\incrementer|incrementer_pc_out[7]~15\ $ (GND))) # (!\pc_reg|reg_data_out\(8) & (!\incrementer|incrementer_pc_out[7]~15\ & VCC))
-- \incrementer|incrementer_pc_out[8]~17\ = CARRY((\pc_reg|reg_data_out\(8) & !\incrementer|incrementer_pc_out[7]~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \pc_reg|reg_data_out\(8),
	datad => VCC,
	cin => \incrementer|incrementer_pc_out[7]~15\,
	combout => \incrementer|incrementer_pc_out[8]~16_combout\,
	cout => \incrementer|incrementer_pc_out[8]~17\);

-- Location: IOIBUF_X28_Y0_N15
\alu2_out[8]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu2_out(8),
	o => \alu2_out[8]~input_o\);

-- Location: LCCOMB_X19_Y4_N10
\pc_register_in~18\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~18_combout\ = (\pc_register_in~17_combout\ & (((\incrementer|incrementer_pc_out[8]~16_combout\)) # (!\pc_select[0]~input_o\))) # (!\pc_register_in~17_combout\ & (\pc_select[0]~input_o\ & ((\alu2_out[8]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110011010100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \pc_register_in~17_combout\,
	datab => \pc_select[0]~input_o\,
	datac => \incrementer|incrementer_pc_out[8]~16_combout\,
	datad => \alu2_out[8]~input_o\,
	combout => \pc_register_in~18_combout\);

-- Location: FF_X19_Y4_N11
\pc_register_in[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pc_register_in~18_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pc_register_in(8));

-- Location: FF_X18_Y4_N17
\pc_reg|reg_data_out[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => pc_register_in(8),
	sload => VCC,
	ena => \pc_register_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \pc_reg|reg_data_out\(8));

-- Location: LCCOMB_X14_Y4_N18
\PC_int_Register|reg_data_out[8]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \PC_int_Register|reg_data_out[8]~feeder_combout\ = \pc_reg|reg_data_out\(8)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \pc_reg|reg_data_out\(8),
	combout => \PC_int_Register|reg_data_out[8]~feeder_combout\);

-- Location: FF_X14_Y4_N19
\PC_int_Register|reg_data_out[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_int_Register|reg_data_out[8]~feeder_combout\,
	ena => \ir_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_int_Register|reg_data_out\(8));

-- Location: IOIBUF_X16_Y24_N22
\alu1_out[9]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu1_out(9),
	o => \alu1_out[9]~input_o\);

-- Location: IOIBUF_X16_Y0_N1
\mem_data_out[9]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_mem_data_out(9),
	o => \mem_data_out[9]~input_o\);

-- Location: IOIBUF_X21_Y24_N8
\alu2_out[9]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu2_out(9),
	o => \alu2_out[9]~input_o\);

-- Location: LCCOMB_X17_Y4_N14
\pc_register_in~19\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~19_combout\ = (\pc_select[1]~input_o\ & ((\mem_data_out[9]~input_o\) # ((\pc_select[0]~input_o\)))) # (!\pc_select[1]~input_o\ & (((\pc_select[0]~input_o\ & \alu2_out[9]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \pc_select[1]~input_o\,
	datab => \mem_data_out[9]~input_o\,
	datac => \pc_select[0]~input_o\,
	datad => \alu2_out[9]~input_o\,
	combout => \pc_register_in~19_combout\);

-- Location: LCCOMB_X18_Y4_N18
\incrementer|incrementer_pc_out[9]~18\ : cycloneive_lcell_comb
-- Equation(s):
-- \incrementer|incrementer_pc_out[9]~18_combout\ = (\pc_reg|reg_data_out\(9) & (!\incrementer|incrementer_pc_out[8]~17\)) # (!\pc_reg|reg_data_out\(9) & ((\incrementer|incrementer_pc_out[8]~17\) # (GND)))
-- \incrementer|incrementer_pc_out[9]~19\ = CARRY((!\incrementer|incrementer_pc_out[8]~17\) # (!\pc_reg|reg_data_out\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \pc_reg|reg_data_out\(9),
	datad => VCC,
	cin => \incrementer|incrementer_pc_out[8]~17\,
	combout => \incrementer|incrementer_pc_out[9]~18_combout\,
	cout => \incrementer|incrementer_pc_out[9]~19\);

-- Location: LCCOMB_X17_Y4_N26
\pc_register_in~20\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~20_combout\ = (\pc_register_in[0]~0_combout\ & (((\pc_register_in~19_combout\)))) # (!\pc_register_in[0]~0_combout\ & ((\pc_register_in~19_combout\ & ((\incrementer|incrementer_pc_out[9]~18_combout\))) # (!\pc_register_in~19_combout\ & 
-- (\alu1_out[9]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001011000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \alu1_out[9]~input_o\,
	datab => \pc_register_in[0]~0_combout\,
	datac => \pc_register_in~19_combout\,
	datad => \incrementer|incrementer_pc_out[9]~18_combout\,
	combout => \pc_register_in~20_combout\);

-- Location: FF_X17_Y4_N27
\pc_register_in[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pc_register_in~20_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pc_register_in(9));

-- Location: FF_X18_Y4_N19
\pc_reg|reg_data_out[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => pc_register_in(9),
	sload => VCC,
	ena => \pc_register_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \pc_reg|reg_data_out\(9));

-- Location: LCCOMB_X14_Y4_N8
\PC_int_Register|reg_data_out[9]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \PC_int_Register|reg_data_out[9]~feeder_combout\ = \pc_reg|reg_data_out\(9)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \pc_reg|reg_data_out\(9),
	combout => \PC_int_Register|reg_data_out[9]~feeder_combout\);

-- Location: FF_X14_Y4_N9
\PC_int_Register|reg_data_out[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_int_Register|reg_data_out[9]~feeder_combout\,
	ena => \ir_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_int_Register|reg_data_out\(9));

-- Location: IOIBUF_X34_Y3_N22
\alu2_out[10]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu2_out(10),
	o => \alu2_out[10]~input_o\);

-- Location: IOIBUF_X0_Y5_N22
\alu1_out[10]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu1_out(10),
	o => \alu1_out[10]~input_o\);

-- Location: IOIBUF_X23_Y0_N15
\mem_data_out[10]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_mem_data_out(10),
	o => \mem_data_out[10]~input_o\);

-- Location: LCCOMB_X19_Y4_N24
\pc_register_in~21\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~21_combout\ = (\pc_select[0]~input_o\ & (((\pc_select[1]~input_o\)))) # (!\pc_select[0]~input_o\ & ((\pc_select[1]~input_o\ & ((\mem_data_out[10]~input_o\))) # (!\pc_select[1]~input_o\ & (\alu1_out[10]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001011000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \alu1_out[10]~input_o\,
	datab => \pc_select[0]~input_o\,
	datac => \pc_select[1]~input_o\,
	datad => \mem_data_out[10]~input_o\,
	combout => \pc_register_in~21_combout\);

-- Location: LCCOMB_X18_Y4_N20
\incrementer|incrementer_pc_out[10]~20\ : cycloneive_lcell_comb
-- Equation(s):
-- \incrementer|incrementer_pc_out[10]~20_combout\ = (\pc_reg|reg_data_out\(10) & (\incrementer|incrementer_pc_out[9]~19\ $ (GND))) # (!\pc_reg|reg_data_out\(10) & (!\incrementer|incrementer_pc_out[9]~19\ & VCC))
-- \incrementer|incrementer_pc_out[10]~21\ = CARRY((\pc_reg|reg_data_out\(10) & !\incrementer|incrementer_pc_out[9]~19\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \pc_reg|reg_data_out\(10),
	datad => VCC,
	cin => \incrementer|incrementer_pc_out[9]~19\,
	combout => \incrementer|incrementer_pc_out[10]~20_combout\,
	cout => \incrementer|incrementer_pc_out[10]~21\);

-- Location: LCCOMB_X19_Y4_N12
\pc_register_in~22\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~22_combout\ = (\pc_register_in~21_combout\ & (((\incrementer|incrementer_pc_out[10]~20_combout\) # (!\pc_select[0]~input_o\)))) # (!\pc_register_in~21_combout\ & (\alu2_out[10]~input_o\ & (\pc_select[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110000101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \alu2_out[10]~input_o\,
	datab => \pc_register_in~21_combout\,
	datac => \pc_select[0]~input_o\,
	datad => \incrementer|incrementer_pc_out[10]~20_combout\,
	combout => \pc_register_in~22_combout\);

-- Location: FF_X19_Y4_N13
\pc_register_in[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pc_register_in~22_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pc_register_in(10));

-- Location: FF_X18_Y4_N21
\pc_reg|reg_data_out[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => pc_register_in(10),
	sload => VCC,
	ena => \pc_register_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \pc_reg|reg_data_out\(10));

-- Location: LCCOMB_X14_Y4_N22
\PC_int_Register|reg_data_out[10]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \PC_int_Register|reg_data_out[10]~feeder_combout\ = \pc_reg|reg_data_out\(10)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \pc_reg|reg_data_out\(10),
	combout => \PC_int_Register|reg_data_out[10]~feeder_combout\);

-- Location: FF_X14_Y4_N23
\PC_int_Register|reg_data_out[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_int_Register|reg_data_out[10]~feeder_combout\,
	ena => \ir_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_int_Register|reg_data_out\(10));

-- Location: IOIBUF_X16_Y0_N8
\mem_data_out[11]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_mem_data_out(11),
	o => \mem_data_out[11]~input_o\);

-- Location: IOIBUF_X21_Y0_N22
\alu2_out[11]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu2_out(11),
	o => \alu2_out[11]~input_o\);

-- Location: LCCOMB_X17_Y4_N12
\pc_register_in~23\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~23_combout\ = (\pc_select[1]~input_o\ & ((\mem_data_out[11]~input_o\) # ((\pc_select[0]~input_o\)))) # (!\pc_select[1]~input_o\ & (((\pc_select[0]~input_o\ & \alu2_out[11]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100011001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mem_data_out[11]~input_o\,
	datab => \pc_select[1]~input_o\,
	datac => \pc_select[0]~input_o\,
	datad => \alu2_out[11]~input_o\,
	combout => \pc_register_in~23_combout\);

-- Location: IOIBUF_X34_Y7_N8
\alu1_out[11]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu1_out(11),
	o => \alu1_out[11]~input_o\);

-- Location: LCCOMB_X18_Y4_N22
\incrementer|incrementer_pc_out[11]~22\ : cycloneive_lcell_comb
-- Equation(s):
-- \incrementer|incrementer_pc_out[11]~22_combout\ = (\pc_reg|reg_data_out\(11) & (!\incrementer|incrementer_pc_out[10]~21\)) # (!\pc_reg|reg_data_out\(11) & ((\incrementer|incrementer_pc_out[10]~21\) # (GND)))
-- \incrementer|incrementer_pc_out[11]~23\ = CARRY((!\incrementer|incrementer_pc_out[10]~21\) # (!\pc_reg|reg_data_out\(11)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \pc_reg|reg_data_out\(11),
	datad => VCC,
	cin => \incrementer|incrementer_pc_out[10]~21\,
	combout => \incrementer|incrementer_pc_out[11]~22_combout\,
	cout => \incrementer|incrementer_pc_out[11]~23\);

-- Location: LCCOMB_X17_Y4_N4
\pc_register_in~24\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~24_combout\ = (\pc_register_in~23_combout\ & ((\pc_register_in[0]~0_combout\) # ((\incrementer|incrementer_pc_out[11]~22_combout\)))) # (!\pc_register_in~23_combout\ & (!\pc_register_in[0]~0_combout\ & (\alu1_out[11]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \pc_register_in~23_combout\,
	datab => \pc_register_in[0]~0_combout\,
	datac => \alu1_out[11]~input_o\,
	datad => \incrementer|incrementer_pc_out[11]~22_combout\,
	combout => \pc_register_in~24_combout\);

-- Location: FF_X17_Y4_N5
\pc_register_in[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pc_register_in~24_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pc_register_in(11));

-- Location: FF_X18_Y4_N23
\pc_reg|reg_data_out[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => pc_register_in(11),
	sload => VCC,
	ena => \pc_register_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \pc_reg|reg_data_out\(11));

-- Location: LCCOMB_X14_Y4_N28
\PC_int_Register|reg_data_out[11]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \PC_int_Register|reg_data_out[11]~feeder_combout\ = \pc_reg|reg_data_out\(11)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \pc_reg|reg_data_out\(11),
	combout => \PC_int_Register|reg_data_out[11]~feeder_combout\);

-- Location: FF_X14_Y4_N29
\PC_int_Register|reg_data_out[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_int_Register|reg_data_out[11]~feeder_combout\,
	ena => \ir_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_int_Register|reg_data_out\(11));

-- Location: IOIBUF_X21_Y24_N15
\alu1_out[12]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu1_out(12),
	o => \alu1_out[12]~input_o\);

-- Location: IOIBUF_X28_Y0_N1
\mem_data_out[12]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_mem_data_out(12),
	o => \mem_data_out[12]~input_o\);

-- Location: LCCOMB_X19_Y4_N22
\pc_register_in~25\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~25_combout\ = (\pc_select[0]~input_o\ & (((\pc_select[1]~input_o\)))) # (!\pc_select[0]~input_o\ & ((\pc_select[1]~input_o\ & ((\mem_data_out[12]~input_o\))) # (!\pc_select[1]~input_o\ & (\alu1_out[12]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001011000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \alu1_out[12]~input_o\,
	datab => \pc_select[0]~input_o\,
	datac => \pc_select[1]~input_o\,
	datad => \mem_data_out[12]~input_o\,
	combout => \pc_register_in~25_combout\);

-- Location: IOIBUF_X25_Y0_N8
\alu2_out[12]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu2_out(12),
	o => \alu2_out[12]~input_o\);

-- Location: LCCOMB_X18_Y4_N24
\incrementer|incrementer_pc_out[12]~24\ : cycloneive_lcell_comb
-- Equation(s):
-- \incrementer|incrementer_pc_out[12]~24_combout\ = (\pc_reg|reg_data_out\(12) & (\incrementer|incrementer_pc_out[11]~23\ $ (GND))) # (!\pc_reg|reg_data_out\(12) & (!\incrementer|incrementer_pc_out[11]~23\ & VCC))
-- \incrementer|incrementer_pc_out[12]~25\ = CARRY((\pc_reg|reg_data_out\(12) & !\incrementer|incrementer_pc_out[11]~23\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \pc_reg|reg_data_out\(12),
	datad => VCC,
	cin => \incrementer|incrementer_pc_out[11]~23\,
	combout => \incrementer|incrementer_pc_out[12]~24_combout\,
	cout => \incrementer|incrementer_pc_out[12]~25\);

-- Location: LCCOMB_X19_Y4_N18
\pc_register_in~26\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~26_combout\ = (\pc_register_in~25_combout\ & (((\incrementer|incrementer_pc_out[12]~24_combout\)) # (!\pc_select[0]~input_o\))) # (!\pc_register_in~25_combout\ & (\pc_select[0]~input_o\ & (\alu2_out[12]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101001100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \pc_register_in~25_combout\,
	datab => \pc_select[0]~input_o\,
	datac => \alu2_out[12]~input_o\,
	datad => \incrementer|incrementer_pc_out[12]~24_combout\,
	combout => \pc_register_in~26_combout\);

-- Location: FF_X19_Y4_N19
\pc_register_in[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pc_register_in~26_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pc_register_in(12));

-- Location: FF_X18_Y4_N25
\pc_reg|reg_data_out[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => pc_register_in(12),
	sload => VCC,
	ena => \pc_register_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \pc_reg|reg_data_out\(12));

-- Location: LCCOMB_X14_Y4_N14
\PC_int_Register|reg_data_out[12]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \PC_int_Register|reg_data_out[12]~feeder_combout\ = \pc_reg|reg_data_out\(12)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \pc_reg|reg_data_out\(12),
	combout => \PC_int_Register|reg_data_out[12]~feeder_combout\);

-- Location: FF_X14_Y4_N15
\PC_int_Register|reg_data_out[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_int_Register|reg_data_out[12]~feeder_combout\,
	ena => \ir_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_int_Register|reg_data_out\(12));

-- Location: IOIBUF_X30_Y0_N15
\mem_data_out[13]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_mem_data_out(13),
	o => \mem_data_out[13]~input_o\);

-- Location: IOIBUF_X32_Y0_N8
\alu2_out[13]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu2_out(13),
	o => \alu2_out[13]~input_o\);

-- Location: LCCOMB_X22_Y4_N6
\pc_register_in~27\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~27_combout\ = (\pc_select[0]~input_o\ & (((\pc_select[1]~input_o\) # (\alu2_out[13]~input_o\)))) # (!\pc_select[0]~input_o\ & (\mem_data_out[13]~input_o\ & (\pc_select[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110011100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mem_data_out[13]~input_o\,
	datab => \pc_select[0]~input_o\,
	datac => \pc_select[1]~input_o\,
	datad => \alu2_out[13]~input_o\,
	combout => \pc_register_in~27_combout\);

-- Location: LCCOMB_X18_Y4_N26
\incrementer|incrementer_pc_out[13]~26\ : cycloneive_lcell_comb
-- Equation(s):
-- \incrementer|incrementer_pc_out[13]~26_combout\ = (\pc_reg|reg_data_out\(13) & (!\incrementer|incrementer_pc_out[12]~25\)) # (!\pc_reg|reg_data_out\(13) & ((\incrementer|incrementer_pc_out[12]~25\) # (GND)))
-- \incrementer|incrementer_pc_out[13]~27\ = CARRY((!\incrementer|incrementer_pc_out[12]~25\) # (!\pc_reg|reg_data_out\(13)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \pc_reg|reg_data_out\(13),
	datad => VCC,
	cin => \incrementer|incrementer_pc_out[12]~25\,
	combout => \incrementer|incrementer_pc_out[13]~26_combout\,
	cout => \incrementer|incrementer_pc_out[13]~27\);

-- Location: IOIBUF_X25_Y0_N1
\alu1_out[13]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu1_out(13),
	o => \alu1_out[13]~input_o\);

-- Location: LCCOMB_X19_Y4_N0
\pc_register_in~28\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~28_combout\ = (\pc_register_in[0]~0_combout\ & (\pc_register_in~27_combout\)) # (!\pc_register_in[0]~0_combout\ & ((\pc_register_in~27_combout\ & (\incrementer|incrementer_pc_out[13]~26_combout\)) # (!\pc_register_in~27_combout\ & 
-- ((\alu1_out[13]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \pc_register_in[0]~0_combout\,
	datab => \pc_register_in~27_combout\,
	datac => \incrementer|incrementer_pc_out[13]~26_combout\,
	datad => \alu1_out[13]~input_o\,
	combout => \pc_register_in~28_combout\);

-- Location: FF_X19_Y4_N1
\pc_register_in[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pc_register_in~28_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pc_register_in(13));

-- Location: FF_X18_Y4_N27
\pc_reg|reg_data_out[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => pc_register_in(13),
	sload => VCC,
	ena => \pc_register_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \pc_reg|reg_data_out\(13));

-- Location: LCCOMB_X14_Y4_N12
\PC_int_Register|reg_data_out[13]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \PC_int_Register|reg_data_out[13]~feeder_combout\ = \pc_reg|reg_data_out\(13)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \pc_reg|reg_data_out\(13),
	combout => \PC_int_Register|reg_data_out[13]~feeder_combout\);

-- Location: FF_X14_Y4_N13
\PC_int_Register|reg_data_out[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_int_Register|reg_data_out[13]~feeder_combout\,
	ena => \ir_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_int_Register|reg_data_out\(13));

-- Location: IOIBUF_X23_Y0_N1
\alu2_out[14]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu2_out(14),
	o => \alu2_out[14]~input_o\);

-- Location: IOIBUF_X0_Y8_N22
\alu1_out[14]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu1_out(14),
	o => \alu1_out[14]~input_o\);

-- Location: IOIBUF_X23_Y0_N8
\mem_data_out[14]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_mem_data_out(14),
	o => \mem_data_out[14]~input_o\);

-- Location: LCCOMB_X19_Y4_N28
\pc_register_in~29\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~29_combout\ = (\pc_select[1]~input_o\ & (((\pc_select[0]~input_o\) # (\mem_data_out[14]~input_o\)))) # (!\pc_select[1]~input_o\ & (\alu1_out[14]~input_o\ & (!\pc_select[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111010100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \pc_select[1]~input_o\,
	datab => \alu1_out[14]~input_o\,
	datac => \pc_select[0]~input_o\,
	datad => \mem_data_out[14]~input_o\,
	combout => \pc_register_in~29_combout\);

-- Location: LCCOMB_X18_Y4_N28
\incrementer|incrementer_pc_out[14]~28\ : cycloneive_lcell_comb
-- Equation(s):
-- \incrementer|incrementer_pc_out[14]~28_combout\ = (\pc_reg|reg_data_out\(14) & (\incrementer|incrementer_pc_out[13]~27\ $ (GND))) # (!\pc_reg|reg_data_out\(14) & (!\incrementer|incrementer_pc_out[13]~27\ & VCC))
-- \incrementer|incrementer_pc_out[14]~29\ = CARRY((\pc_reg|reg_data_out\(14) & !\incrementer|incrementer_pc_out[13]~27\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \pc_reg|reg_data_out\(14),
	datad => VCC,
	cin => \incrementer|incrementer_pc_out[13]~27\,
	combout => \incrementer|incrementer_pc_out[14]~28_combout\,
	cout => \incrementer|incrementer_pc_out[14]~29\);

-- Location: LCCOMB_X19_Y4_N30
\pc_register_in~30\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~30_combout\ = (\pc_register_in~29_combout\ & (((\incrementer|incrementer_pc_out[14]~28_combout\) # (!\pc_select[0]~input_o\)))) # (!\pc_register_in~29_combout\ & (\alu2_out[14]~input_o\ & (\pc_select[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110000101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \alu2_out[14]~input_o\,
	datab => \pc_register_in~29_combout\,
	datac => \pc_select[0]~input_o\,
	datad => \incrementer|incrementer_pc_out[14]~28_combout\,
	combout => \pc_register_in~30_combout\);

-- Location: FF_X19_Y4_N31
\pc_register_in[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pc_register_in~30_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pc_register_in(14));

-- Location: FF_X18_Y4_N29
\pc_reg|reg_data_out[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => pc_register_in(14),
	sload => VCC,
	ena => \pc_register_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \pc_reg|reg_data_out\(14));

-- Location: LCCOMB_X14_Y4_N2
\PC_int_Register|reg_data_out[14]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \PC_int_Register|reg_data_out[14]~feeder_combout\ = \pc_reg|reg_data_out\(14)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \pc_reg|reg_data_out\(14),
	combout => \PC_int_Register|reg_data_out[14]~feeder_combout\);

-- Location: FF_X14_Y4_N3
\PC_int_Register|reg_data_out[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_int_Register|reg_data_out[14]~feeder_combout\,
	ena => \ir_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_int_Register|reg_data_out\(14));

-- Location: IOIBUF_X18_Y0_N8
\mem_data_out[15]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_mem_data_out(15),
	o => \mem_data_out[15]~input_o\);

-- Location: IOIBUF_X34_Y4_N22
\alu2_out[15]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu2_out(15),
	o => \alu2_out[15]~input_o\);

-- Location: LCCOMB_X17_Y4_N30
\pc_register_in~31\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~31_combout\ = (\pc_select[0]~input_o\ & (((\pc_select[1]~input_o\) # (\alu2_out[15]~input_o\)))) # (!\pc_select[0]~input_o\ & (\mem_data_out[15]~input_o\ & (\pc_select[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110011100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \mem_data_out[15]~input_o\,
	datab => \pc_select[0]~input_o\,
	datac => \pc_select[1]~input_o\,
	datad => \alu2_out[15]~input_o\,
	combout => \pc_register_in~31_combout\);

-- Location: LCCOMB_X18_Y4_N30
\incrementer|incrementer_pc_out[15]~30\ : cycloneive_lcell_comb
-- Equation(s):
-- \incrementer|incrementer_pc_out[15]~30_combout\ = \pc_reg|reg_data_out\(15) $ (\incrementer|incrementer_pc_out[14]~29\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \pc_reg|reg_data_out\(15),
	cin => \incrementer|incrementer_pc_out[14]~29\,
	combout => \incrementer|incrementer_pc_out[15]~30_combout\);

-- Location: IOIBUF_X21_Y0_N15
\alu1_out[15]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_alu1_out(15),
	o => \alu1_out[15]~input_o\);

-- Location: LCCOMB_X17_Y4_N6
\pc_register_in~32\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc_register_in~32_combout\ = (\pc_register_in~31_combout\ & ((\pc_register_in[0]~0_combout\) # ((\incrementer|incrementer_pc_out[15]~30_combout\)))) # (!\pc_register_in~31_combout\ & (!\pc_register_in[0]~0_combout\ & ((\alu1_out[15]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \pc_register_in~31_combout\,
	datab => \pc_register_in[0]~0_combout\,
	datac => \incrementer|incrementer_pc_out[15]~30_combout\,
	datad => \alu1_out[15]~input_o\,
	combout => \pc_register_in~32_combout\);

-- Location: FF_X17_Y4_N7
\pc_register_in[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pc_register_in~32_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pc_register_in(15));

-- Location: FF_X18_Y4_N31
\pc_reg|reg_data_out[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => pc_register_in(15),
	sload => VCC,
	ena => \pc_register_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \pc_reg|reg_data_out\(15));

-- Location: LCCOMB_X14_Y4_N16
\PC_int_Register|reg_data_out[15]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \PC_int_Register|reg_data_out[15]~feeder_combout\ = \pc_reg|reg_data_out\(15)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \pc_reg|reg_data_out\(15),
	combout => \PC_int_Register|reg_data_out[15]~feeder_combout\);

-- Location: FF_X14_Y4_N17
\PC_int_Register|reg_data_out[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \PC_int_Register|reg_data_out[15]~feeder_combout\,
	ena => \ir_enable~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC_int_Register|reg_data_out\(15));

ww_instruction_int_out(0) <= \instruction_int_out[0]~output_o\;

ww_instruction_int_out(1) <= \instruction_int_out[1]~output_o\;

ww_instruction_int_out(2) <= \instruction_int_out[2]~output_o\;

ww_instruction_int_out(3) <= \instruction_int_out[3]~output_o\;

ww_instruction_int_out(4) <= \instruction_int_out[4]~output_o\;

ww_instruction_int_out(5) <= \instruction_int_out[5]~output_o\;

ww_instruction_int_out(6) <= \instruction_int_out[6]~output_o\;

ww_instruction_int_out(7) <= \instruction_int_out[7]~output_o\;

ww_instruction_int_out(8) <= \instruction_int_out[8]~output_o\;

ww_instruction_int_out(9) <= \instruction_int_out[9]~output_o\;

ww_instruction_int_out(10) <= \instruction_int_out[10]~output_o\;

ww_instruction_int_out(11) <= \instruction_int_out[11]~output_o\;

ww_instruction_int_out(12) <= \instruction_int_out[12]~output_o\;

ww_instruction_int_out(13) <= \instruction_int_out[13]~output_o\;

ww_instruction_int_out(14) <= \instruction_int_out[14]~output_o\;

ww_instruction_int_out(15) <= \instruction_int_out[15]~output_o\;

ww_pc_register_int_out(0) <= \pc_register_int_out[0]~output_o\;

ww_pc_register_int_out(1) <= \pc_register_int_out[1]~output_o\;

ww_pc_register_int_out(2) <= \pc_register_int_out[2]~output_o\;

ww_pc_register_int_out(3) <= \pc_register_int_out[3]~output_o\;

ww_pc_register_int_out(4) <= \pc_register_int_out[4]~output_o\;

ww_pc_register_int_out(5) <= \pc_register_int_out[5]~output_o\;

ww_pc_register_int_out(6) <= \pc_register_int_out[6]~output_o\;

ww_pc_register_int_out(7) <= \pc_register_int_out[7]~output_o\;

ww_pc_register_int_out(8) <= \pc_register_int_out[8]~output_o\;

ww_pc_register_int_out(9) <= \pc_register_int_out[9]~output_o\;

ww_pc_register_int_out(10) <= \pc_register_int_out[10]~output_o\;

ww_pc_register_int_out(11) <= \pc_register_int_out[11]~output_o\;

ww_pc_register_int_out(12) <= \pc_register_int_out[12]~output_o\;

ww_pc_register_int_out(13) <= \pc_register_int_out[13]~output_o\;

ww_pc_register_int_out(14) <= \pc_register_int_out[14]~output_o\;

ww_pc_register_int_out(15) <= \pc_register_int_out[15]~output_o\;
END structure;



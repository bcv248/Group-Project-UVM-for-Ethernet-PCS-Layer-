package gmii_tx_pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	// sequences ===========
	`include "gmii_items.sv"
	`include "gmii_base_seq.sv"   // helper tasks; no body logic
	`include "gmii_init_seq.sv"   // warmup: idle + random active
	`include "gmii_tc1_seq.sv"    // TC1: FSM-exercising frames
	`include "gmii_tc2_seq.sv"    // TC2: Send idle, then just 1 packet
	`include "gmii_tc3_seq.sv"    // TC3: Send idle, then packet, then idle
	`include "gmii_tc4_seq.sv"    // TC4: Send back to back packets without much idle time in between
	`include "gmii_tc5_seq.sv"    // TC5: corner-case TXD patterns
	`include "gmii_top_seq.sv"    // orchestrator
	`include "gmii_sequencer.sv"


	// components ==========	
	`include "gmii_driver.sv"
	`include "gmii_monitor.sv"
	`include "gmii_scoreboard.sv"
	`include "gmii_agent.sv"
	`include "gmii_environment.sv"
	`include "gmii_test.sv"	
endpackage

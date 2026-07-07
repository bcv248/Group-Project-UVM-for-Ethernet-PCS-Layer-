// gmii_tc3_seq.sv
// back to back frames. Send a frame, de-assert tx_en and idle for a few cycles, then assert again. 
// check if DUT enters SSD1 from IDLE when there's not much idle time after ESD2.

class gmii_tc3_seq extends gmii_base_seq;
	`uvm_object_utils(gmii_tc3_seq)

	function new(string name = "gmii_tc3_seq");
		super.new(name);
	endfunction

	task body();
		`uvm_info("SEQ", "TC3 idle -> frame -> idle -> frame", UVM_LOW)
		send_idle(20);
		send_frame(1);
		send_idle(20);
		send_frame(1);
	endtask

endclass

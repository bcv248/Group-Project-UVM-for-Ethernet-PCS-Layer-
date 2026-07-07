// gmii_tc2_seq.sv

// minimum length frame
// assert tx_en = 1 and then send 1 frame, and then deassert.

class gmii_tc2_seq extends gmii_base_seq;
	`uvm_object_utils(gmii_tc2_seq)
	
	function new(string name = "gmii_tc2_seq");
		super.new(name);
	endfunction

	task body();
		// send idle and then 1 frame
		`uvm_info("SEQ", "TC2 Idle -> 1 frame -> idle", UVM_LOW)
		send_idle(20);
		send_frame(1);

		// repeat 20x
		repeat(20) begin
			send_idle(20);
			send_frame(1);
		end

		// 2 cycle frames
		repeat(10) begin
			send_idle(20);
			send_frame(2);
		end

	endtask


endclass

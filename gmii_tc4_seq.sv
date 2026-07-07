// gmii_tc4_seq.sv
// zero gap back to back.
// expect each frame to drain fully all the way through ESD2 before the next SSD1 

class gmii_tc4_seq extends gmii_base_seq;
	`uvm_object_utils(gmii_tc4_seq)

	function new(string name = "gmii_tc4_seq");
		super.new(name);
	endfunction

	task body();
		
		// 1 cycle gap 
		`uvm_info("SEQ", "TC4 back to back 1 cycle gap", UVM_LOW)
		send_idle(20);
		repeat(2) begin
			send_data(50);
			send_idle(1);
		end
		send_data(50);
		send_idle(10);

		// 2 cycle gap 
		`uvm_info("SEQ", "TC4 back to back 2 cycle gap", UVM_LOW)
		send_idle(20);
		repeat(2) begin
			send_data(50);
			send_idle(2);
		end
		send_data(50);
		send_idle(10);

		// 3 cycle gap 
		`uvm_info("SEQ", "TC4 back to back 3 cycle gap", UVM_LOW)
		send_idle(20);
		repeat(2) begin
			send_data(50);
			send_idle(3);
		end
		send_data(50);
		send_idle(10);

		// 10 short frames with 1 cycle gap 
		`uvm_info("SEQ", "TC4 back to back, short frames", UVM_LOW)
		send_idle(20);
		repeat(10) begin
			send_data(20);
			send_idle(1);
		end
		send_idle(10);

	endtask

endclass

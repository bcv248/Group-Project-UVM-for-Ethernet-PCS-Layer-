// gmii_tc1_seq.sv
// TC1: structured single frames exercising the full FSM path
// IDLE -> SSD1 -> SSD2 -> DATA -> CSR1 -> CSR2 -> ESD1 -> ESD2 -> IDLE

class gmii_tc1_seq extends gmii_base_seq;
    `uvm_object_utils(gmii_tc1_seq)

    function new(string name = "gmii_tc1_seq");
        super.new(name);
    endfunction

    task body();
        // Short frame (10 data cycles)
        `uvm_info("SEQ", "TC1: short frame (10 cycles)", UVM_LOW)
        send_idle(20);
        send_frame(10);

        // Medium frame (50 data cycles)
        `uvm_info("SEQ", "TC1: medium frame (50 cycles)", UVM_LOW)
        send_idle(20);
        send_frame(50);

         // Long frame (200 data cycles)
        `uvm_info("SEQ", "TC1: long frame (200 cycles)", UVM_LOW)
        send_idle(20);
        send_frame(200);
	
	// Very long frame (250K data cycles) like a big file download
        `uvm_info("SEQ", "TC1: long frame (250K cycles)", UVM_LOW)
        send_idle(20);
        send_frame(250_000);

        // Repeated short frames — verify FSM resets correctly each time
        `uvm_info("SEQ", "TC1: repeated short frames", UVM_LOW)
        repeat(10) begin
            send_idle(20);
            send_frame(15);
        end
    endtask

endclass

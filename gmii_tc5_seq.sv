// gmii_tc5_seq.sv
// TC5: corner-case TXD patterns — each pattern sent for 200 cycles with idle gaps

class gmii_tc5_seq extends gmii_base_seq;
    `uvm_object_utils(gmii_tc5_seq)

    function new(string name = "gmii_tc5_seq");
        super.new(name);
    endfunction

    task body();
        // 0x55 — Ethernet preamble byte
        `uvm_info("SEQ", "TC5: TXD=0x55 (preamble)", UVM_LOW)
        send_idle(20);
        send_fixed_data(8'h55, 200);
        send_idle(20);

        // 0x00 — all zeros 
        `uvm_info("SEQ", "TC5: TXD=0x00 (all zeros)", UVM_LOW)
        send_idle(20);
        send_fixed_data(8'h00, 200);
        send_idle(20);

        // 0xFF — all ones
        `uvm_info("SEQ", "TC5: TXD=0xFF (all ones)", UVM_LOW)
        send_idle(20);
        send_fixed_data(8'hFF, 200);
        send_idle(20);

        // 0xAA — alternating bits
        `uvm_info("SEQ", "TC5: TXD=0xAA (alternating)", UVM_LOW)
        send_idle(20);
        send_fixed_data(8'hAA, 200);
        send_idle(20);

    endtask

endclass

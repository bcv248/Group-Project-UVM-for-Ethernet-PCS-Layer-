// gmii_base_seq.sv
// Base sequence — helper tasks shared by all sub-sequences; no body logic here.

class gmii_base_seq extends uvm_sequence #(gmii_items);
    `uvm_object_utils(gmii_base_seq)

    function new(string name = "gmii_base_seq");
        super.new(name);
    endfunction

    // Drive N idle cycles (tx_en=0, randomized txd)
    task send_idle(int unsigned n);
        gmii_items items;
        repeat(n) begin
            items = gmii_items::type_id::create("items");
            start_item(items);
            if(!items.randomize() with {tx_en == 1'b0;})
                `uvm_error("SEQ", "Idle randomization failed")
            finish_item(items);
        end
    endtask

    // Drive N cycles with a fixed TXD value (tx_en=1)
    task send_fixed_data(logic [7:0] txd_val, int unsigned n);
        gmii_items items;
        repeat(n) begin
            items = gmii_items::type_id::create("items");
            start_item(items);
            if(!items.randomize() with {tx_en == 1'b1; txd == txd_val;})
                `uvm_error("SEQ", $sformatf("Fixed TXD 0x%02X randomization failed", txd_val))
            finish_item(items);
        end
    endtask

    // Drive a full structured frame — tx_en=1 for n data cycles (random txd)
    task send_data(int unsigned n);
        gmii_items items;
        repeat(n) begin
            items = gmii_items::type_id::create("items");
            start_item(items);
            if(!items.randomize() with {tx_en == 1'b1;})
                `uvm_error("SEQ", "Frame data randomization failed")
            finish_item(items);
        end
    endtask

    // Drive a full structured frame — tx_en=1 for n data cycles (random txd),
    // then 10 idle cycles so the FSM can drain (DATA -> CSR1 -> CSR2 -> ESD1→ ESD2 -> IDLE)
    task send_frame(int unsigned n);
        gmii_items items;
        repeat(n) begin
            items = gmii_items::type_id::create("items");
            start_item(items);
            if(!items.randomize() with {tx_en == 1'b1;})
                `uvm_error("SEQ", "Frame data randomization failed")
            finish_item(items);
        end
        send_idle(10);
    endtask

    virtual task body();
    endtask

endclass

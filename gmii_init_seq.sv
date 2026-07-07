// gmii_init_seq.sv
// Warmup sequence: 20,000 idle cycles followed by 2,000 random active cycles.

class gmii_init_seq extends gmii_base_seq;
    `uvm_object_utils(gmii_init_seq)

    function new(string name = "gmii_init_seq");
        super.new(name);
    endfunction

    task body();
        gmii_items items;

        // Hold idle for 20,000 cycles — FSM must stay in IDLE with tx_en=0
        repeat(20000) begin
            items = gmii_items::type_id::create("items");
            start_item(items);
            if(!items.randomize() with {tx_en == 1'b0;})
                `uvm_error("SEQ", "IDLE check failed")
            finish_item(items);
        end

        // Drive 2,000 cycles with tx_en=1 and random txd
        repeat(2000) begin
            items = gmii_items::type_id::create("items");
            start_item(items);
            if(!items.randomize() with {tx_en == 1'b1;})
                `uvm_error("SEQ", "Randomization failed")
            finish_item(items);
        end
    endtask

endclass

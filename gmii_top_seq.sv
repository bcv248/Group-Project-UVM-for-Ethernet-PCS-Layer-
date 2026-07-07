// gmii_top_seq.sv
// Orchestrator sequence — starts sub-sequences in order on the shared sequencer.
// To add a new test case: declare+create a handle here, then call .start(m_sequencer).

class gmii_top_seq extends uvm_sequence #(gmii_items);
    `uvm_object_utils(gmii_top_seq)

    function new(string name = "gmii_top_seq");
        super.new(name);
    endfunction

    task body();
        gmii_init_seq init = gmii_init_seq::type_id::create("init");
        gmii_tc1_seq  tc1  = gmii_tc1_seq::type_id::create("tc1");
        gmii_tc2_seq  tc2  = gmii_tc2_seq::type_id::create("tc2");
        gmii_tc3_seq  tc3  = gmii_tc3_seq::type_id::create("tc3");
        gmii_tc4_seq  tc4  = gmii_tc4_seq::type_id::create("tc4");
        gmii_tc5_seq  tc5  = gmii_tc5_seq::type_id::create("tc5");

        init.start(m_sequencer);
        tc1.start(m_sequencer);
        tc2.start(m_sequencer);
        tc3.start(m_sequencer);
        tc4.start(m_sequencer);
        tc5.start(m_sequencer);
    endtask

endclass

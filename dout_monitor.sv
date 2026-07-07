// dout_monitor.sv

class dout_monitor extends uvm_monitor;
    `uvm_component_utils(dout_monitor)

    virtual dut_if vif;
    
    // analysis port to broadcast the symbols to the scoreboard
    uvm_analysis_port #(dout_item) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    task run_phase(uvm_phase phase);
        dout_item tr;

        // wait for the active-high reset to de-assert before we start sampling
        // don't want to capture garbage initialization data
        wait(vif.Reset == 1'b0);

        forever begin
            // 1. wait for the active clock edge
            @(posedge vif.Clk);

            // 2. create a fresh transaction object
            tr = dout_item::type_id::create("tr");

            // 3. extract the 3-bit 2s complement symbols from the interface
            //    using  unpacking function in dout_item.sv
            tr.unpack_from_dut(vif.Dout);

            // 4. broadcast the captured symbol to the Scoreboard
            ap.write(tr);
        end
    endtask

endclass

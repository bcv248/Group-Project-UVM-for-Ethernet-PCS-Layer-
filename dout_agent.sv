// dout_agent.sv

class dout_agent extends uvm_agent;
    `uvm_component_utils(dout_agent)
    dout_monitor mon;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // instantiate the passive monitor
        mon = dout_monitor::type_id::create("mon", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        // retrieve the virtual interface from the top-level configuration database
        // and assign it directly to the monitor's virtual interface pointer.
        if (!uvm_config_db#(virtual dut_if)::get(this, "", "vif", mon.vif)) begin
            `uvm_fatal("DOUT_AGENT", "Virtual interface 'vif' not found in uvm_config_db!")
        end
    endfunction

endclass

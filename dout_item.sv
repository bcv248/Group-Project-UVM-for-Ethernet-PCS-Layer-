// dout_item.sv

class dout_item extends uvm_sequence_item;
    `uvm_object_utils(dout_item)

    // use signed so systemverilogy understands the 2s complement math
    logic signed [2:0] A;
    logic signed [2:0] B;
    logic signed [2:0] C;
    logic signed [2:0] D;

    function new(string name = "dout_item"); 
        super.new(name);
    endfunction

    
    // helper function to map the packed DUT output to named variables
    function void unpack_from_dut(logic [3:0][2:0] dut_out);
        // Based on the packed struct in DUTS26_0.sv, 
        // A is the MSB and D is the LSB
        this.A = dut_out[3];
        this.B = dut_out[2];
        this.C = dut_out[1];
        this.D = dut_out[0];
    endfunction

    // override the default print formatter for better scoreboard log
    virtual function string convert2string();
        return $sformatf("Symbols -> A:%0d  B:%0d  C:%0d  D:%0d", A, B, C, D);
    endfunction

    // override the default comparator
    virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        dout_item rhs_;
        
        if (!$cast(rhs_, rhs)) begin
            `uvm_fatal("COMPARE", "Cast failed in dout_item");
            return 0;
        end
        
        return (super.do_compare(rhs, comparer) &&
                (this.A == rhs_.A) &&
                (this.B == rhs_.B) &&
                (this.C == rhs_.C) &&
                (this.D == rhs_.D));
    endfunction

endclass

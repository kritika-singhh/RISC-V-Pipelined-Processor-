`timescale 1ns/1ns
module addpl_tb;

    reg clk;
    reg rst;

    addpl uut (
        .clk(clk),
        .rst(rst)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("addpl.vcd");
        $dumpvars(0, addpl_tb.uut);

        clk = 1'b1;
        rst = 1'b1;

        #10 rst = 1'b0;

        #400;

        $display("x5 = %0d", uut.rf.regfile[5]);
        $display("x6 = %0d", uut.rf.regfile[6]);
        $display("x7 = %0d", uut.rf.regfile[7]);
        $display("x8 = %0d", uut.rf.regfile[8]);

        $finish;

    end
endmodule



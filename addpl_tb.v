/*`timescale 1ns/1ns

module addpl_tb;

    reg clk;
    reg rst;

    addpl uut (
        .clk(clk),
        .rst(rst)
    );

    // 10 ns clock period
    always #5 clk = ~clk;

    initial begin
        $dumpfile("addpl.vcd");
        $dumpvars(0, addpl_tb.uut);

        clk = 1'b0;
        rst = 1'b1;

        @(posedge clk); #1;
        @(posedge clk); #1;
        rst = 1'b0;

        #600;

        $display("---------- Register Results ----------");
        $display("x1 = %0d  (expected 30)",  uut.rf.rf[1]);
        $display("x2 = %0d  (expected 20)",  uut.rf.rf[2]);
        $display("x5 = %0d  (expected 50)",  uut.rf.rf[5]);
        $display("x6 = %0d  (expected 70)",  uut.rf.rf[6]);
        $display("x7 = %0d  (expected 100)", uut.rf.rf[7]);
        $display("x8 = %0d  (expected 170)", uut.rf.rf[8]);

        // Automated pass/fail checks
        if (uut.rf.rf[5] === 32'd50)  $display("PASS: x5");
        else                           $display("FAIL: x5 got %0d", uut.rf.rf[5]);

        if (uut.rf.rf[6] === 32'd70)  $display("PASS: x6");
        else                           $display("FAIL: x6 got %0d", uut.rf.rf[6]);

        if (uut.rf.rf[7] === 32'd100) $display("PASS: x7");
        else                           $display("FAIL: x7 got %0d", uut.rf.rf[7]);

        if (uut.rf.rf[8] === 32'd170) $display("PASS: x8");
        else                           $display("FAIL: x8 got %0d", uut.rf.rf[8]);

        $finish;
    end

endmodule*/


`timescale 1ns/1ns

module addpl_tb;

    reg clk;
    reg rst;

    addpl uut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin

        $dumpfile("addpl.vcd");
        $dumpvars(0, addpl_tb.uut);

        clk = 1'b1;
        rst = 1'b1;

        #10 rst = 1'b0;

        // Wait for pipeline to finish
        #400;

        $display("x5 = %0d", uut.rf.regfile[5]);
        $display("x6 = %0d", uut.rf.regfile[6]);
        $display("x7 = %0d", uut.rf.regfile[7]);
        $display("x8 = %0d", uut.rf.regfile[8]);

        $finish;

    end

endmodule

/*`timescale 1ns/1ns

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

        clk = 1;
        rst = 1;

        #10 rst = 0;

        #200;

        $display("x5  = %d", uut.rf.regfile[5]);
        $display("x6  = %d", uut.rf.regfile[6]);
        $display("x7  = %d", uut.rf.regfile[7]);
        $display("x8  = %d", uut.rf.regfile[8]);
        $display("x9  = %d", uut.rf.regfile[9]);

        $finish;
    end
endmodule*/


/*`timescale 1ns/1ns
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

        clk = 0;
        rst = 1;

        #10 rst = 0;

        #100;
        $display("x3 = %d", uut.rf.regfile[3]);
        $display("x4 = %d", uut.rf.regfile[4]);
        $display("x7 = %d", uut.rf.regfile[7]);

        $finish;
    end
endmodule*/

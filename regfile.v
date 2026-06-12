module regfile (

    input clk,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [31:0] wd,
    input we,
    output [31:0] rs1_data,
    output [31:0] rs2_data
);

    reg [31:0] regfile [0:31];
    integer i;

    initial begin

        for (i = 0; i < 32; i = i + 1)
            regfile[i] = 0;

        regfile[1] = 30;   // x1
        regfile[2] = 20;   // x2
        regfile[5] = 10;   // x5

    end

    assign rs1_data = regfile[rs1];
    assign rs2_data = regfile[rs2];

    always @(posedge clk) begin
        if (we && (rd != 0))
            regfile[rd] <= wd;
    end
endmodule


/*module instrmem (
    input  [31:0] addr,
    output reg [31:0] instr
);
    always @(*) begin
        case (addr)
            // add x5, x1, x2    x5 = 30+20 = 50
            32'd0  : instr = 32'b0000000_00010_00001_000_00101_0110011;
            // add x6, x5, x2    x6 = 50+20 = 70
            32'd4  : instr = 32'b0000000_00010_00101_000_00110_0110011;
            // add x7, x6, x1    x7 = 70+30 = 100
            32'd8  : instr = 32'b0000000_00001_00110_000_00111_0110011;
            // add x8, x7, x6     x8 = 100+70 = 170
            32'd12 : instr = 32'b0000000_00110_00111_000_01000_0110011;
            default: instr = 32'd0;
        endcase
    end
endmodule*/


module instrmem (
    input [31:0] addr,
    output reg [31:0] instr
);

    always @(*) begin
        case(addr)

            // add x5,x1,x2
            0  : instr = 32'b0000000_00010_00001_000_00101_0110011;

            // add x6,x5,x2   
            4  : instr = 32'b0000000_00010_00101_000_00110_0110011;

            // add x7,x6,x1   
            8  : instr = 32'b0000000_00001_00110_000_00111_0110011;

            // add x8,x7,x6   
            12  : instr = 32'b0000000_00110_00111_000_01000_0110011;            

            default:
                instr = 32'b0;

        endcase
    end

endmodule


/*module instrmem (
    input [31:0] addr,
    output reg [31:0] instr
);

    always @(*) begin

        case(addr)

            // add x5,x1,x2
            0  : instr = 32'b0000000_00010_00001_000_00101_0110011;

            // sub x6,x1,x2
            4  : instr = 32'b0100000_00010_00001_000_00110_0110011;

            // and x7,x1,x2
            8  : instr = 32'b0000000_00010_00001_111_00111_0110011;

            // or x8,x1,x2
            12 : instr = 32'b0000000_00010_00001_110_01000_0110011;

            // addi x9,x1,15
            16 : instr = 32'b000000001111_00001_000_01001_0010011;

            default:
                instr = 32'b0;

        endcase
    end

endmodule*/

/*module instrmem (
    input [31:0] addr,
    output reg [31:0] instr
);

    always @(*) begin
        case(addr)
            0: instr = 32'b0000000_00100_00011_000_00111_0110011; // add x3,x1,x2
            default: instr = 32'b0;
        endcase
    end

endmodule*/
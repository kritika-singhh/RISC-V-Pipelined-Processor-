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



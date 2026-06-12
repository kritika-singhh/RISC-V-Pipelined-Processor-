module addpl (
    input clk,
    input rst
);

    reg [31:0] pc;
    wire [31:0] instr;

    reg [31:0] IF_ID_instr;
    reg [31:0] IF_ID_pc;

    reg [31:0] ID_EX_rs1_data;
    reg [31:0] ID_EX_rs2_data;
    reg [31:0] ID_EX_imm;
    reg [4:0]  ID_EX_rd;
    reg [3:0]  ID_EX_alu_ctrl;
    reg        ID_EX_alusrc;

    reg [31:0] EX_MEM_result;
    reg [4:0]  EX_MEM_rd;

    reg [31:0] MEM_WB_result;
    reg [4:0]  MEM_WB_rd;

    initial begin
        pc          = 0;
        IF_ID_instr = 0;
        IF_ID_pc    = 0;
        ID_EX_rd    = 0;
        EX_MEM_rd   = 0;
        MEM_WB_rd   = 0;
    end

    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [4:0] rs1, rs2, rd;

    assign opcode = IF_ID_instr[6:0];
    assign rd     = IF_ID_instr[11:7];
    assign funct3 = IF_ID_instr[14:12];
    assign rs1    = IF_ID_instr[19:15];
    assign rs2    = IF_ID_instr[24:20];
    assign funct7 = IF_ID_instr[31:25];

    wire stall;

    assign stall =
           ((ID_EX_rd != 0) &&
           ((ID_EX_rd == rs1) || (ID_EX_rd == rs2)))
        ||
           ((EX_MEM_rd != 0) &&
           ((EX_MEM_rd == rs1) || (EX_MEM_rd == rs2)))
        ||
           ((MEM_WB_rd != 0) &&
           ((MEM_WB_rd == rs1) || (MEM_WB_rd == rs2)));

    wire [31:0] rs1_data, rs2_data;

    regfile rf (
        .clk(clk),
        .rs1(rs1),
        .rs2(rs2),
        .rd(MEM_WB_rd),
        .wd(MEM_WB_result),
        .we(1'b1),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    instrmem imem (
        .addr(pc),
        .instr(instr)
    );

    always @(posedge clk or posedge rst) begin
        if (rst)
            pc <= 0;
        else if (!stall)
            pc <= pc + 4;
        else
            pc <= pc;
    end

    always @(posedge clk) begin
        if (!stall) begin
            IF_ID_instr <= instr;
            IF_ID_pc    <= pc;
        end
    end

    wire [31:0] imm_i;
    assign imm_i = {{20{IF_ID_instr[31]}}, IF_ID_instr[31:20]};

    reg [3:0] alu_ctrl;
    reg alusrc;

    always @(*) begin

        alu_ctrl = 4'b0000;
        alusrc   = 1'b0;

        case(opcode)

            7'b0110011: begin

                alusrc = 0;

                case ({funct7,funct3})

                    10'b0000000_000:
                        alu_ctrl = 4'b0000;   // ADD

                    10'b0100000_000:
                        alu_ctrl = 4'b0001;   // SUB

                    10'b0000000_111:
                        alu_ctrl = 4'b0010;   // AND

                    10'b0000000_110:
                        alu_ctrl = 4'b0011;   // OR

                endcase

            end

            7'b0010011: begin
                alusrc  = 1;
                alu_ctrl = 4'b0000;
            end

        endcase

    end

    always @(posedge clk) begin

        if (stall) begin

            ID_EX_rs1_data <= 0;
            ID_EX_rs2_data <= 0;
            ID_EX_imm      <= 0;

            ID_EX_rd       <= 0;

            ID_EX_alu_ctrl <= 0;
            ID_EX_alusrc   <= 0;

        end
        else begin

            ID_EX_rs1_data <= rs1_data;
            ID_EX_rs2_data <= rs2_data;
            ID_EX_imm      <= imm_i;

            ID_EX_rd       <= rd;

            ID_EX_alu_ctrl <= alu_ctrl;
            ID_EX_alusrc   <= alusrc;

        end

    end

    wire [31:0] alu_in2;
    assign alu_in2 = (ID_EX_alusrc) ? ID_EX_imm : ID_EX_rs2_data;

    reg [31:0] alu_result;

    always @(*) begin

        case (ID_EX_alu_ctrl)

            4'b0000:
                alu_result = ID_EX_rs1_data + alu_in2;

            4'b0001:
                alu_result = ID_EX_rs1_data - alu_in2;

            4'b0010:
                alu_result = ID_EX_rs1_data & alu_in2;

            4'b0011:
                alu_result = ID_EX_rs1_data | alu_in2;

            default:
                alu_result = 0;

        endcase

    end

    always @(posedge clk) begin
        EX_MEM_result <= alu_result;
        EX_MEM_rd     <= ID_EX_rd;
    end

    always @(posedge clk) begin
        MEM_WB_result <= EX_MEM_result;
        MEM_WB_rd     <= EX_MEM_rd;
    end

endmodule






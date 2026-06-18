module alu_core(
    input wire [31:0] alu_in1,      // Operand data 1 (from rs1)
    input wire [31:0] alu_in2,      // Operand data 2 (from rs2)
    input wire [3:0] alu_control,   // Command bits from Control Unit
    output reg [31:0] alu_result,   // Final calculation result output
    output wire alu_zero_flag       // High if result equals zero (for branches)
);

    always @(*) begin
        case (alu_control)
            4'b0000: alu_result = alu_in1 + alu_in2;  // ADD
            4'b0001: alu_result = alu_in1 - alu_in2;  // SUB
            4'b0010: alu_result = alu_in1 & alu_in2;  // AND
            4'b0011: alu_result = alu_in1 | alu_in2;  // OR
            default: alu_result = 32'b0;
        endcase
    end

    assign alu_zero_flag = (alu_result == 32'b0) ? 1'b1 : 1'b0;

endmodule


module control_unit(
    input wire [6:0] opcode,
    input wire [2:0] funct3,
    input wire [6:0] funct7,
    output reg reg_write_en,
    output reg [3:0] alu_control
);

    always @(*) begin
        // Default execution states
        reg_write_en = 1'b0;
        alu_control  = 4'b0000; // Default: ADD

        case (opcode)
            7'b0110011: begin // R-type Arithmetic instruction
                reg_write_en = 1'b1; // Allow register file writes
                
                case (funct3)
                    3'b000: begin
                        if (funct7 == 7'h20)
                            alu_control = 4'b0001; // SUB operation
                        else
                            alu_control = 4'b0000; // ADD operation
                    end
                    3'b111: alu_control = 4'b0010; // AND operation
                    3'b110: alu_control = 4'b0011; // OR operation
                    default: alu_control = 4'b0000;
                endcase
            end
            default: begin
                reg_write_en = 1'b0;
                alu_control  = 4'b0000;
            end
        endcase
    end

endmodule

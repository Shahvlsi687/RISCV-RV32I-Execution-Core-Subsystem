module decoder(
    input wire [31:0] instruction,    // The 32-bit instruction fetched from memory
    output reg [6:0] opcode,          // Specifies the operation type
    output reg [4:0] rd,              // Destination register address
    output reg [4:0] rs1,             // Source register 1 address
    output reg [4:0] rs2,             // Source register 2 address
    output reg [2:0] funct3,          // Additional instruction qualifier
    output reg [6:0] funct7,          // Extended operation identifier
    output reg is_alu_op              // Control flag: 1 if it is an arithmetic operation
);

    // Combinational block: decode fields instantly when the instruction changes
    always @(*) begin
        // Slicing the standard 32-bit RISC-V fields
        opcode   = instruction[6:0];
        rd       = instruction[11:7];
        funct3   = instruction[14:12];
        rs1      = instruction[19:15];
        rs2      = instruction[24:20];
        funct7   = instruction[31:25];

        // Generate control signal logic based on the RISC-V ISA spec
        if (opcode == 7'b0110011) begin
            is_alu_op = 1'b1; // This is a standard Register-Register R-type ALU operation (like ADD)
        end else begin
            is_alu_op = 1'b0; // Not a standard R-type ALU operation
        end
    end

endmodule

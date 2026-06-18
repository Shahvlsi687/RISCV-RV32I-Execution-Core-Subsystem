module register_file(
    input wire clk,
    input wire reg_write_en,      // Control signal to enable writing data
    input wire [4:0] read_reg1,   // Source register 1 address (rs1)
    input wire [4:0] read_reg2,   // Source register 2 address (rs2)
    input wire [4:0] write_reg,   // Destination register address (rd)
    input wire [31:0] write_data, // 32-bit data to be written into rd
    output wire [31:0] read_data1,// 32-bit data read out from rs1
    output wire [31:0] read_data2 // 32-bit data read out from rs2
);

    // Array of 32 registers, each 32 bits wide
    reg [31:0] registers [0:31];

    // Dual-Port Asynchronous Read Logic
    assign read_data1 = (read_reg1 == 5'b0) ? 32'b0 : registers[read_reg1];
    assign read_data2 = (read_reg2 == 5'b0) ? 32'b0 : registers[read_reg2];

    // Synchronous initialization block
    integer i;
    initial begin
        // Reset all 32 core registers to absolute zero
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 32'b0;
        end
        // FIXED: Explicitly load arguments using correct index array brackets
        registers[4] = 32'h0000_000A; // x4 = 10 (decimal)
        registers[5] = 32'h0000_0014; // x5 = 20 (decimal)
    end

    // Synchronous Write Logic (Happens on rising clock edge)
    always @(posedge clk) begin
        if (reg_write_en && (write_reg != 5'b0)) begin
            registers[write_reg] <= write_data;
        end
    end

endmodule

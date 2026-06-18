module pc(
    input wire clk,          // Global system clock signal
    input wire rst_n,        // Active-low asynchronous reset signal
    output reg [31:0] pc_out // 32-bit current instruction pointer address
);

    // Sequential block: updates on the rising edge of clock or falling edge of reset
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pc_out <= 32'h0000_0000; // Force address back to 0 on reset
        end else begin
            pc_out <= pc_out + 4;    // Move 4 bytes forward to next instruction
        end
    end

endmodule


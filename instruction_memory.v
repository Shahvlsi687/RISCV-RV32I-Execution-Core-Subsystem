module instruction_memory(
    input wire [31:0] address,       // Input address line coming straight from the PC
    output wire [31:0] instruction  // 32-bit hardware instruction output sent to the Decoder
);

    // Declaring a memory array of 64 slots, each 32 bits wide
    reg [31:0] rom_array [0:63]; 

    // Declare the loop tracking variable at the module level
    integer i;

    // Direct Inline Loading: Safe, robust, and completely independent of Windows paths
    initial begin
        // 1. First fill the entire memory with safe standard NOP instructions
        for (i = 0; i < 64; i = i + 1) begin
            rom_array[i] = 32'h0000_0013; // RISC-V standard NOP instruction
        end

        // 2. Explicitly overwrite the first 3 execution slots with your machine code
        rom_array[0] = 32'h005202B3; // Slot 0: ADD x5, x4, x5  (Calculates: x4 + x5)
        rom_array[1] = 32'h00A30333; // Slot 1: ADD x6, x6, x10
        rom_array[2] = 32'h01438333; // Slot 2: ADD x6, x7, x20
    end

    // WORD ALIGNMENT LOGIC:
    // Shift address right by 2 bits (divide by 4) to step through our array sequentially
    assign instruction = rom_array[address >> 2];

endmodule

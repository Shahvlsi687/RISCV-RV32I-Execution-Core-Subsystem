module top(
    input wire clk,
    input wire rst_n,
    output wire [31:0] execution_result,
    output wire zero_alert
);

    // Internal structural buses
    wire [31:0] pc_to_mem;
    wire [31:0] instruction_bus;
    wire [6:0] opcode;
    wire [4:0] rd, rs1, rs2;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire is_alu_op;
    
    // Control and operational tracking lines
    wire ctrl_reg_write;
    wire [3:0] ctrl_alu_op;
    wire [31:0] reg_data1, reg_data2;

    // 1. Instantiate Program Counter
    pc pc_unit (.clk(clk), .rst_n(rst_n), .pc_out(pc_to_mem));

    // 2. Instantiate Instruction Memory
    instruction_memory mem_unit (.address(pc_to_mem), .instruction(instruction_bus));

    // 3. Instantiate Instruction Decoder
    decoder dec_unit (
        .instruction(instruction_bus), .opcode(opcode), .rd(rd), 
        .rs1(rs1), .rs2(rs2), .funct3(funct3), .funct7(funct7), .is_alu_op(is_alu_op)
    );

    // 4. Instantiate Control Unit Matrix
    control_unit ctrl_unit (
        .opcode(opcode), .funct3(funct3), .funct7(funct7),
        .reg_write_en(ctrl_reg_write), .alu_control(ctrl_alu_op)
    );

    // 5. Instantiate Register File Layer
    register_file reg_file_unit (
        .clk(clk), .reg_write_en(ctrl_reg_write),
        .read_reg1(rs1), .read_reg2(rs2), .write_reg(rd),
        .write_data(execution_result), .read_data1(reg_data1), .read_data2(reg_data2)
    );

    // 6. Instantiate ALU Execution Core
    alu_core alu_unit (
        .alu_in1(reg_data1), .alu_in2(reg_data2), .alu_control(ctrl_alu_op),
        .alu_result(execution_result), .alu_zero_flag(zero_alert)
    );

endmodule

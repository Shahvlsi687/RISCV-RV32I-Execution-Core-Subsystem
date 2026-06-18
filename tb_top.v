`timescale 1ns / 1ps

module tb_top();

    reg clk;
    reg rst_n;
    wire [31:0] execution_result;
    wire zero_alert;

    // Connect our new master top module
    top uut (
        .clk(clk),
        .rst_n(rst_n),
        .execution_result(execution_result),
        .zero_alert(zero_alert)
    );

    // Generate Clock (100MHz)
    always begin
        #5 clk = ~clk;
    end

    initial begin
        clk = 0;
        rst_n = 0; // Hold in reset

        #20;
        rst_n = 1; // Release reset and execute instructions
        
        #100;
        $finish;
    end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2026 03:40:57 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top (
    input  wire        clk,
    input  wire        reset,
    input  wire        branch_taken,
    input  wire        branch_not_taken,
    output wire        branch_prediction
);

    // 32-bit unsigned counters
    reg [31:0] taken_count;
    reg [31:0] not_taken_count;

    // Counter update logic
    always @(posedge clk) begin
        if (reset) begin
            taken_count     <= 32'd0;
            not_taken_count <= 32'd0;
        end else begin
            if (branch_taken) begin
                taken_count <= taken_count + 1;
            end
            if (branch_not_taken) begin
                not_taken_count <= not_taken_count + 1;
            end
        end
    end

    // Prediction logic:
    // 1 = predict taken
    // 0 = predict not taken
    assign branch_prediction = (taken_count > not_taken_count);

endmodule


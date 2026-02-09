`timescale 1ns / 1ps

module branch_predictor (
    input  wire        clk,
    input  wire        reset,

    input  wire        branch_taken,
    input  wire        branch_not_taken,

    output wire        branch_prediction
);

    // 32-bit unsigned counters
    reg [31:0] taken_count;
    reg [31:0] not_taken_count;

    // Update counters on clock edge
    always @(posedge clk) begin
        if (reset) begin
            taken_count      <= 32'd0;
            not_taken_count  <= 32'd0;
        end else begin
            if (branch_taken)
                taken_count <= taken_count + 1;

            if (branch_not_taken)
                not_taken_count <= not_taken_count + 1;
        end
    end

    // Prediction logic:
    // Predict TAKEN if taken_count > not_taken_count
    assign branch_prediction = (taken_count > not_taken_count);

endmodule

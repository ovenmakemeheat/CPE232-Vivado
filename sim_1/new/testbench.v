`timescale 1ns / 1ps

module tb_branch_predictor;

    // Testbench signals
    reg clk;
    reg reset;
    reg branch_taken;
    reg branch_not_taken;

    wire branch_prediction;

    // Instantiate the DUT (Device Under Test)
    branch_predictor dut (
        .clk(clk),
        .reset(reset),
        .branch_taken(branch_taken),
        .branch_not_taken(branch_not_taken),
        .branch_prediction(branch_prediction)
    );

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        branch_taken = 0;
        branch_not_taken = 0;

        // Apply reset
        #10;
        reset = 0;

        // -------------------------
        // Test 1: Branch Taken more often
        // -------------------------
        $display("Test 1: More TAKEN branches");

        repeat (3) begin
            @(posedge clk);
            branch_taken = 1;
            branch_not_taken = 0;
            @(posedge clk);
            branch_taken = 0;
        end

        // -------------------------
        // Test 2: Branch Not Taken more often
        // -------------------------
        $display("Test 2: More NOT TAKEN branches");

        repeat (5) begin
            @(posedge clk);
            branch_not_taken = 1;
            branch_taken = 0;
            @(posedge clk);
            branch_not_taken = 0;
        end

        // -------------------------
        // Test 3: Taken catches up
        // -------------------------
        $display("Test 3: TAKEN catches up");

        repeat (4) begin
            @(posedge clk);
            branch_taken = 1;
            branch_not_taken = 0;
            @(posedge clk);
            branch_taken = 0;
        end

        // -------------------------
        // Test 4: Reset behavior
        // -------------------------
        $display("Test 4: Reset clears counters");

        @(posedge clk);
        reset = 1;
        @(posedge clk);
        reset = 0;

        // Finish simulation
        #20;
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor(
            "Time=%0t | Taken=%b | NotTaken=%b | Prediction=%b",
            $time,
            branch_taken,
            branch_not_taken,
            branch_prediction
        );
    end

endmodule

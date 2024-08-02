`timescale 1ns / 1ps

module biomimetic_pwm_filter_tb();

    // Parameters
    localparam CLK_PERIOD = 10;                  // Clock period in nanoseconds
    localparam COUNTER_WIDTH = 8;                // Counter width matching PWM resolution
    localparam FILTER_WIDTH = 8;                 // Filter data width

    // Testbench signals
    reg clk;                                     // Clock signal
    reg rst_n;                                   // Active-low reset signal
    reg [COUNTER_WIDTH-1:0] duty;                // Duty cycle input for PWM
    wire pwm_out;                                // Output from PWM module
    wire [FILTER_WIDTH-1:0] filtered_out;        // Smoothed output from filter

    // Instantiate the PWM module
    pwm_module #(
        .COUNTER_WIDTH(COUNTER_WIDTH)
    ) pwm_inst (
        .clk(clk),
        .rst_n(rst_n),
        .duty(duty),
        .pwm_out(pwm_out)
    );

    // Instantiate the IIR filter module
    iir_filter #(
        .DATA_WIDTH(FILTER_WIDTH),
        .FRAC_BITS(6)
    ) filter_inst (
        .clk(clk),
        .rst_n(rst_n),
        .pwm_in(pwm_out),
        .filtered_out(filtered_out)
    );

    // Clock generation
    // Emulates the regular heartbeat found in biological systems, driving
    // the synchronous operation of all digital logic components.
    always begin
        clk = 0;
        #(CLK_PERIOD/2);
        clk = 1;
        #(CLK_PERIOD/2);
    end

    // Testbench stimulus and logging
    // Simulates various duty cycle scenarios, akin to varying input stimuli
    // to observe system response, similar to testing sensory systems.
    initial begin
        // Initialize inputs
        rst_n = 0;
        duty = 8'd0;

        // Log initial state
        $display("Time=%t, Reset active, Duty=0", $time);

        // Apply reset
        #(CLK_PERIOD*2);
        rst_n = 1;
        $display("Time=%t, Reset deasserted", $time);

        // Test different duty cycles
        duty = 8'd64;  // 25% duty cycle
        $display("Time=%t, Setting duty cycle to 25%% (64/256)", $time);
        #(CLK_PERIOD*1024);
        
        duty = 8'd128; // 50% duty cycle
        $display("Time=%t, Setting duty cycle to 50%% (128/256)", $time);
        #(CLK_PERIOD*1024);
        
        duty = 8'd192; // 75% duty cycle
        $display("Time=%t, Setting duty cycle to 75%% (192/256)", $time);
        #(CLK_PERIOD*1024);
        
        duty = 8'd255; // ~100% duty cycle
        $display("Time=%t, Setting duty cycle to ~100%% (255/256)", $time);
        #(CLK_PERIOD*1024);

        // End simulation
        $display("Time=%t, Simulation complete", $time);
        $finish;
    end

    // Monitor PWM and filtered outputs
    // This block logs the output to provide insight into the dynamic behavior 
    // of the system, mimicking real-time data collection in experimental biology.
    always @(posedge clk) begin
        $display("Time=%t, Duty=%d, PWM_Out=%b, Filtered_Out=%d", 
                 $time, duty, pwm_out, filtered_out);
    end

endmodule

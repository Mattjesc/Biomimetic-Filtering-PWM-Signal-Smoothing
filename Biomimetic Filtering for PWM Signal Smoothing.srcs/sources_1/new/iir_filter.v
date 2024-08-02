`timescale 1ns / 1ps

module iir_filter #(
    parameter DATA_WIDTH = 8,
    parameter FRAC_BITS = 6
)(
    input wire clk,                                  // Clock input for synchronous operation
    input wire rst_n,                                // Active-low reset signal
    input wire pwm_in,                               // PWM signal input
    output reg [DATA_WIDTH-1:0] filtered_out         // Filtered (smoothed) output signal
);

    // Filter coefficient (ALPHA) chosen to provide appropriate smoothing.
    // Represents a small factor in the IIR filter, inspired by biological
    // signal damping mechanisms like neural response modulation.
    localparam [DATA_WIDTH-1:0] ALPHA = 8'b00000100;

    // Internal signals for previous output and full-scale PWM representation.
    reg [DATA_WIDTH-1:0] prev_output;
    reg [DATA_WIDTH-1:0] pwm_full_scale;

    // IIR filter logic
    // The filter provides smoothing by averaging out rapid changes in the input signal (pwm_in).
    // This is akin to how biological systems often integrate over time to mitigate noise and stabilize responses,
    // e.g., visual systems smoothing out abrupt changes in light to maintain consistent perception.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            filtered_out <= {DATA_WIDTH{1'b0}}; // Reset output to 0
            prev_output <= {DATA_WIDTH{1'b0}};  // Reset previous output to 0
            pwm_full_scale <= {DATA_WIDTH{1'b0}}; // Reset pwm_full_scale to 0
        end else begin
            // Convert PWM input to full-scale value. This transformation 
            // reflects how raw inputs are normalized in biological systems.
            pwm_full_scale <= pwm_in ? {DATA_WIDTH{1'b1}} : {DATA_WIDTH{1'b0}};
            
            // IIR filter equation: y[n] = (1-?)y[n-1] + ?x[n]
            // This represents a simple form of biological filtering, where 
            // current output is a blend of previous state and new input, 
            // balancing persistence and sensitivity to change.
            filtered_out <= prev_output - ((prev_output * ALPHA) >> FRAC_BITS) + ((pwm_full_scale * ALPHA) >> FRAC_BITS);
            prev_output <= filtered_out;
        end
    end

endmodule

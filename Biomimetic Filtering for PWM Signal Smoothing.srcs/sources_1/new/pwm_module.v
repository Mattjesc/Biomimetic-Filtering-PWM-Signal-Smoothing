`timescale 1ns / 1ps

// pwm_module: This module generates a PWM signal based on the specified duty cycle.
// The concept mimics natural biological processes where signals are modulated to 
// control various functions, akin to how organisms regulate processes through 
// varying levels of biological signals.

module pwm_module #(
    parameter COUNTER_WIDTH = 8
)(
    input wire clk,                           // Clock input for synchronous operations
    input wire rst_n,                         // Active-low reset signal
    input wire [COUNTER_WIDTH-1:0] duty,      // Duty cycle input, representing the high-time proportion in a PWM cycle
    output reg pwm_out                        // PWM output signal
);

    // Internal counter to track the PWM cycle position
    reg [COUNTER_WIDTH-1:0] counter;

    // Counter logic
    // At every clock cycle, the counter increments. On reset (rst_n), it resets to 0.
    // This process is similar to rhythmic patterns found in biological systems,
    // where cycles and oscillations are fundamental.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= {COUNTER_WIDTH{1'b0}}; // Reset counter to 0
        end else begin
            counter <= counter + 1'b1;        // Increment counter
        end
    end

    // PWM output logic
    // The output pwm_out is set high if the counter is less than the duty cycle.
    // This mechanism emulates how biological systems vary signal intensity 
    // (e.g., hormone levels) to achieve different functional outcomes.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pwm_out <= 1'b0;                  // Reset PWM output to 0
        end else begin
            pwm_out <= (counter < duty) ? 1'b1 : 1'b0; // Set PWM output based on duty cycle
        end
    end

endmodule

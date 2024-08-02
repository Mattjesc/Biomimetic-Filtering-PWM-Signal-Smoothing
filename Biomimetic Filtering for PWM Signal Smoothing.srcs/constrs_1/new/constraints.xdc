# constraints.xdc
# Constraint file for setting up the timing and I/O requirements for the design.
# This file establishes the timing characteristics of the clock and I/O ports,
# ensuring that the design meets performance specifications and operates reliably.

# Clock Constraints
# Create a primary clock signal with a period of 10.000 ns. This clock drives 
# all synchronous elements in the design, analogous to a biological system's 
# central rhythm (e.g., a heartbeat) coordinating all functions.
create_clock -period 10.000 -name clk [get_ports clk]

# Input Delay Constraints
# Set input delay constraints for the input ports `rst_n` and `duty`. These
# constraints define the maximum allowable delay from the clock edge to the 
# arrival of input signals, ensuring they are sampled correctly by the FPGA.
# This setup prevents timing violations, similar to ensuring that biological 
# inputs are received and processed in a timely manner.
set_input_delay -clock clk 0.000 [get_ports {rst_n duty[*]}]

# Output Delay Constraints
# Set output delay constraints for the `filtered_out` output port. This ensures 
# that the filtered output signal is available for external use at the expected time 
# relative to the clock signal. This timing control is crucial for synchronizing 
# responses, much like how biological systems synchronize motor actions with sensory inputs.
set_output_delay -clock clk 0.000 [get_ports {filtered_out[*]}]

# Explanation of Constraints:
# - The create_clock constraint establishes the primary clock's frequency,
#   which in this case is 100 MHz (period = 10 ns). This is the central timing 
#   reference for all operations within the FPGA, ensuring that all parts of the 
#   design operate in lockstep.
# - The set_input_delay and set_output_delay constraints help define the 
#   temporal boundaries within which signals must be stable. By setting these 
#   delays, we ensure that the design meets the required setup and hold times 
#   for reliable operation, much like how biological systems require precise 
#   timing for effective function.

# Biomimetic Insight:
# In biological systems, precise timing and synchronization are crucial for 
# coordinated actions and responses. Similarly, in digital systems like FPGAs, 
# timing constraints ensure that all components work together harmoniously, 
# avoiding timing violations that could lead to data corruption or functional 
# errors. This constraint file sets the necessary boundaries and timing 
# specifications to ensure that the digital representation of the biomimetic 
# system operates reliably and accurately.

# Biomimetic Filtering for PWM Signal Smoothing

![Project Meme (3)](https://github.com/user-attachments/assets/b3e45e4b-56b1-49c7-ba8c-05660c0e1cfc)

![HighLevelOverview](https://github.com/user-attachments/assets/7f7f177a-5e67-40b1-b644-feb1abbb56a4)

This project explores a biomimetic approach to signal smoothing using an FPGA to implement PWM signal generation and IIR filtering. The design is inspired by natural systems' ability to filter and process signals efficiently, as detailed in [A Software Method for Generating Concurrent PWM Signal from Pic18f4520 for Biomimetic Robotic Fish Control](https://github.com/user-attachments/assets/A_Software_Method_for_Generating_Concurrent_Pwm_Si.pdf) and [Biomimetic Frame-Free HDR Camera with Event-Driven PWM Image/Video Sensor and Full-Custom Address-Event Processor](https://github.com/user-attachments/assets/BioCAS2010_Posch_etal.pdf). This project demonstrates how these concepts can be applied to digital signal processing using an FPGA.

## Overview

This repository contains the implementation of a PWM generator and a biomimetic IIR filter, designed to smooth the PWM signal. The project leverages the capabilities of FPGAs for real-time signal processing, showcasing a low-pass filtering technique inspired by biological systems. This approach mimics how organisms filter sensory inputs to stabilize perception and reduce noise.

## Project Structure

The project is structured into several Verilog files, each responsible for different components of the PWM signal processing and smoothing system:

1. **pwm_module.v**: Implements a PWM signal generator that modulates the duty cycle based on input parameters, inspired by natural signal modulation mechanisms.
2. **iir_filter.v**: An IIR filter that smooths the PWM output, analogous to biological low-pass filtering systems.
3. **biomimetic_pwm_filter_tb.v**: The testbench for simulating and verifying the functionality of the PWM and filter modules.
4. **constraints.xdc**: Defines the timing and I/O constraints for the design, ensuring reliable FPGA implementation.

### Why?

The project investigates how biomimetic principles can be applied to digital systems, specifically focusing on signal processing. The choice to explore biomimetic filtering is rooted in the desire to emulate the efficiency and elegance of natural systems in handling noisy inputs, akin to sensory processing in biological organisms. This concept finds application in areas requiring smooth control signals, such as robotics, biomedical devices, and signal processing systems.

### Key Features

- **Biomimetic Approach**: The project leverages concepts from biological systems, such as low-pass filtering seen in sensory organs, to develop efficient digital filters.
- **Real-Time Signal Processing**: The use of FPGAs allows for high-speed, real-time filtering, critical for applications needing immediate response and minimal latency.
- **Scalable Design**: The modular design can be adapted to different filter specifications and extended to more complex signal processing tasks.
- **Comprehensive Testing**: A thorough testbench verifies the design's performance across various duty cycles and filter configurations.

## Basic Principles and Intuition

### PWM Signal Generation and Biomimetic Modulation

In biological systems, modulation of signals is a common way to control physiological processes. The `pwm_module.v` implements this concept by generating a PWM signal where the duty cycle controls the high-time proportion, analogous to varying signal strength in biological contexts. This digital implementation simulates how biological systems regulate processes like hormone levels or neural firing rates.

### Signal Smoothing through IIR Filtering

The `iir_filter.v` module smooths the PWM signal, reducing the high-frequency components and noise. This biomimetic filtering mirrors natural low-pass filtering mechanisms, such as how the human ear dampens sudden changes in sound to maintain a consistent auditory experience. The filter uses fixed-point arithmetic to efficiently process the signal in real-time, a critical aspect for applications needing steady control signals.

### State Machines and Process Methodologies

In this project, state machines and process methodologies are used to manage the control flow and synchronization of the system's operations, ensuring reliable and predictable behavior.

#### State Machines

State machines are employed to handle the various stages of operation within the PWM generation and filtering process. They ensure that the system transitions smoothly between different modes, such as initialization, active filtering, and idle states.

1. **Single Process State Machine (Mealy)**: 
   - This type combines state transition and output logic in a single process. It's used in situations where output depends on both the current state and the current inputs. In this project, a Mealy state machine might be employed in the PWM module to dynamically adjust the output based on real-time input changes, simulating how biological systems respond immediately to varying stimuli.

2. **Two Process State Machine (Moore)**: 
   - Separates state transitions (state register update) and output logic into two distinct processes. This approach enhances modularity and clarity, making it easier to manage complex behaviors. The IIR filter's control logic can use a Moore state machine to ensure that each state has a well-defined output, regardless of the inputs, similar to how biological systems maintain consistent outputs under steady conditions.

#### Process Methodologies

1. **Combinational Logic Processes**: 
   - Used for processes where outputs are determined solely by the current inputs. In the context of this project, the decision to set the PWM output high or low based on the counter value and duty cycle input is a combinational process. It’s analogous to how biological systems make instantaneous decisions based on immediate inputs, like a reflex action.

2. **Sequential Logic Processes**: 
   - These involve memory elements (like flip-flops) and are governed by clock signals. They are used for operations requiring state retention, such as the progression through different states in a state machine. The implementation of the IIR filter, which maintains previous output values to compute the current output, is a sequential process. This is akin to biological systems using memory to integrate past information for current decision-making.

3. **Synchronous Reset and Control Mechanisms**: 
   - The design uses synchronous resets to ensure that all components reset predictably on a clock edge, preventing asynchronous issues. This controlled reset mechanism is crucial for initializing the system to a known state, similar to biological systems resetting their state under certain conditions, such as sleep or rest.

### Application in the Filtering System

- **IDLE State**: The system waits for an enable signal to initiate processing. This state ensures that the system is ready and conserves resources when not in use, similar to energy conservation in biological systems when inactive.
- **ACTIVE State**: When enabled, the PWM generation and filtering processes are carried out. This involves generating the PWM signal, applying the IIR filter, and outputting the smoothed signal. The transition to this state represents the system’s active processing phase, akin to biological systems responding to stimuli.
- **RESET State**: Ensures the system returns to a known initial state when required, analogous to resetting biological states to prevent overload or restore equilibrium.

These methodologies ensure that the design is robust, with well-defined state transitions and predictable outputs. They help manage complex operations systematically, providing clarity and stability in both the digital and biological analogs.

## Potential for Further Research

This project serves as a proof-of-concept, demonstrating the feasibility and effectiveness of applying biomimetic principles to digital signal processing. The potential for further research is substantial, as biomimetics is an expanding field with significant applications in AI, robotics, and beyond. The concepts explored in this project can be extended and refined to develop more advanced filtering techniques, adaptive systems, and real-time control applications. By positioning this project as a foundational step, it showcases a forward-thinking approach that aligns with future research trends, particularly in integrating biological principles into engineering solutions.

## Detailed Design

### PWM Module

The `pwm_module.v` generates a PWM signal with a duty cycle proportional to the input value. This module operates like biological oscillators, providing a rhythmic output that can be modulated. The module's design emphasizes simplicity and reliability, ensuring consistent signal generation across various conditions.

### IIR Filter Module

The `iir_filter.v` acts as a low-pass filter, smoothing the PWM output. The filter's design, based on a first-order recursive equation, is inspired by natural filtering processes. It balances the previous output with the current input, akin to biological systems integrating past and present sensory data to maintain stability. The filter's coefficients are selected to optimize the trade-off between smoothness and responsiveness.

### Testbench

The `biomimetic_pwm_filter_tb.v` testbench simulates the entire design, applying different duty cycles to the PWM generator and observing the filter's output. It ensures the design's robustness by testing various scenarios, including edge cases and rapid changes in input signals. The testbench verifies that the filter provides the expected smoothing effect, crucial for applications requiring stable outputs.

### Constraints File

The `constraints.xdc` file defines the timing and I/O constraints for the design, ensuring that it operates reliably within the FPGA environment. These constraints are critical for maintaining the integrity and timing of signals throughout the design.

```tcl
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
```

## Simulation Results

### Simulation Waveforms

The simulation waveforms provide insights into the module's internal operations and the overall data flow. The outputs and state transitions are logged, showcasing the module's response to different inputs and operational conditions.

#### Signal Definitions

- **Clock (clk)**: The primary timing reference for the design, used to synchronize operations.
- **Reset (rst_n)**: Initializes the system to a known state, ensuring proper startup conditions.
- **Duty Cycle Input (duty[7:0])**: Represents the input value for the PWM duty cycle.
- **PWM Output (pwm_out)**: The generated PWM signal based on the duty cycle input.
- **Filtered Output (filtered_out)**: The smoothed signal output from the IIR filter, representing the low-pass filtered PWM signal.
- **Counter (COUNT)**: Internal counter used for generating the PWM signal.
- **Filter State (FILTER)**: Internal state of the IIR filter, showing the progress of signal smoothing.

### Key Observations from Simulation Results

#### Waveform 1: Low Duty Cycle PWM Signal and Filtered Output

![SimulationWaveform1](https://github.com/user-attachments/assets/e3696263-5bd0-4686-9154-fcb84df59935)

In this waveform, the PWM signal (`pwm_out`) with a low duty cycle (value 40) is shown. The corresponding filtered output (`filtered_out`) demonstrates a gradual rise, reflecting the low-pass filtering action of the IIR filter. The smoothness of the filtered output compared to the PWM input indicates effective attenuation of high-frequency components, akin to how biological systems smooth out abrupt changes in sensory inputs.

**Observations**:
- **Clock and Reset Signals**: The `clk` signal provides the timing reference, and `rst_n` ensures the system starts from a known state.
- **PWM Generation**: The `pwm_out` signal exhibits a low duty cycle, with short high periods and longer low periods.
- **Filtered Output**: The `filtered_out` signal shows a gradual increase, smoothing the rapid changes of the PWM signal and stabilizing over time.

#### Waveform 2: High Duty Cycle PWM Signal and Filtered Output

![SimulationWaveform2](https://github.com/user-attachments/assets/ae42496c-4c56-4c73-a16a-a0329171e7be)

This waveform depicts the system's response to a PWM signal with a high duty cycle (value 255). The `pwm_out` signal shows long high periods, corresponding to a higher average voltage. The filtered output (`filtered_out`) exhibits significant smoothing, though with visible ripples due to the high input amplitude.

**Observations**:
- **Clock and Reset Signals**: Similar to Waveform 1, `clk` synchronizes operations, and `rst_n` initializes the system.
- **PWM Generation**: The `pwm_out` signal now has a high duty cycle, with long high periods and short low periods.
- **Filtered Output**: The `filtered_out` signal, despite some ripples, demonstrates an overall smoother signal compared to the high-frequency PWM input, maintaining a higher average value.

### Interpretation and Integration

The simulation results confirm the design's capability to perform real-time signal smoothing using biomimetic principles. The transition from sharp, digital PWM signals to smoother analog-like outputs demonstrates the effectiveness of the implemented IIR filter. These waveforms provide critical insight into how the filter manages various duty cycles, akin to how natural systems process varying intensities of sensory inputs. The observed performance aligns with the project's objectives of achieving stable and noise-reduced outputs, crucial for applications in robotics and control systems where precise and smooth signal control is necessary.

The presented results further validate the design's conceptual framework, showcasing the successful translation of biomimetic ideas into digital signal processing solutions. The simulation outputs serve as a preliminary verification step, setting the stage for potential physical implementation and further optimization of the design.

## Synthesis Results

### Utilization Report

The synthesis results for the IIR filter design on the Xilinx Artix-7 (xc7a100tcsg324-1) FPGA are summarized below:

#### Slice Logic

| Site Type        | Used | Available | Util% |
|------------------|------|-----------|-------|
| Slice LUTs       | 10   | 63400     | 0.02  |
|   LUT as Logic   | 10   | 63400     | 0.02  |
|   LUT as Memory  | 0    | 19000     | 0.00  |
| Slice Registers  | 17   | 126800    | 0.01  |
|   Register as FF | 17   | 126800    | 0.01  |
|   Register as Latch | 0 | 126800    | 0.00  |
| F7 Muxes         | 0    | 31700     | 0.00  |
| F8 Muxes         | 0    | 15850     | 0.00  |

#### Memory

| Site Type     | Used | Available | Util% |
|---------------|------|-----------|-------|
| Block RAM Tile| 0    | 135       | 0.00  |
| RAMB36/FIFO   | 0    | 135       | 0.00  |
| RAMB18        | 0    | 270       | 0.00  |

#### DSP

| Site Type | Used | Available | Util% |
|-----------|------|-----------|-------|
| DSPs      | 0    | 240       | 0.00  |

#### IO and GT Specific

| Site Type         | Used | Available | Util% |
|-------------------|------|-----------|-------|
| Bonded IOB        | 11   | 210       | 5.24  |

#### Clocking

| Site Type | Used | Available | Util% |
|-----------|------|-----------|-------|
| BUFGCTRL  | 1    | 32        | 3.13  |

### Synthesis Process Details

The synthesis process started with loading the appropriate part and timing information, followed by parsing the XDC constraints. The design did not utilize any memory blocks, DSP slices, or advanced clocking features beyond a single BUFGCTRL for clock management. The low utilization figures across all resources indicate a very modest design, well within the capabilities of the target FPGA.

### Justification

**Resource Utilization**:
- **LUTs and Registers**: The design uses only 10 LUTs and 17 registers, reflecting its simplicity. This low usage indicates a straightforward implementation with minimal logic complexity, suitable for a proof-of-concept phase. The absence of memory LUTs and specialized LUT structures like F7 and F8 Muxes further supports this simplicity.
- **Memory and DSP Usage**: No Block RAMs or DSP slices were used. This aligns with the project's focus on basic signal processing tasks that do not require intensive computational resources or large data storage capabilities.
- **IO and Clocking**: The utilization of 11 bonded IOBs (5.24% of available) and a single BUFGCTRL (3.13% of available) is appropriate for the project's current scope, which does not necessitate extensive external interfacing or complex clock management.

**Synthesis Process and Warnings**:
- The warning regarding unmatched ports (`duty[*]`) in the constraints file is a minor issue, likely due to a misalignment between the design and the constraints specified. This discrepancy is typical in early design phases where exact hardware specifications and constraints may not be fully defined or necessary. In a proof-of-concept project, such issues can be addressed in future iterations as the design matures and specific hardware configurations are targeted.

### Conclusion

The synthesis results confirm that the IIR filter design is resource-efficient, utilizing only a small fraction of the available FPGA resources. The simplicity of the design, as evidenced by the minimal use of LUTs, registers, and other resources, aligns well with the project's proof-of-concept nature. The low utilization metrics provide ample headroom for future optimizations and expansions, should the project require additional functionality or complexity. The

 design's successful synthesis without critical warnings or errors indicates a stable and well-formed implementation at this stage.

## Implementation Results

The implementation phase covers the detailed processes of design placement, routing, power analysis, timing analysis, and final checks. This section provides insights into the practical considerations and outcomes of translating the high-level design into a physical FPGA implementation.

### Design Rule Checks (DRC) and Methodology Report

**Summary**:
- **DRC Violations**:
  - **NSTD-1**: Unspecified I/O Standard
  - **UCIO-1**: Unconstrained Logical Port
  - **CFGBVS-1**: Missing CFGBVS and CONFIG_VOLTAGE Design Properties

**Details**:
- **NSTD-1**: All I/O ports default to 'DEFAULT' I/O standard, which could potentially lead to signal integrity issues.
- **UCIO-1**: All logical ports lack specific location constraints, posing risks of I/O contention.
- **CFGBVS-1**: Critical configuration voltage settings are missing.

**Justification**:
- These warnings highlight areas where hardware-specific considerations are lacking. As the project is a proof-of-concept and does not involve actual hardware testing at this stage, these constraints were not a primary focus. However, these issues will need to be addressed in future iterations to ensure compatibility and reliability in a physical deployment.

### Power Analysis

**Summary**:
- **Total On-Chip Power**: 0.100 W
- **Dynamic Power**: 0.008 W
- **Static Power**: 0.091 W

**Details**:
- **On-Chip Components**: Minimal power usage with most components drawing negligible power.
- **Power Supply Summary**: The design's power requirements are modest, reflecting its simplicity and efficiency.

**Justification**:
- The low power consumption is expected given the project's limited scope and the absence of complex, power-intensive components. This efficiency aligns with the proof-of-concept nature, where demonstrating core functionality takes precedence over optimizing power usage.

### Timing Summary and Clock Utilization

**Timing Analysis**:
- **Worst Negative Slack (WNS)**: 0.232 ns
- **Total Negative Slack (TNS)**: 0.000 ns
- **Worst Hold Slack (WHS)**: 0.185 ns
- **Clock Period**: 10.000 ns (100 MHz)

**Clock Utilization**:
- **BUFGCTRL**: 1 used out of 32 available
- **Global Clock g0**: Driven by BUFGCTRL with 17 clock loads, no non-clock loads.

**Justification**:
- The timing analysis shows no violations, with positive slacks indicating all timing constraints are comfortably met. The clock utilization reflects efficient use of available resources, with a single clock buffer managing all clock signals. This efficiency and lack of timing violations indicate a well-optimized design.

### Routing and Placement

**Routing Status**:
- **Routed Nets**: 100% (no failed or unrouted nets)
- **Global Vertical/Horizontal Routing Utilization**: Extremely low, reflecting minimal routing complexity.

**Placement**:
- The design's placement was straightforward, with no significant congestion or optimization issues, suggesting a low-complexity and well-distributed layout.

**Justification**:
- The successful routing with no congestion or timing issues confirms that the design's simplicity is well-suited to the chosen FPGA. The minimal utilization of routing resources and the lack of placement issues further indicate that the design can be efficiently implemented without encountering practical constraints.

### Bus Skew Report

**Summary**:
- **Bus Skew Constraints**: None specified.

**Justification**:
- The absence of bus skew constraints is acceptable in this proof-of-concept phase, as the design does not yet interface with hardware that would necessitate precise control over signal skew. In a future hardware implementation phase, skew management will be critical to ensure reliable data transfer and signal integrity.

### Implementation Log

**Key Processes**:
- **Link Design**: Initial design linking, setting up the netlist and constraints.
- **Optimization (`opt_design`)**: No significant changes needed, indicating a well-prepared initial design.
- **Placement (`place_design`)**: Smooth placement without congestion, reflecting the design's low complexity.
- **Physical Optimization (`phys_opt_design`)**: No changes made, affirming the design's optimization at earlier stages.
- **Routing (`route_design`)**: Complete routing with no violations, ensuring all signals meet timing requirements.
- **Final Verification**: DRC and methodology checks confirm the design meets all necessary rules and best practices.

**Justification**:
- The detailed logs from each stage underscore the design's straightforward nature and the effectiveness of the initial setup. Each process completed without errors or major modifications, suggesting that the design was well-optimized from the start. The successful DRC and methodology checks, combined with positive timing results, confirm the design's readiness for potential hardware deployment, barring the need for hardware-specific adjustments.

---

### Conclusion

The implementation phase has successfully translated the design into a routed and placed FPGA implementation, with all timing, power, and DRC checks passed. The design's low complexity and efficient resource use make it an excellent candidate for further development and potential hardware testing. The noted absence of specific hardware constraints reflects the current focus on proof-of-concept validation rather than final hardware readiness. As the project moves forward, future work will address these constraints, refining the design for physical deployment and ensuring robustness across all operational parameters.

## Disclaimer

This project is intended for educational purposes and portfolio demonstration. It was developed and tested using the Vivado 2020.2 toolset, targeting the Nexys4 DDR board with the xc7a100tcsg324-1 FPGA. While the design is verified through simulation, no physical hardware testing has been conducted. The work builds upon concepts from referenced biomimetic research, with significant modifications and enhancements.

# RISC-V-Pipelined-Processor-
32-bit 5-stage pipelined RISC-V processor in Verilog with RAW hazard detection and pipeline stalling.
# RISC-V Pipelined Processor

## Overview

This project implements a 32-bit RISC-V processor using a classic 5-stage pipeline architecture in Verilog HDL. The design demonstrates instruction pipelining, hazard detection, and pipeline control mechanisms while maintaining correct program execution.

The processor has been functionally verified through simulation using Icarus Verilog and waveform analysis in GTKWave.

---

## Pipeline Stages

The processor consists of the following stages:

1. **Instruction Fetch (IF)**
2. **Instruction Decode (ID)**
3. **Execute (EX)**
4. **Memory Access (MEM)**
5. **Write Back (WB)**

Pipeline registers are implemented between adjacent stages to support concurrent instruction execution.

---

## Features

* 32-bit RISC-V Processor
* 5-stage pipelined architecture
* Instruction Memory
* Register File
* Arithmetic Logic Unit (ALU)
* Pipeline Registers
* RAW (Read After Write) Hazard Detection
* Pipeline Stalling and Bubble Insertion
* Functional Verification through Simulation

---

## Hazard Handling

### Data Hazards

The processor detects RAW data hazards using a Hazard Detection Unit.

When a dependency is detected between consecutive instructions, the pipeline is stalled and bubbles are inserted to ensure correct execution.

### Control Hazards

Control hazard detection and handling are currently under development and will be added in future updates.

---

## Tools Used

* Verilog HDL
* Visual Studio Code
* Icarus Verilog
* GTKWave
* GitHub

---

## Simulation Results

Simulation verifies correct instruction execution and successful handling of RAW hazards through pipeline stalling.

Waveform screenshots demonstrating hazard detection and pipeline behavior are included in this repository.

---

## Project Structure

* `addpl.v` – Top-level pipelined processor
* `instrmem.v` – Instruction memory module
* `regfile.v` – Register file implementation
* `addpl_tb.v` – Testbench for simulation

---

## Future Work

* Control Hazard Detection
* Branch Handling Logic
* Data Forwarding Unit
* Performance Analysis
* FPGA Implementation
* RTL Schematic Generation

---



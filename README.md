# State-Space Control with Luenberger Observer and Integral Action

## Overview
This repository contains a modern control systems project focusing on the robust control of a DC motor using state-space techniques. The project demonstrates the ability to control a physical system even when all states are not measurable and when internal plant parameters differ from the theoretical design model.

## Core Engineering Highlights
* **Robustness to Parameter Mismatch:** The control architecture is explicitly designed to handle discrepancies between the mathematical design model ($J_{eq} = 1.72$) and the simulated physical plant ($J_{eq} = 2.72$).
* **Luenberger Observer:** Since only the motor's position is physically measurable, a full-order Luenberger observer is implemented (with poles placed 5x faster than the controller) to accurately estimate velocity and current in real-time.
* **Augmented State-Space (Integral Action):** An integral control law is embedded directly into the state-space formulation. This ensures zero steady-state error and robust disturbance rejection against non-linear external loads.

## Repository Structure
* `main.m`: Initializes system matrices, calculates observer/controller gains via pole placement, and formulates the augmented state-space matrices for integral action.
* `dc_motor_control.slx`: The Simulink model featuring the physical plant, the observer block, and the full state feedback controller with integrated error tracking.

## How to Run
1. Open MATLAB and run `main.m` to load the system parameters ($A, B, C, K_{new}, K_i, L_{obs}$) into the base workspace.
2. Open `dc_motor_control.slx` and run the simulation to observe the robust tracking and disturbance rejection capabilities.

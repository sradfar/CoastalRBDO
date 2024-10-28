# Reliability-Based Design Optimization of Rubble Mound Breakwater

This repository contains MATLAB code developed for the PhD dissertation titled **"Reliability-based design optimization of a conventional rubble mound breakwater considering the correlation between environmental variables."** The code utilizes the UQLab framework to perform reliability-based design optimization (RBDO) for a rubble mound breakwater, incorporating probabilistic modeling, environmental variable correlations, and optimization constraints.

## Project Overview

The goal of this project is to optimize the design of a rubble mound breakwater to achieve a balance between structural reliability and cost-effectiveness, while accounting for uncertainties in environmental variables. The methodology integrates reliability analysis, cost estimation, and constraint handling to ensure the optimized design meets target failure probabilities.

## Features

- **Reliability-Based Design Optimization (RBDO)**: Implements RBDO using UQLab with two methods - Quantile Monte Carlo (QMC) with Interior Point (IP) optimization and Reliability Index Approach (RIA).
- **Probabilistic Modeling of Design and Environmental Variables**: Defines Gaussian and Lognormal distributions for breakwater parameters and environmental variables.
- **Limit State and Soft Constraints**: Includes limit state functions and soft constraints for structural requirements.
- **Cost Function with Penalty Terms**: Calculates construction cost while applying penalty terms for failure probabilities exceeding target thresholds.

## Files and Functions

1. **uq_Ex02_RubBreakwat.m**: Main file that initializes UQLab, defines the probabilistic input model, and sets up the RBDO analysis.
2. **uq_Ex02_RubBreakwat_constraint.m**: Defines the limit state function for the breakwater's structural constraints.
3. **uq_Ex02_RubBreakwat_cost.m**: Cost function calculation for construction, incorporating penalties for overtopping, armor instability, and toe erosion failures.
4. **uq_Ex02_RubBreakwat_SoftCon.m**: Soft constraints applied to design variables.
5. **EvalPf.m**: Evaluates failure probabilities for various design scenarios using Monte Carlo simulation.
6. **AllCorrr.csv**: Correlation matrix for the environmental variables, used for probabilistic modeling.

## Usage Instructions

1. **Initialize UQLab**: Ensure UQLab is installed and initialized in MATLAB before running any scripts.

   uqlab

2. **Run the Main Script**:
   - Execute `uq_Ex02_RubBreakwat.m` to start the RBDO process, including defining the model, probabilistic input, limit states, cost, and optimization parameters.

3. **Analyze the Results**:
   - Results are displayed via `uq_print` and `uq_display`, showing the optimized design parameters, failure probabilities, and cost.

## Requirements

- **MATLAB**: This code is written for MATLAB.
- **UQLab**: UQLab framework is required for reliability-based design optimization. [UQLab Installation Guide](https://www.uqlab.com/installation).

## Developer

Developed by **Soheil Radfar**  
Email: [soheil.radfar92@gmail.com](mailto:soheil.radfar92@gmail.com)

## License

This project is licensed under the MIT License.

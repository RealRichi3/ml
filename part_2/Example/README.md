# Project Overview: Remaining Useful Life Estimation Using Deep Learning

## Introduction

This project focuses on the estimation of Remaining Useful Life (RUL) for complex systems (such as engines or lenses) using deep learning techniques, specifically Convolutional Neural Networks (CNNs). RUL estimation is a cornerstone of predictive maintenance, enabling organizations to anticipate failures, schedule maintenance efficiently, and reduce operational costs.

The system is inspired by and closely follows the methodology presented in the MATLAB example ["Remaining Useful Life Estimation Using Convolutional Neural Network"](https://uk.mathworks.com/help/predmaint/ug/remaining-useful-life-estimation-using-convolutional-neural-network.html) and the associated research literature.

## What is Remaining Useful Life (RUL)?

RUL is the predicted time (or cycles) remaining before a system or component fails. Accurate RUL predictions allow for proactive maintenance, minimizing downtime and preventing unexpected breakdowns.

## Project Goals

- To implement a data-driven, deep learning-based approach for RUL estimation.
- To demonstrate the workflow on real-world-like datasets (e.g., turbofan engine, lens degradation).
- To provide reusable code and a clear methodology for adapting the approach to other domains.

## System Components

### 1. Data

The project uses time-series datasets that record the degradation of systems over time. Example datasets include:
- **Turbofan Engine Degradation Simulation Data:** Simulated run-to-failure data for multiple engines, with sensor readings and operational settings.
- **Lens Degradation Data:** (If provided) Similar structure, adapted for lens health monitoring.

Each dataset typically includes:
- Unit/engine/lens identifier
- Timestamp or cycle number
- Operational settings
- Multiple sensor measurements

### 2. Preprocessing

Key preprocessing steps include:
- **Feature Selection:** Removing features with little or no variability.
- **Normalization:** Standardizing features to zero mean and unit variance.
- **Response Clipping:** Limiting RUL values to a maximum threshold to focus on the critical degradation phase.
- **Sequence Handling:** Sorting and padding sequences to handle variable lengths for batch processing.

### 3. Model Architecture

The core of the system is a 1-D Convolutional Neural Network (CNN) designed for time-series regression:
- **Input:** Sequences of sensor data.
- **Layers:** Multiple convolutional layers (with batch normalization and ReLU activations), followed by fully connected and dropout layers.
- **Output:** A single value representing the predicted RUL.

### 4. Training and Evaluation

- **Training:** The model is trained using the Adam optimizer and mean squared error (MSE) loss.
- **Evaluation:** Performance is measured using root mean squared error (RMSE) and visualized with plots comparing predicted and true RUL.

### 5. Helper Functions

- `localLoadData.m`: Loads and structures the data for each unit.
- `localLambdaPlot.m`: Plots predicted vs. true RUL for a selected unit.
- `examplecode.m`: Main script for data loading, preprocessing, model training, prediction, and evaluation.

## Workflow

1. **Prepare Data:** Place the relevant data files in the designated folder (e.g., `Example/`).
2. **Run Preprocessing:** Use the provided scripts to clean and prepare the data.
3. **Train Model:** Execute the main script to train the CNN on the training data.
4. **Evaluate Model:** Generate predictions on the test set and assess performance using RMSE and plots.
5. **Visualize Results:** Use helper functions to visualize RUL predictions for individual units.

## Project Structure 
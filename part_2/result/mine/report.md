# 📊 Results and Discussion

## Sensor Signal Plots
- Each channel (sensor) shows time series degradation signals.
- The signals are noisy but have underlying degradation patterns.
- Some channels show more variation than others.
- **Interpretation**: Feature selection is important to remove low-variability signals and focus on informative features.

## CNN Model Architecture Diagram
- Model architecture consists of:
  - Sequence input layer
  - Multiple 1D convolutional layers
  - Batch normalization layers
  - ReLU activations
  - Fully connected layer for regression output
- **Interpretation**: The CNN is designed to learn local temporal features, which is appropriate for time-series RUL prediction.

## RMSE Distribution
- Mean RMSE: **37.65** cycles.
- Standard deviation: **14.62** cycles.
- Some engines were predicted accurately; others had higher errors.
- **Interpretation**: While the model performs moderately well, it shows variability across different test cases, suggesting room for improvement in generalization.

## Predicted vs True RUL (Random, Best, Worst, and Average Cases)

### Random Case
- Prediction follows a roughly linear trend.
- True RUL shows nonlinear degradation.
- **Interpretation**: The model fails to capture nonlinearity effectively in some cases.

### Best Case
- Prediction closely follows the true RUL.
- **Interpretation**: The model can perform very well when the degradation is smooth and gradual.

### Worst Case
- Large mismatch between predicted and true RUL.
- **Interpretation**: The model struggles with engines that degrade in sudden or irregular patterns.

### Average Case
- Prediction trend is moderately good, with some deviations.
- **Interpretation**: The model captures general degradation trends but misses finer details, especially near failure.

## Training Progress
- RMSE and loss curves show steady decrease during training.
- No major fluctuations, indicating **stable convergence**.
- RMSE stabilizes around **20–25** during training.
- **Interpretation**: Training was successful and stable. No major signs of overfitting based on training curves (although validation results are not shown).

---

# 🔥 Overall Summary

| Aspect                  | Observation                                 | Interpretation                                             |
|:------------------------|:-------------------------------------------|:-----------------------------------------------------------|
| Sensor data              | Noisy but informative                      | Feature selection helps improve model focus               |
| Model architecture       | Simple CNN                                | Good for local patterns, but limited for long-term trends  |
| RMSE distribution        | Mean ~37.65, SD ~14.62                    | Moderate accuracy; variable across engines                |
| Best case performance    | Very accurate                             | Model performs well for smooth degradation patterns       |
| Worst case performance   | Poor tracking                             | Struggles with sudden or nonlinear failures                |
| Training behavior        | Smooth convergence                        | Training is stable and effective                          |

---

# 📈 Key Points for Discussion

- **Model Performance**: 
  - The CNN model captures general degradation behavior but fails in highly nonlinear degradation cases.
- **Limitations**: 
  - CNN without recurrent or attention mechanisms struggles to model long-term dependencies.
- **Potential Improvements**:
  - Add LSTM or GRU layers to capture long-term trends.
  - Use attention mechanisms to focus on critical time regions.
  - Explore deeper or hybrid CNN-LSTM models.
  - Apply more sophisticated feature engineering and augmentation.
- **Training Quality**:
  - Training process is effective, showing consistent decrease in error.
  - Validation with a separate dataset would help confirm generalization.

---



# 📏 Model Evaluation Metrics for Remaining Useful Life (RUL) Prediction

This document outlines the key metrics and reporting structure for evaluating the performance of RUL prediction models, such as the CNN-based approach used in this project.

---

## 1. Key Metrics to Consider

### a. Root Mean Squared Error (RMSE)
- **Definition:** Measures the average magnitude of the prediction error (in cycles).
- **Formula:**  
  \[
  \text{RMSE} = \sqrt{\frac{1}{N} \sum_{i=1}^{N} (y_{\text{true},i} - y_{\text{pred},i})^2}
  \]
- **Interpretation:** Lower RMSE indicates better predictive accuracy.

### b. Mean Absolute Error (MAE)
- **Definition:** Average of the absolute differences between predicted and true RUL.
- **Formula:**  
  \[
  \text{MAE} = \frac{1}{N} \sum_{i=1}^{N} |y_{\text{true},i} - y_{\text{pred},i}|
  \]
- **Interpretation:** Less sensitive to outliers than RMSE.

### c. R-squared (Coefficient of Determination)
- **Definition:** Proportion of variance in the true RUL explained by the model.
- **Formula:**  
  \[
  R^2 = 1 - \frac{\sum_{i=1}^{N} (y_{\text{true},i} - y_{\text{pred},i})^2}{\sum_{i=1}^{N} (y_{\text{true},i} - \bar{y}_{\text{true}})^2}
  \]
- **Interpretation:** Closer to 1 means better fit.

### d. Error Distribution
- **Definition:** Visualization (histogram or boxplot) of errors (\(y_{\text{pred}} - y_{\text{true}}\)).
- **Interpretation:** Shows if errors are biased (systematically over- or under-predicting) and the spread of errors.

### e. Case Studies (Random, Best, Worst, Average Cases)
- **Definition:** Plot predicted vs. true RUL for selected test units.
- **Interpretation:** Qualitative assessment of model performance in different scenarios.

### f. Training Curves
- **Definition:** Plots of loss and RMSE over training epochs.
- **Interpretation:** Shows convergence behavior and potential overfitting.

---

## 2. How to Generate These Metrics

- **RMSE/MAE:**  
  Use MATLAB or Python to compute these for each test unit and overall.
  ```matlab
  rmse = sqrt(mean((y_true - y_pred).^2));
  mae = mean(abs(y_true - y_pred));
  ```

- **R-squared:**  
  ```matlab
  SS_res = sum((y_true - y_pred).^2);
  SS_tot = sum((y_true - mean(y_true)).^2);
  R2 = 1 - SS_res/SS_tot;
  ```

- **Error Distribution:**  
  Use `histogram(y_true - y_pred)` in MATLAB or `plt.hist(y_true - y_pred)` in Python.

- **Case Studies:**  
  Plot `plot(1:N, y_true, 1:N, y_pred)` for selected units.

- **Training Curves:**  
  Save and plot loss/RMSE at each epoch.

---

## 3. Structure of a Written Report

### Example Outline

#### **Results and Discussion**

1. **Overall Performance**
   - Report mean RMSE, MAE, R-squared.
   - Discuss what these numbers mean in the context of your data.

2. **Error Analysis**
   - Show error distribution (histogram/boxplot).
   - Discuss if the model is biased or has high variance.

3. **Case Studies**
   - Show plots for random, best, worst, and average cases.
   - Discuss why the model performed well or poorly in each.

4. **Training Behavior**
   - Show training/validation loss and RMSE curves.
   - Discuss convergence and overfitting.

5. **Interpretation**
   - What do the results tell you about your model and data?
   - Where does the model excel, and where does it struggle?

6. **Potential Improvements**
   - Suggest ways to improve the model (e.g., different architectures, more data, feature engineering).

---

## 4. Example Written Summary

> The CNN model achieved a mean RMSE of 37.65 cycles (SD: 14.62) on the test set, indicating moderate predictive accuracy. The error distribution shows that while most predictions are close to the true RUL, some engines have large errors, particularly those with sudden or nonlinear degradation. The best-case predictions closely follow the true RUL, while the worst-case shows significant deviation. Training curves indicate stable convergence without overfitting. Overall, the model captures general degradation trends but struggles with complex failure patterns. Future work could explore hybrid CNN-LSTM models or attention mechanisms to improve performance.

---

## 5. Automating Report Generation

- **MATLAB:**  
  Use `fprintf`, `disp`, and plotting functions to output metrics and save figures.
- **Python:**  
  Use `pandas`, `numpy`, `matplotlib`, and `sklearn.metrics` for calculations and plots.
- **Markdown/LaTeX:**  
  Write the report in Markdown (as shown here) or export results from code to a Markdown/LaTeX file.

---

**In summary:**  
Include RMSE, MAE, R-squared, error distribution, case studies, and training curves in your report. Discuss what each metric means, show plots, and interpret the results. This will provide a comprehensive and professional evaluation of your model's performance. 
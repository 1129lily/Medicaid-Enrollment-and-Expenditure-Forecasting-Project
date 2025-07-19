# Medicaid Enrollment and Expenditure Forecasting Project

## 1. Background

This project is dedicated to forecasting Medicaid enrollment and expenditure in the United States. Medicaid is a critical public health insurance program serving millions of Americans, and understanding its trends is vital for policy making and budget allocation.

The project combines multiple time series forecasting techniques — including classical statistical models and modern machine learning approaches — to analyze both monthly enrollment data and annual expenditure data. The aim is to develop accurate, interpretable forecasts to assist stakeholders in decision making.

More details can be found in the project overview:  
https://emrts.us/2025/01/03/medicaid-enrollment-expenditure-forecast-project/

## 2. Data Sources

- **Enrollment Data**:  
  [Monthly Medicaid & CHIP Enrollment Data (data.medicaid.gov)](https://data.medicaid.gov/dataset/6165f45b-ca93-5bb5-9d06-db29c692a360/data)
  
- **Expenditure Data**:  
  [Annual Medicaid Fraud Control Units Expenditure Reports (oig.hhs.gov)](https://oig.hhs.gov/fraud/medicaid-fraud-control-units-mfcu/)

## 3. Data Processing

- **Enrollment** data is provided in a consolidated monthly format.  
- **Expenditure** data is stored in separate files by year or by state. These need to be pre-processed and merged into a unified format for time series modeling.

### 3.1 Expenditure Data

- The raw expenditure data is distributed across multiple individual documents hosted on the MFCU webpage.
- A web crawler script (`data process (mfcu).ipynb`) was developed to **automatically download all available documents** from the MFCU site.
- These documents come in **various formats**, including PDF(`.pdf`) and HTML (`.htm`). Inconsistent formats across years make uniform analysis difficult.
- To address this, all files are **converted into structured CSV files**, using a combination of PDF parsing and HTML table extraction methods, to facilitate consistent and scalable data analysis.

### 3.2 Enrollment Data

- In contrast, the enrollment dataset is already well-structured and consolidated by the data provider.
- The downloaded file can be used **directly without additional cleaning or transformation**.

Also,In the data integration process, the target_state variable can be modified to perform data consolidation and forecasting for different states.
Data cleaning, normalization, and aggregation steps are detailed in the preprocessing section of the notebook.

## 4. Time Series Analysis

We conduct detailed exploratory analysis on both enrollment and expenditure data, including:

- Stationarity tests (ADF Test)
- Autocorrelation (ACF) and Partial Autocorrelation (PACF) plots
- Seasonality and trend decomposition
- Log-transformation and differencing if necessary

Details are available in the notebook `time series analysis.ipynb`.

## 5. Forecasting Models

Multiple forecasting models are employed to capture short-term and long-term dynamics:

- **Prophet** (both in Python and R)
- **ARIMA / SARIMA**
- **GARCH** for volatility modeling (primarily for expenditure series)
- **LSTM (Long Short-Term Memory Neural Networks)** for nonlinear patterns

> ⚠️ Note: Expenditure data is **annual**, whereas enrollment data is **monthly**. Model parameters and frequencies are adjusted accordingly.

Forecasts include confidence intervals and visualizations for each approach.  
Code for each model can be found in the respective scripts:

- `time series analysis.ipynb`
- `prophet_enrollment.r`, `prophet_expenditure.r`

## Installation

### Python dependencies

Install all required Python packages via pip:

```bash
pip install statsmodels arch scikit-learn tensorflow pdfplumber matplotlib pandas numpy
```

This project uses:

**matplotlib**, **pandas**, and **numpy** for data handling and visualization

**pdfplumber** for parsing PDF documents during data processing

**statsmodels** for time series analysis (ADF test, ACF/PACF plots, ARIMA)

**arch** for GARCH volatility modeling

**scikit-learn** for data preprocessing (MinMaxScaler)

**tensorflow** (Keras) for LSTM neural networks

### R dependencies

For running Prophet in R, install the package by running:

```r
install.packages("prophet")
```


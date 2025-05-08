# Statistical methods: quick reference

## Description

This is a **quick reference** of statistical tools that are recurrently used, the bread and butter of the lab's downstream analyses when it comes to statistical testing.

Consider adding methods that have high practical value, i.e. they address common problems and have been proven handy in our projects.

## Table of contents
- [Regression Methods](#section1)
- [Statistical Tests](#section2)
- [More Examples](#section3)

<div id='section1'/>

## *Regression Methods*

### Ordinary least squares (OLS)

**Setting:** Response variable and covariates as linear predictors. It assumes dispersion is independent of the mean (homoscedasticity).

**References:**
* [scipy.stats.linregress](https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.linregress.html)
* [statsmodels.regression.linear_model.OLS](https://www.statsmodels.org/dev/generated/statsmodels.regression.linear_model.OLS.html)

### Robust linear model (IRLS)

**Setting:** Same as OLS, but it redistributes weights across data in order to reduce the influence of outliers.

**References:**
* [statsmodels.RLM](https://www.statsmodels.org/dev/examples/notebooks/generated/robust_models_0.html)

### Linear mixed-effects models (LMM)

**Setting:** Whenever regression samples are not independent, it allows fitting specific intercept and/or slope components for the levels the categorical variables of interest.

**References:**
* [statsmodels.mixedlm](https://www.statsmodels.org/stable/examples/notebooks/generated/mixed_lm_example.html)

### Logistic

**Setting:** Linear model with binary response variable.

**References:**
* [sklearn.LogisticRegression](https://scikit-learn.org/stable/modules/generated/sklearn.linear_model.LogisticRegression.html)
* [statsmodels.Logit](https://www.statsmodels.org/stable/generated/statsmodels.discrete.discrete_model.Logit.html)

### Poisson / Negative Binomial

**Setting:** The response variable represents counts (integers). Assumes mean is equal to dispersion (Poisson) or fits an overdispersion parameter (Negative Binomial).

**References:**
* [statsmodels.GLM](https://www.statsmodels.org/dev/glm.html#generalized-linear-models)

### Cox (proportional hazards)

**Setting:** Survival analysis. The response variable represents time-to-event values.

**References:**
* [statsmodels.smf](https://www.statsmodels.org/stable/duration.html#regression-methods)

<div id='section2'/>

## *Statistical tests*

### Mann-Whitney-Wilcoxon

**Setting:** Non-parametric group comparison test. It is the right test to measure distribution shifts. 

**References:**
* [scipy.stats.mannwhitneyu](https://docs.scipy.org/doc/scipy-1.15.2/reference/generated/scipy.stats.mannwhitneyu.html)

**Fun note:**
Note that the U-statistic resulting from the test can be converted into an AUC-ROC if divided by the product of the sample sizes of the respective samples being compared.

### Fisher test

**Setting:** Analysis of 2x2 contingency tables

**References:**
* [scipy.stats.fisher_exact](https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.fisher_exact.html)

### Chi-squared / G-test

**Setting:** Analysis of general contingency tables. They represent both sides of the same underlying idea, but the G-test would be the more preferable in general, simply because Chi-square is obtained as quadratic approximation of the G-test likelihood ratio statistic.

**References:**
* [scipy.stats.chi2_contingency](https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.chi2.html)

**Fun note:**
With the Python function `scipy.stats.chi2_contingency` you can compute both Chi-squared (default) and G-test (with the option `lambda_="log_likelihood"`).


## *Multiple test correction*

### Benjamini-Hochberg FDR

**Setting:** Computes q-values: rejecting values with q-values $\alpha$ or lower, ensures a false-discovery rate $=\alpha$.

**References:**

* [statsmodels.stats.multitest](https://www.statsmodels.org/dev/generated/statsmodels.stats.multitest.fdrcorrection.html)

<div id='section3'/>

## More examples

* https://github.com/statsmodels/statsmodels/wiki/Examples




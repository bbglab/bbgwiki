# Statistical methods: quick reference

## Description

This is a **quick reference** of statistical tools that are recurrently used, the bread and butter of the lab's downstream analyses.

Please, consider adding methods that have high practical value, i.e. they address common problems and have been proven handy in our projects.

## *Regression Methods*

### Ordinary least squares (OLS)

**Setting:** Response variable and covariates as linear predictors. It assumes dispersion is independent of the mean (homoscedasticity).

### Robust (IRLS)

**Setting:** Same as OLS, but it redistributes weights across data in order to reduce the influence of outliers.

### Logistic

**Setting:** The response variable is binary.

### Poisson

**Setting:** The response variable represents counts (integers). Assumes mean equals dispersion (equidispersion).

### Negative binomial

**Setting:** The response variable represents counts (integers). It does not assume equidispersion and fits an overdispersion parameter.

### Cox (proportional hazards)

**Setting:** Survival analysis. The response variable represents time-to-event values.


## *Other statistical tests*

### Mann-Whitney-Wilcoxon

**Setting:** Non-parametric group comparison test. 

### Student's t-Test

**Setting:** Parametric group comparison test. It accounts for the fact that the estimator of the mean have thicker tails than the normal distribution when the number of samples is limited.

### Fisher test

**Setting:** Analysis of contingency tables

### G-test

**Setting:** Analysis of contingency tables

### Binomial exact test


### Log-rank test

**Setting:** Group comparison in terms of survival.

## *Multiple test correction*

### Benjamini-Hochberg FDR

**Setting:** Computes q-values: rejecting values with q-values $\alpha$ or lower, ensures a false-discovery rate $=\alpha$.

## *Random generation*

### Subsampling

### Permutations

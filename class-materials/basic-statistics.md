---
title: Basic Statistical Analysis
layout: default
nav_order: 8
parent: Class Materials
---

# Introduction to Statistics with R

[<img src="https://img.shields.io/badge/Download-HTML-blue?style=for-the-badge&logo=html5" alt="Download HTML" />](../rendered-html/basic-statistics.html)
[<img src="https://img.shields.io/badge/Download-R_Markdown-green?style=for-the-badge&logo=r" alt="Download R Markdown" />](basic-statistics.Rmd)

## Welcome to Statistics in R!

Have you ever wondered:
- Is this medical treatment actually effective?
- Are these two groups really different from each other?
- How can we be confident in our research findings?

Statistics helps us answer these questions! In this tutorial, we'll learn:
1. How to understand and work with data distributions
2. How to make decisions using statistical tests
3. How to visualize and interpret our results

Don't worry if you're new to statistics - we'll explain everything step by step!

## Part 1: Understanding Data Distributions

### What is a Distribution?

Think of a distribution as a way to see the "shape" of our data. For example:
- Heights in a population
- Test scores in a class
- Gene expression levels in different samples

The most common distribution we see in nature is the "normal" or "bell-shaped" distribution.

### The Normal Distribution: A Bell-Shaped Curve

Let's create and visualize a normal distribution. Imagine we're measuring heights of 1000 people:

```r
# Generate some example height data (in centimeters)
set.seed(123)  # This makes our random numbers reproducible
heights <- rnorm(1000, mean = 170, sd = 10)  # Mean height 170cm, SD 10cm

# Create a histogram with density scaling
hist(heights, 
     breaks = 30,
     main = "Distribution of Heights in Our Population",
     xlab = "Height (cm)",
     ylab = "Density",
     col = "lightblue",
     border = "white",
     prob = TRUE)  # Use probability scaling for density curves

# Add theoretical normal density curve
curve(dnorm(x, mean = mean(heights), sd = sd(heights)), 
      col = "red", 
      lwd = 2,
      add = TRUE)

# Add empirical density curve
lines(density(heights), 
      col = "darkblue", 
      lwd = 2,
      lty = 2)

# Add legend
legend("topright", 
       legend = c("Theoretical Normal", "Empirical Density"),
       col = c("red", "darkblue"),
       lwd = 2,
       lty = c(1, 2))
```

### Understanding the Normal Distribution

Key features of a normal distribution:
1. It's symmetric around the mean
2. The mean, median, and mode are all equal
3. About 68% of data falls within 1 standard deviation of the mean
4. About 95% of data falls within 2 standard deviations
5. About 99.7% of data falls within 3 standard deviations

## Part 2: Basic Statistical Concepts

### Measures of Central Tendency

```r
# Calculate basic statistics
mean_height <- mean(heights)
median_height <- median(heights)
mode_height <- as.numeric(names(sort(table(round(heights)), decreasing = TRUE)[1]))

# Print results
cat("Mean height:", round(mean_height, 1), "cm\n")
cat("Median height:", round(median_height, 1), "cm\n")
cat("Mode height:", round(mode_height, 1), "cm\n")
```

### Measures of Spread

```r
# Calculate measures of spread
sd_height <- sd(heights)
var_height <- var(heights)
range_height <- range(heights)
iqr_height <- IQR(heights)

# Print results
cat("Standard deviation:", round(sd_height, 1), "cm\n")
cat("Variance:", round(var_height, 1), "cm²\n")
cat("Range:", round(diff(range_height), 1), "cm\n")
cat("Interquartile range:", round(iqr_height, 1), "cm\n")
```

## Part 3: Comparing Groups

Let's say we're comparing a control group to a treatment group:

```r
# Create example data
control <- rnorm(30, mean = 100, sd = 15)    # Control group measurements
treatment <- rnorm(30, mean = 115, sd = 15)   # Treatment group measurements

# Put data in a nice format
experiment_data <- data.frame(
  value = c(control, treatment),
  group = rep(c("Control", "Treatment"), each = 30)
)

# Create a clear visualization
boxplot(value ~ group, data = experiment_data,
        main = "Comparing Control vs Treatment",
        ylab = "Measurement Value",
        col = c("lightblue", "lightgreen"))

# Add individual points
stripchart(value ~ group, data = experiment_data,
           vertical = TRUE, method = "jitter",
           add = TRUE, pch = 19, col = "darkgray")

# Calculate and display some basic statistics
cat("\nControl Group:")
cat("\n  Average:", round(mean(control), 1))
cat("\n  SD:", round(sd(control), 1))
cat("\n\nTreatment Group:")
cat("\n  Average:", round(mean(treatment), 1))
cat("\n  SD:", round(sd(treatment), 1))
```

## Part 4: Statistical Tests

### The t-test: Comparing Two Groups

```r
# Perform t-test
t_result <- t.test(treatment, control)

# Print results in a clear format
cat("\nt-test Results:")
cat("\n  t-statistic:", round(t_result$statistic, 3))
cat("\n  p-value:", format.pval(t_result$p.value, digits = 3))
cat("\n  95% Confidence Interval:", 
    paste(round(t_result$conf.int, 1), collapse = " to "), "\n")
```

### Understanding p-values

The p-value tells us how likely we would be to see our results (or more extreme) if there were really no difference between groups. Generally:

- p < 0.05: "Statistically significant"
- p < 0.01: "Highly significant"
- p < 0.001: "Very highly significant"

But remember: Statistical significance ≠ Practical significance!

## Part 5: Common Statistical Tests

Here's a guide for choosing the right statistical test:

1. **Comparing Two Groups**
   - Continuous data, normal distribution: t-test
   - Non-normal data: Wilcoxon test
   - Categorical data: Chi-square test

2. **Comparing Multiple Groups**
   - Continuous data, normal distribution: ANOVA
   - Non-normal data: Kruskal-Wallis test

3. **Looking for Relationships**
   - Between continuous variables: Correlation
   - Predicting values: Regression

## Practice Exercises

1. Generate two groups of data and test if they're different
2. Calculate and interpret confidence intervals
3. Create visualizations to support your statistical analysis

```r
# Exercise 1: Compare two groups
group1 <- rnorm(50, mean = 10, sd = 2)
group2 <- rnorm(50, mean = 11, sd = 2)

# Visualize
boxplot(list(Group1 = group1, Group2 = group2),
        main = "Comparing Two Groups",
        ylab = "Values")

# Test for difference
test_result <- t.test(group1, group2)
print(test_result)
```

## Tips for Good Statistical Practice

1. **Always Plot Your Data**
   - Visualize before analyzing
   - Look for patterns and outliers
   - Don't trust summary statistics alone

2. **Check Your Assumptions**
   - Is the data normally distributed?
   - Are the groups independent?
   - Is the variance similar between groups?

3. **Be Careful with Interpretation**
   - Correlation ≠ Causation
   - Statistical significance ≠ Practical significance
   - Consider effect sizes, not just p-values

4. **Document Everything**
   - Keep track of your analysis steps
   - Note any data cleaning or transformations
   - Make your analysis reproducible

## Additional Resources

1. [UCLA Statistical Methods and Data Analytics](https://stats.oarc.ucla.edu/)
2. [R for Data Science - Statistical Analysis](https://r4ds.had.co.nz/)
3. [Quick R: Basic Statistics](https://www.statmethods.net/stats/index.html)

## Advanced Topics (Optional)

### Understanding Hypothesis Testing in Detail

Hypothesis testing is like being a detective - you start with a assumption (called the null hypothesis) and then look for evidence to disprove it.

1. **The Two Hypotheses**:
   - **Null Hypothesis (H₀)**: Your initial assumption (usually "no effect" or "no difference")
   - **Alternative Hypothesis (H₁)**: What you're looking for evidence to support

```r
# Let's simulate a medical trial example
# H₀: New drug has no effect (difference = 0)
# H₁: New drug has an effect (difference ≠ 0)

set.seed(123)  # For reproducible results
placebo <- rnorm(100, mean = 100, sd = 15)    # Placebo group
drug <- rnorm(100, mean = 110, sd = 15)       # Drug group

# Perform t-test
trial_result <- t.test(drug, placebo)

# Print results
cat("\nDrug Trial Results:")
cat("\n  Mean difference:", round(mean(drug) - mean(placebo), 1))
cat("\n  p-value:", format.pval(trial_result$p.value, digits = 3))
cat("\n  95% CI:", paste(round(trial_result$conf.int, 1), collapse = " to "), "\n")
```

### Multiple Testing

When doing many tests, we need to adjust our p-values:

```r
# Simulate multiple tests
p_values <- replicate(100, {
  x <- rnorm(20)
  y <- rnorm(20)
  t.test(x, y)$p.value
})

# Adjust p-values
p_adjusted <- p.adjust(p_values, method = "bonferroni")

# Compare
cat("Number of 'significant' results (p < 0.05):")
cat("\n  Without adjustment:", sum(p_values < 0.05))
cat("\n  With Bonferroni adjustment:", sum(p_adjusted < 0.05))
```

Remember: Statistics is about telling stories with data. The more you practice, the better you'll get at understanding and telling these stories! 
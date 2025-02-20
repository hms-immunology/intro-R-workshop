---
title: Basic Plotting and Statistics in R
layout: default
nav_order: 13
---

# Basic Plotting and Statistics in R

[<img src="https://img.shields.io/badge/Download-HTML-blue?style=for-the-badge&logo=html5" alt="Download HTML" />](../rendered-html/basic-plotting-statistics.html)
[<img src="https://img.shields.io/badge/Download-R_Markdown-green?style=for-the-badge&logo=r" alt="Download R Markdown" />](basic-plotting-statistics.Rmd)

## Welcome to Data Visualization and Statistics in R!

In this 2-hour session, we'll learn how to:
- Create beautiful and informative plots using ggplot2
- Understand basic statistical concepts
- Perform data analysis using R
- Make data-driven decisions

## Required Packages

We'll be using these R packages:
```r
library(tidyverse)  # Includes ggplot2, dplyr, and more
library(datasets)   # For built-in datasets
```

## Part 1: Getting Started with R for Statistics

Let's begin by exploring some built-in datasets in R. We'll use the famous `mtcars` dataset:

```r
# Load and examine mtcars dataset
data("mtcars")
head(mtcars)

# Basic summary statistics using dplyr
mtcars %>%
  summarise(
    avg_mpg = mean(mpg),
    med_mpg = median(mpg),
    sd_mpg = sd(mpg)
  )
```

## Part 2: Creating Beautiful Visualizations

### Basic Histogram

```r
# Create a histogram using ggplot2
ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(fill = "skyblue", color = "white", bins = 30) +
  labs(
    title = "Distribution of Car Mileage",
    x = "Miles Per Gallon",
    y = "Count"
  ) +
  theme_minimal()
```

### Adding Density Curves

```r
# Add density curve to histogram
ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(aes(y = ..density..), fill = "skyblue", color = "white") +
  geom_density(color = "red", linewidth = 1) +
  labs(
    title = "Distribution of Car Mileage with Density Curve",
    x = "Miles Per Gallon",
    y = "Density"
  ) +
  theme_minimal()
```

## Part 3: Understanding Data Distributions

### What is a Distribution?

A distribution shows us the "shape" of our data. Think of it as a way to see:
- How often different values occur
- What values are typical or unusual
- How spread out the data is

Common examples in research:
- Heights in a population
- Test scores in a class
- Gene expression levels
- Treatment responses

### The Normal Distribution

The "normal" or "bell-shaped" distribution is the most common in nature. Key features:
1. It's symmetric around the mean
2. The mean, median, and mode are all equal
3. About 68% of data falls within 1 standard deviation of the mean
4. About 95% of data falls within 2 standard deviations
5. About 99.7% of data falls within 3 standard deviations

Let's visualize this with our data:

```r
# Generate example height data
set.seed(123)  # For reproducible results
heights <- rnorm(1000, mean = 170, sd = 10)  # 1000 heights, mean=170cm, SD=10cm

# Create histogram with density curve
ggplot(data.frame(height = heights), aes(x = height)) +
  geom_histogram(aes(y = ..density..), 
                 fill = "skyblue", 
                 color = "white",
                 bins = 30) +
  geom_density(color = "red", linewidth = 1) +
  labs(
    title = "Distribution of Heights",
    subtitle = "With Normal Density Curve",
    x = "Height (cm)",
    y = "Density"
  ) +
  theme_minimal()
```

### Understanding Different Types of Distributions

1. **Symmetric Distributions**
   - Normal (bell-shaped)
   - Uniform (flat)
   - Student's t (like normal but heavier tails)

2. **Skewed Distributions**
   - Right-skewed (tail extends right)
   - Left-skewed (tail extends left)
   - Common in real-world data like income, reaction times

3. **Other Patterns**
   - Bimodal (two peaks)
   - Multimodal (multiple peaks)
   - Bounded (limited range)

## Part 4: Statistical Testing

### The t-test: A Detective's Tool

Think of a t-test like being a detective. You start with:
- A question: "Are these groups different?"
- A null hypothesis (H₀): "There is no real difference"
- An alternative hypothesis (H₁): "There is a real difference"

### Types of t-tests

1. **One-sample t-test**
   - Compare one group to a known value
   - Example: Are students scoring above average?

2. **Independent two-sample t-test**
   - Compare two separate groups
   - Example: Treatment vs Control
   - What we're using in our examples

3. **Paired t-test**
   - Compare matched pairs of observations
   - Example: Before vs After treatment

### Performing and Interpreting a t-test

Let's walk through an example:

```r
# Create two groups to compare
group1 <- rnorm(30, mean = 100, sd = 15)  # Control group
group2 <- rnorm(30, mean = 115, sd = 15)  # Treatment group

# Perform t-test
t_result <- t.test(group1, group2)

# Print results with explanation
cat("T-test Results:\n")
cat("----------------\n")
cat("Mean difference:", round(mean(group2) - mean(group1), 2), "\n")
cat("t-statistic:", round(t_result$statistic, 2), "\n")
cat("p-value:", format.pval(t_result$p.value, digits = 3), "\n")
cat("95% CI:", paste(round(t_result$conf.int, 2), collapse = " to "), "\n")

# Visualize the comparison
data.frame(
  value = c(group1, group2),
  group = rep(c("Control", "Treatment"), each = 30)
) %>%
  ggplot(aes(x = value, fill = group)) +
  geom_density(alpha = 0.5) +
  labs(
    title = "Comparing Two Groups",
    subtitle = paste("p-value =", format.pval(t_result$p.value, digits = 3)),
    x = "Value",
    y = "Density"
  ) +
  theme_minimal()
```

### Understanding the Results

1. **p-value Interpretation**
   - p < 0.05: "Statistically significant"
   - p < 0.01: "Highly significant"
   - p < 0.001: "Very highly significant"

2. **Effect Size**
   - How big is the difference?
   - Is it practically meaningful?
   - Look at means and confidence intervals

3. **Assumptions to Check**
   - Normal distribution (or large enough sample)
   - Equal variances (for independent t-test)
   - Independent observations

4. **Common Mistakes to Avoid**
   - Don't rely only on p-values
   - Consider practical significance
   - Check your assumptions
   - Be careful with multiple tests

### Visualizing Test Results

Good practice combines:
1. Statistical test results
2. Visual representation
3. Clear labeling
4. Effect size information

Example combining all elements:

```r
# Create comprehensive visualization
ggplot(data.frame(
  value = c(group1, group2),
  group = rep(c("Control", "Treatment"), each = 30)
), aes(x = group, y = value, fill = group)) +
  geom_boxplot(alpha = 0.5) +
  geom_jitter(width = 0.2, alpha = 0.5) +
  labs(
    title = "Comparing Groups",
    subtitle = paste(
      "p =", format.pval(t_result$p.value, digits = 3),
      "| Mean Diff =", round(mean(group2) - mean(group1), 2)
    ),
    x = "Group",
    y = "Value"
  ) +
  theme_minimal()
```

## Part 5: Exploring Relationships

### Scatter Plots and Regression Lines

```r
# Create scatter plot with regression lines
ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, color = Species)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Relationship: Sepal Length vs Petal Length",
    x = "Sepal Length",
    y = "Petal Length"
  ) +
  theme_minimal()
```

## Practice Exercises

1. **Basic Data Exploration**
   - Calculate summary statistics for the `mtcars` dataset
   - Create a visualization showing the distribution of car weights

2. **Group Comparisons**
   - Compare the mileage of cars with different numbers of cylinders
   - Create appropriate visualizations
   - Perform a statistical test

3. **Relationship Analysis**
   - Investigate the relationship between car weight and mileage
   - Create a scatter plot with a regression line
   - Calculate the correlation coefficient

## Tips for Success

1. **Always Start with Data Exploration**
   - Look at your data first
   - Calculate basic statistics
   - Create simple visualizations

2. **Choose the Right Visualization**
   - Histograms for distributions
   - Box plots for group comparisons
   - Scatter plots for relationships

3. **Make Your Plots Clear**
   - Add proper labels
   - Use appropriate colors
   - Include titles and subtitles

4. **Document Your Analysis**
   - Keep track of your steps
   - Comment your code
   - Save your plots

## Additional Resources

1. [R for Data Science](https://r4ds.had.co.nz/)
2. [ggplot2 Documentation](https://ggplot2.tidyverse.org/)
3. [R Statistics Essential Training](https://www.linkedin.com/learning/r-statistics-essential-training)
4. [Quick-R](https://www.statmethods.net/)

## Cheat Sheet

### Common ggplot2 Geoms
- `geom_histogram()`: For distributions
- `geom_boxplot()`: For group comparisons
- `geom_point()`: For scatter plots
- `geom_line()`: For trends
- `geom_smooth()`: For regression lines

### Basic dplyr Functions
- `summarise()`: Calculate summary statistics
- `group_by()`: Group data by variables
- `filter()`: Subset data
- `select()`: Choose columns
- `arrange()`: Sort data

### Statistical Functions
- `mean()`: Average
- `median()`: Middle value
- `sd()`: Standard deviation
- `t.test()`: Compare two groups
- `cor()`: Correlation coefficient 
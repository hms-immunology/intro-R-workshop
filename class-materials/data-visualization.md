---
title: Data Visualization with ggplot2
layout: default
nav_order: 10
---

# Data Visualization with ggplot2

[<img src="https://img.shields.io/badge/Download-HTML-blue?style=for-the-badge&logo=html5" alt="Download HTML" />](../rendered-html/data-visualization.html)
[<img src="https://img.shields.io/badge/Download-R_Markdown-green?style=for-the-badge&logo=r" alt="Download R Markdown" />](data-visualization.Rmd)

## Introduction to ggplot2

ggplot2 is a powerful package for creating beautiful visualizations in R. It's based on the "Grammar of Graphics," which means we build plots layer by layer. Think of it like making a sandwich:

1. First, you need a base (the data)
2. Then add your main ingredients (geometric shapes like points, lines, or bars)
3. Finally, add your toppings (colors, labels, themes)

Let's start by loading the required packages and our sample data:

```r
# Load required packages
library(tidyverse)  # includes ggplot2
library(viridis)    # for color-blind friendly palettes

# Create our sample gene expression dataset (from previous lesson)
gene_data <- tibble(
  gene_id = c("BRCA1", "TP53", "EGFR", "KRAS", "HER2"),
  control_1 = c(100, 150, 80, 200, 120),
  control_2 = c(110, 140, 85, 190, 125),
  treated_1 = c(200, 300, 90, 180, 240),
  treated_2 = c(190, 280, 95, 185, 230),
  chromosome = c("17", "17", "7", "12", "17"),
  pathway = c("DNA repair", "Cell cycle", "Growth", "Signaling", "Growth")
)

# Convert to long format for plotting
gene_data_long <- gene_data %>%
  pivot_longer(
    cols = c(control_1, control_2, treated_1, treated_2),
    names_to = "sample",
    values_to = "expression"
  )
```

## Basic ggplot2 Syntax

Every ggplot2 plot has three key components:
1. **Data**: The dataset you want to visualize
2. **Aesthetics** (`aes`): How your data maps to visual properties (x, y, color, size, etc.)
3. **Geometries** (`geom_*`): The type of plot you want to create

The basic template is:
```r
ggplot(data = your_data, aes(x = x_variable, y = y_variable)) +
  geom_something()
```

## 1. Bar Plots

Let's start with a simple bar plot showing gene expression levels:

```r
# Basic bar plot
ggplot(gene_data_long, aes(x = gene_id, y = expression)) +
  geom_bar(stat = "identity") +
  labs(title = "Gene Expression Levels",
       x = "Gene",
       y = "Expression Level")

# Grouped bar plot
ggplot(gene_data_long, aes(x = gene_id, y = expression, fill = sample)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Gene Expression Levels by Sample",
       x = "Gene",
       y = "Expression Level") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels
```

## 2. Box Plots

Box plots are great for showing the distribution of data and identifying outliers:

```r
# Calculate some summary statistics
gene_summary <- gene_data_long %>%
  group_by(gene_id) %>%
  summarise(
    mean_expr = mean(expression),
    sd_expr = sd(expression),
    sem_expr = sd(expression) / sqrt(n())  # Standard Error of Mean
  )

# Basic box plot
ggplot(gene_data_long, aes(x = gene_id, y = expression)) +
  geom_boxplot() +
  labs(title = "Distribution of Expression Levels",
       x = "Gene",
       y = "Expression Level")

# Box plot with individual points and error bars
ggplot(gene_data_long, aes(x = gene_id, y = expression, fill = gene_id)) +
  geom_boxplot(alpha = 0.7) +  # Alpha controls transparency
  geom_point(position = position_jitter(width = 0.2)) +  # Add individual points
  labs(title = "Gene Expression Distribution with Data Points",
       x = "Gene",
       y = "Expression Level") +
  theme_minimal() +
  theme(legend.position = "none")  # Remove legend

# Understanding the Box Plot Elements:
# - Box: Shows the Interquartile Range (IQR) - middle 50% of data
# - Line in box: Median
# - Whiskers: Extend to most extreme points within 1.5 * IQR
# - Points beyond whiskers: Potential outliers
```

## 3. Scatter Plots

Scatter plots are useful for showing relationships between two variables:

```r
# Calculate mean expression for control and treated conditions
expression_means <- gene_data %>%
  mutate(
    mean_control = (control_1 + control_2) / 2,
    mean_treated = (treated_1 + treated_2) / 2
  )

# Basic scatter plot
ggplot(expression_means, 
       aes(x = mean_control, y = mean_treated, label = gene_id)) +
  geom_point() +
  geom_text(vjust = -0.5) +  # Add labels above points
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "red") +  # Add y=x line
  labs(title = "Control vs Treated Expression",
       x = "Mean Control Expression",
       y = "Mean Treated Expression") +
  theme_minimal()

# Scatter plot with additional information
ggplot(expression_means, 
       aes(x = mean_control, y = mean_treated, 
           color = pathway, label = gene_id)) +
  geom_point(size = 3) +
  geom_text(vjust = -0.5) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "gray") +
  labs(title = "Control vs Treated Expression by Pathway",
       x = "Mean Control Expression",
       y = "Mean Treated Expression") +
  theme_minimal()
```

## 4. Histograms

Histograms show the distribution of a continuous variable:

```r
# Basic histogram
ggplot(gene_data_long, aes(x = expression)) +
  geom_histogram(bins = 10) +
  labs(title = "Distribution of Expression Values",
       x = "Expression Level",
       y = "Count")

# Histogram with density curve
ggplot(gene_data_long, aes(x = expression)) +
  geom_histogram(aes(y = ..density..), bins = 10, fill = "lightblue", alpha = 0.7) +
  geom_density(color = "red") +
  labs(title = "Distribution of Expression Values with Density Curve",
       x = "Expression Level",
       y = "Density") +
  theme_minimal()

# Faceted histogram by sample type
ggplot(gene_data_long, aes(x = expression, fill = sample)) +
  geom_histogram(bins = 10, alpha = 0.7, position = "identity") +
  facet_wrap(~sample) +
  labs(title = "Expression Distribution by Sample",
       x = "Expression Level",
       y = "Count") +
  theme_minimal()
```

## 5. Heatmaps

Heatmaps are excellent for visualizing expression patterns across multiple conditions:

```r
# Prepare data for heatmap
heatmap_data <- gene_data %>%
  select(gene_id, control_1, control_2, treated_1, treated_2) %>%
  pivot_longer(
    cols = -gene_id,
    names_to = "sample",
    values_to = "expression"
  )

# Create heatmap
ggplot(heatmap_data, aes(x = sample, y = gene_id, fill = expression)) +
  geom_tile() +
  scale_fill_viridis() +  # Color-blind friendly palette
  labs(title = "Gene Expression Heatmap",
       x = "Sample",
       y = "Gene",
       fill = "Expression") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Heatmap with centered and scaled values
heatmap_data_scaled <- heatmap_data %>%
  group_by(gene_id) %>%
  mutate(scaled_expression = scale(expression)[,1]) %>%
  ungroup()

ggplot(heatmap_data_scaled, 
       aes(x = sample, y = gene_id, fill = scaled_expression)) +
  geom_tile() +
  scale_fill_viridis(option = "magma") +
  labs(title = "Gene Expression Heatmap (Scaled)",
       x = "Sample",
       y = "Gene",
       fill = "Z-score") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
```

## Customizing Plots

You can customize almost every aspect of your plots. Here are some common modifications:

```r
# Example of a highly customized plot
ggplot(gene_data_long, aes(x = gene_id, y = expression, fill = sample)) +
  geom_boxplot(alpha = 0.7) +
  geom_point(position = position_jitterdodge(jitter.width = 0.2)) +
  scale_fill_viridis_d() +  # Discrete color-blind friendly palette
  labs(
    title = "Gene Expression Analysis",
    subtitle = "Comparing Control and Treated Samples",
    x = "Gene",
    y = "Expression Level",
    fill = "Sample Type"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    plot.subtitle = element_text(size = 12, color = "gray50"),
    axis.title = element_text(size = 12),
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "top"
  )
```

## Common Plot Modifications

Here are some useful modifications you might want to apply to your plots:

1. **Changing Themes**:
```r
# Same plot with different themes
base_plot <- ggplot(gene_data_long, aes(x = gene_id, y = expression)) +
  geom_boxplot()

# Default theme
base_plot

# Minimal theme
base_plot + theme_minimal()

# Classic theme
base_plot + theme_classic()

# Black and white theme
base_plot + theme_bw()
```

2. **Modifying Axes**:
```r
base_plot +
  scale_y_log10() +  # Log scale for y-axis
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),  # Rotate x labels
    axis.title = element_text(size = 12, face = "bold")  # Bold axis titles
  )
```

3. **Adding Labels and Annotations**:
```r
ggplot(expression_means, 
       aes(x = mean_control, y = mean_treated)) +
  geom_point() +
  geom_text(aes(label = gene_id), vjust = -0.5) +  # Add labels
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "red") +  # Add line
  annotate("text", x = 100, y = 200, 
           label = "Upregulated", color = "blue", fontface = "italic") +  # Add annotation
  theme_minimal()
```

## Practice Exercises

1. Create a scatter plot showing the relationship between control_1 and control_2 values
2. Make a box plot comparing expression levels across pathways
3. Create a heatmap of log2-transformed expression values
4. Make a histogram of fold changes between treated and control conditions

```r
# Exercise 1: Scatter plot of technical replicates
ggplot(gene_data, aes(x = control_1, y = control_2, label = gene_id)) +
  geom_point() +
  geom_text(vjust = -0.5) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "red") +
  labs(title = "Technical Replicates Comparison",
       x = "Control Replicate 1",
       y = "Control Replicate 2") +
  theme_minimal()

# Exercise 2: Box plot by pathway
ggplot(gene_data_long, aes(x = pathway, y = expression, fill = pathway)) +
  geom_boxplot() +
  labs(title = "Expression Levels by Pathway",
       x = "Pathway",
       y = "Expression Level") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
```

## Tips for Creating Good Plots

1. **Keep it Simple**
   - Don't overload your plots with unnecessary information
   - Use clear, readable fonts and appropriate sizes
   - Choose colors wisely (consider color-blind friendly options)

2. **Label Everything**
   - Always include axis labels
   - Use informative titles
   - Add units where appropriate

3. **Consider Your Audience**
   - Make sure your plot tells a clear story
   - Use appropriate scales
   - Add explanatory notes if needed

4. **Technical Tips**
   - Save high-resolution versions for publications
   - Be consistent with styling across related plots
   - Test your plots with different data sizes

## Next Steps

After mastering these basics, you can explore:
- Interactive plots with plotly
- Multiple plots with patchwork
- Custom themes and color palettes
- Statistical visualizations
- Publication-ready figure preparation 
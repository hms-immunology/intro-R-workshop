---
title: Data Manipulation
layout: default
nav_order: 7
parent: Class Materials
---

# Data Manipulation with dplyr and tidyr

[<img src="https://img.shields.io/badge/Download-HTML-blue?style=for-the-badge&logo=html5" alt="Download HTML" />](../rendered-html/data-manipulation.html)
[<img src="https://img.shields.io/badge/Download-R_Markdown-green?style=for-the-badge&logo=r" alt="Download R Markdown" />](data-manipulation.Rmd)

## Introduction to the Tidyverse

The tidyverse is a collection of R packages designed for data science that share a common philosophy and design. In this lesson, we'll focus on two core packages:

- **dplyr**: For data manipulation
- **tidyr**: For data tidying and reshaping

## Helpful Resources

Before we begin, here are some valuable resources to keep handy:

1. **RStudio Cheat Sheets**: 
   - [Data Transformation with dplyr](https://github.com/rstudio/cheatsheets/blob/main/data-transformation.pdf)
   - [Data Tidying with tidyr](https://github.com/rstudio/cheatsheets/blob/main/tidyr.pdf)
   These cheat sheets provide quick references for the functions we'll be using.

2. **Keyboard Shortcuts**:
   - Pipe operator (`%>%`): Ctrl/Cmd + Shift + M
   - Assignment operator (`<-`): Alt + - (Windows/Linux) or Option + - (Mac)

Keep these resources open in another tab while working through the examples - they're incredibly helpful for remembering function names and arguments!

## Sample Dataset

We'll use a gene expression dataset to demonstrate these concepts:

```r
# Create a sample gene expression dataset
gene_data <- tibble(
  gene_id = c("BRCA1", "TP53", "EGFR", "KRAS", "HER2"),
  control_1 = c(100, 150, 80, 200, 120),
  control_2 = c(110, 140, 85, 190, 125),
  treated_1 = c(200, 300, 90, 180, 240),
  treated_2 = c(190, 280, 95, 185, 230),
  chromosome = c("17", "17", "7", "12", "17"),
  pathway = c("DNA repair", "Cell cycle", "Growth", "Signaling", "Growth")
)
```

## Understanding the Pipe Operator (`%>%`)

The pipe operator (`%>%`) is fundamental to writing clear and readable code in R. It takes the output from one function and passes it as the first argument to the next function.

### Traditional vs. Piped Syntax

```r
# Traditional nested syntax
mean(sqrt(abs(log(c(1:10)))))

# Same operation with pipes
c(1:10) %>%
  log() %>%
  abs() %>%
  sqrt() %>%
  mean()

# Example with our gene data
# Traditional syntax
head(arrange(filter(gene_data, chromosome == "17"), desc(control_1)))

# Same operation with pipes
gene_data %>%
  filter(chromosome == "17") %>%
  arrange(desc(control_1)) %>%
  head()
```

### Why Use Pipes?

1. **Readability**: Pipes make code easier to read by showing the sequence of operations from left to right
2. **Maintainability**: Each step in the analysis is clearly separated, making it easier to modify or debug
3. **Reduced Nesting**: Eliminates the need for nested function calls or multiple intermediate objects
4. **Code Organization**: Makes it clear how data flows through a series of transformations

## Data Manipulation with dplyr

### 1. Selecting Columns (select)

The `select()` function helps you choose which columns to keep or remove:

```r
# Select specific columns
gene_data %>%
  select(gene_id, control_1, treated_1)

# Select columns by pattern
gene_data %>%
  select(starts_with("control"))

# Remove columns
gene_data %>%
  select(-ends_with("2"))
```

### 2. Filtering Rows (filter)

Use `filter()` to subset rows based on conditions:

```r
# Filter genes on chromosome 17
gene_data %>%
  filter(chromosome == "17")

# Multiple conditions
gene_data %>%
  filter(chromosome == "17", control_1 > 100)

# Complex conditions
gene_data %>%
  filter(pathway %in% c("Growth", "Signaling"))
```

### 3. Creating New Columns (mutate)

`mutate()` adds new columns based on calculations:

```r
# Calculate mean expression for controls and treated
gene_data %>%
  mutate(
    mean_control = (control_1 + control_2) / 2,
    mean_treated = (treated_1 + treated_2) / 2,
    fold_change = mean_treated / mean_control
  )

# Log transform expression values
gene_data %>%
  mutate(across(
    .cols = c(control_1, control_2, treated_1, treated_2),
    .fns = log2,
    .names = "log2_{.col}"
  ))
```

### 4. Summarizing Data (summarize/summarise)

`summarize()` creates summary statistics:

```r
# Calculate mean expression per condition
gene_data %>%
  summarise(
    mean_control_1 = mean(control_1),
    mean_treated_1 = mean(treated_1),
    n_genes = n()
  )

# Group by pathway and summarize
gene_data %>%
  group_by(pathway) %>%
  summarise(
    n_genes = n(),
    mean_control = mean(control_1),
    mean_treated = mean(treated_1)
  )
```

## Data Tidying with tidyr

### 1. Reshaping Data (pivot_longer and pivot_wider)

Data often comes in different formats, and we frequently need to convert between them:

- **Wide format**: Each sample/condition is in a separate column
  - Good for: Viewing data in spreadsheets, manual data entry
  - Example use: When you want to see all measurements for a gene in one row

- **Long format**: Each observation is in a separate row
  - Good for: Statistical analysis, plotting with ggplot2, most modeling functions
  - Example use: When you need to compare conditions or create box plots

```r
# Convert to long format
gene_data_long <- gene_data %>%
  pivot_longer(
    cols = c(control_1, control_2, treated_1, treated_2),
    names_to = "sample",
    values_to = "expression"
  )

# Convert back to wide format
gene_data_long %>%
  pivot_wider(
    names_from = sample,
    values_from = expression
  )
```

## Practice Exercises

### Exercise 1: Data Manipulation
Using the gene expression dataset:
1. Filter for genes with high expression (> 200) in any sample
2. Calculate the fold change between treated and control conditions
3. Sort genes by fold change

```r
gene_data %>%
  mutate(
    mean_control = (control_1 + control_2) / 2,
    mean_treated = (treated_1 + treated_2) / 2,
    fold_change = mean_treated / mean_control
  ) %>%
  filter(mean_control > 200 | mean_treated > 200) %>%
  arrange(desc(fold_change))
```

### Exercise 2: Data Reshaping
1. Convert the data to long format
2. Calculate summary statistics by group
3. Create a visualization of the results

```r
gene_data_long <- gene_data %>%
  pivot_longer(
    cols = c(control_1, control_2, treated_1, treated_2),
    names_to = "sample",
    values_to = "expression"
  ) %>%
  mutate(
    condition = if_else(str_detect(sample, "control"), "Control", "Treated")
  )

# Calculate summary statistics
gene_data_long %>%
  group_by(gene_id, condition) %>%
  summarise(
    mean_expr = mean(expression),
    sd_expr = sd(expression)
  )
```

## Next Steps

After mastering these basics, you can move on to:
- Advanced data manipulation techniques
- Working with grouped data
- Complex data transformations
- Combining multiple operations with pipes 
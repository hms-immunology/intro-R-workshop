---
title: Data Manipulation
layout: default
nav_order: 6
parent: Class Materials
---

# Data Manipulation with dplyr and tidyr

[<img src="https://img.shields.io/badge/Download-HTML-blue?style=for-the-badge&logo=html5" alt="Download HTML" />](../rendered-html/data-manipulation.html)
[<img src="https://img.shields.io/badge/Download-R_Markdown-green?style=for-the-badge&logo=r" alt="Download R Markdown" />](data-manipulation.Rmd)

## Introduction to the Tidyverse

The tidyverse is a collection of R packages designed for data science that share a common philosophy and design. In this lesson, we'll focus on two core packages:

- **dplyr**: For data manipulation
- **tidyr**: For data tidying and reshaping

Let's start by loading the required packages:

```r
# Install packages if not already installed
if (!require("tidyverse")) install.packages("tidyverse")

# Load the tidyverse (includes dplyr and tidyr)
library(tidyverse)

# Results:
# ── Attaching core tidyverse packages ──
# ✔ dplyr     1.1.0     ✔ readr     2.1.4
# ✔ forcats   1.0.0     ✔ stringr   1.5.0
# ✔ ggplot2   3.4.1     ✔ tibble    3.1.8
# ✔ lubridate 1.9.2     ✔ tidyr     1.3.0
# ✔ purrr     1.0.1     
```

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

# Results:
# # A tibble: 5 × 7
#   gene_id control_1 control_2 treated_1 treated_2 chromosome pathway   
#   <chr>      <dbl>     <dbl>     <dbl>     <dbl> <chr>      <chr>     
# 1 BRCA1        100       110       200       190 17         DNA repair
# 2 TP53         150       140       300       280 17         Cell cycle
# 3 EGFR          80        85        90        95 7          Growth    
# 4 KRAS         200       190       180       185 12         Signaling 
# 5 HER2         120       125       240       230 17         Growth    
```

## Data Manipulation with dplyr

### 1. Selecting Columns (select)

The `select()` function helps you choose which columns to keep or remove:

```r
# Select specific columns
gene_data %>%
  select(gene_id, control_1, treated_1)

# Results:
# # A tibble: 5 × 3
#   gene_id control_1 treated_1
#   <chr>      <dbl>     <dbl>
# 1 BRCA1        100       200
# 2 TP53         150       300
# 3 EGFR          80        90
# 4 KRAS         200       180
# 5 HER2         120       240

# Select columns by pattern
gene_data %>%
  select(starts_with("control"))

# Results:
# # A tibble: 5 × 2
#   control_1 control_2
#      <dbl>     <dbl>
# 1      100       110
# 2      150       140
# 3       80        85
# 4      200       190
# 5      120       125

# Remove columns
gene_data %>%
  select(-ends_with("2"))

# Results:
# # A tibble: 5 × 5
#   gene_id control_1 treated_1 chromosome pathway   
#   <chr>      <dbl>     <dbl> <chr>      <chr>     
# 1 BRCA1        100       200 17         DNA repair
# 2 TP53         150       300 17         Cell cycle
# 3 EGFR          80        90 7          Growth    
# 4 KRAS         200       180 12         Signaling 
# 5 HER2         120       240 17         Growth    
```

### 2. Filtering Rows (filter)

Use `filter()` to subset rows based on conditions:

```r
# Filter genes on chromosome 17
gene_data %>%
  filter(chromosome == "17")

# Results:
# # A tibble: 3 × 7
#   gene_id control_1 control_2 treated_1 treated_2 chromosome pathway   
#   <chr>      <dbl>     <dbl>     <dbl>     <dbl> <chr>      <chr>     
# 1 BRCA1        100       110       200       190 17         DNA repair
# 2 TP53         150       140       300       280 17         Cell cycle
# 3 HER2         120       125       240       230 17         Growth    

# Multiple conditions
gene_data %>%
  filter(chromosome == "17", control_1 > 100)

# Results:
# # A tibble: 2 × 7
#   gene_id control_1 control_2 treated_1 treated_2 chromosome pathway   
#   <chr>      <dbl>     <dbl>     <dbl>     <dbl> <chr>      <chr>     
# 1 TP53         150       140       300       280 17         Cell cycle
# 2 HER2         120       125       240       230 17         Growth    

# Complex conditions
gene_data %>%
  filter(pathway %in% c("Growth", "Signaling"))

# Results:
# # A tibble: 3 × 7
#   gene_id control_1 control_2 treated_1 treated_2 chromosome pathway  
#   <chr>      <dbl>     <dbl>     <dbl>     <dbl> <chr>      <chr>    
# 1 EGFR          80        85        90        95 7          Growth   
# 2 KRAS         200       190       180       185 12         Signaling
# 3 HER2         120       125       240       230 17         Growth   
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

# Results:
# # A tibble: 5 × 10
#   gene_id control_1 control_2 treated_1 treated_2 chromosome pathway mean_control mean_treated fold_change
#   <chr>      <dbl>     <dbl>     <dbl>     <dbl> <chr>      <chr>         <dbl>       <dbl>       <dbl>
# 1 BRCA1        100       110       200       190 17         DNA repair      105         195        1.86
# 2 TP53         150       140       300       280 17         Cell cycle      145         290        2.00
# 3 EGFR          80        85        90        95 7          Growth          82.5         92.5      1.12
# 4 KRAS         200       190       180       185 12         Signaling      195         182.5      0.936
# 5 HER2         120       125       240       230 17         Growth         122.5       235        1.92

# Log transform expression values
gene_data %>%
  mutate(across(
    .cols = c(control_1, control_2, treated_1, treated_2),
    .fns = log2,
    .names = "log2_{.col}"
  ))

# Results:
# # A tibble: 5 × 11
#   gene_id control_1 control_2 treated_1 treated_2 chromosome pathway log2_control_1 log2_control_2 log2_treated_1 log2_treated_2
#   <chr>      <dbl>     <dbl>     <dbl>     <dbl> <chr>      <chr>           <dbl>          <dbl>          <dbl>          <dbl>
# 1 BRCA1        100       110       200       190 17         DNA repair        6.64           6.78           7.64           7.57
# 2 TP53         150       140       300       280 17         Cell cycle        7.23           7.13           8.23           8.13
# 3 EGFR          80        85        90        95 7          Growth           6.32           6.41           6.49           6.57
# 4 KRAS         200       190       180       185 12         Signaling        7.64           7.57           7.49           7.53
# 5 HER2         120       125       240       230 17         Growth           6.91           6.97           7.91           7.85
```

## Advanced dplyr Operations

### Joining Data Frames

Often we need to combine information from multiple data frames. Let's create a second dataset with additional gene information:

```r
# Create a second dataset with gene annotations
gene_annotations <- tibble(
  gene_id = c("BRCA1", "TP53", "EGFR", "KRAS", "HER2", "PTEN"),
  full_name = c("Breast Cancer 1", "Tumor Protein 53", "Epidermal Growth Factor Receptor",
                "KRAS Proto-Oncogene", "Human Epidermal Growth Factor Receptor 2", 
                "Phosphatase and Tensin Homolog"),
  is_oncogene = c(FALSE, FALSE, TRUE, TRUE, TRUE, FALSE)
)

# Inner join - only keep genes present in both datasets
gene_data %>%
  inner_join(gene_annotations, by = "gene_id")

# Results:
# # A tibble: 5 × 9
#   gene_id control_1 control_2 treated_1 treated_2 chromosome pathway    full_name                                  is_oncogene
#   <chr>      <dbl>     <dbl>     <dbl>     <dbl> <chr>      <chr>      <chr>                                     <lgl>      
# 1 BRCA1        100       110       200       190 17         DNA repair Breast Cancer 1                           FALSE      
# 2 TP53         150       140       300       280 17         Cell cycle Tumor Protein 53                          FALSE      
# 3 EGFR          80        85        90        95 7          Growth     Epidermal Growth Factor Receptor          TRUE       
# 4 KRAS         200       190       180       185 12         Signaling  KRAS Proto-Oncogene                      TRUE       
# 5 HER2         120       125       240       230 17         Growth     Human Epidermal Growth Factor Receptor 2  TRUE       

# Left join - keep all genes from gene_data
gene_data %>%
  left_join(gene_annotations, by = "gene_id")

# Results: Same as inner join in this case since all genes in gene_data are in gene_annotations

# Full join - keep all genes from both datasets
gene_data %>%
  full_join(gene_annotations, by = "gene_id")

# Results:
# # A tibble: 6 × 9
#   gene_id control_1 control_2 treated_1 treated_2 chromosome pathway    full_name                                  is_oncogene
#   <chr>      <dbl>     <dbl>     <dbl>     <dbl> <chr>      <chr>      <chr>                                     <lgl>      
# 1 BRCA1        100       110       200       190 17         DNA repair Breast Cancer 1                           FALSE      
# 2 TP53         150       140       300       280 17         Cell cycle Tumor Protein 53                          FALSE      
# 3 EGFR          80        85        90        95 7          Growth     Epidermal Growth Factor Receptor          TRUE       
# 4 KRAS         200       190       180       185 12         Signaling  KRAS Proto-Oncogene                      TRUE       
# 5 HER2         120       125       240       230 17         Growth     Human Epidermal Growth Factor Receptor 2  TRUE       
# 6 PTEN          NA        NA        NA        NA NA         NA         Phosphatase and Tensin Homolog           FALSE      
```

### Set Operations

dplyr provides functions for set operations between data frames:

```r
# Create two datasets with some overlapping genes
set1 <- gene_data %>% filter(chromosome == "17")
set2 <- gene_data %>% filter(pathway == "Growth")

# Union - combine unique rows
bind_rows(set1, set2) %>% distinct()

# Results:
# # A tibble: 4 × 7
#   gene_id control_1 control_2 treated_1 treated_2 chromosome pathway   
#   <chr>      <dbl>     <dbl>     <dbl>     <dbl> <chr>      <chr>     
# 1 BRCA1        100       110       200       190 17         DNA repair
# 2 TP53         150       140       300       280 17         Cell cycle
# 3 HER2         120       125       240       230 17         Growth    
# 4 EGFR          80        85        90        95 7          Growth    

# Intersect - find common rows
inner_join(set1, set2, by = names(set1))

# Results:
# # A tibble: 1 × 7
#   gene_id control_1 control_2 treated_1 treated_2 chromosome pathway
#   <chr>      <dbl>     <dbl>     <dbl>     <dbl> <chr>      <chr> 
# 1 HER2         120       125       240       230 17         Growth

# Setdiff - find rows in set1 not in set2
anti_join(set1, set2, by = names(set1))

# Results:
# # A tibble: 2 × 7
#   gene_id control_1 control_2 treated_1 treated_2 chromosome pathway   
#   <chr>      <dbl>     <dbl>     <dbl>     <dbl> <chr>      <chr>     
# 1 BRCA1        100       110       200       190 17         DNA repair
# 2 TP53         150       140       300       280 17         Cell cycle
```

## Creating Custom Functions for Data Manipulation

### Basic Function Creation

Let's create a function to calculate fold change between treated and control conditions:

```r
# Create a function to calculate fold change
calculate_fold_change <- function(data) {
  data %>%
    mutate(
      mean_control = (control_1 + control_2) / 2,
      mean_treated = (treated_1 + treated_2) / 2,
      fold_change = mean_treated / mean_control
    ) %>%
    select(gene_id, mean_control, mean_treated, fold_change)
}

# Use the function
gene_data %>% calculate_fold_change()

# Results:
# # A tibble: 5 × 4
#   gene_id mean_control mean_treated fold_change
#   <chr>         <dbl>        <dbl>       <dbl>
# 1 BRCA1          105          195         1.86
# 2 TP53           145          290         2   
# 3 EGFR            82.5         92.5       1.12
# 4 KRAS           195          182.5       0.936
# 5 HER2           122.5        235         1.92
```

### Functions with Multiple Arguments

Let's create a more flexible function that allows us to specify thresholds:

```r
# Create a function to filter and summarize expression data
analyze_expression <- function(data, fold_change_threshold = 1.5, 
                             min_expression = 100) {
  data %>%
    calculate_fold_change() %>%
    filter(
      fold_change >= fold_change_threshold | fold_change <= 1/fold_change_threshold,
      mean_control >= min_expression | mean_treated >= min_expression
    ) %>%
    arrange(desc(abs(fold_change)))
}

# Use the function with default parameters
gene_data %>% analyze_expression()

# Results:
# # A tibble: 3 × 4
#   gene_id mean_control mean_treated fold_change
#   <chr>         <dbl>        <dbl>       <dbl>
# 1 TP53           145          290        2    
# 2 HER2           122.5        235        1.92 
# 3 BRCA1          105          195        1.86 

# Use the function with custom parameters
gene_data %>% analyze_expression(fold_change_threshold = 1.8, min_expression = 150)

# Results:
# # A tibble: 2 × 4
#   gene_id mean_control mean_treated fold_change
#   <chr>         <dbl>        <dbl>       <dbl>
# 1 TP53           145          290         2   
# 2 HER2           122.5        235         1.92
```

### Creating Pipeline Functions

Let's create a function that combines multiple analysis steps:

```r
# Create a comprehensive analysis pipeline
analyze_gene_expression <- function(data, annotation_data) {
  data %>%
    # Calculate fold changes
    calculate_fold_change() %>%
    # Join with annotations
    left_join(annotation_data, by = "gene_id") %>%
    # Add significance categories
    mutate(
      regulation = case_when(
        fold_change >= 2 ~ "Strongly Up",
        fold_change >= 1.5 ~ "Up",
        fold_change <= 0.5 ~ "Strongly Down",
        fold_change <= 0.67 ~ "Down",
        TRUE ~ "Unchanged"
      )
    ) %>%
    # Group and summarize by pathway
    group_by(pathway, regulation) %>%
    summarise(
      gene_count = n(),
      genes = paste(gene_id, collapse = ", "),
      .groups = "drop"
    )
}

# Use the pipeline function
gene_data %>% 
  analyze_gene_expression(gene_annotations %>% select(gene_id, is_oncogene))

# Results:
# # A tibble: 5 × 4
#   pathway    regulation  gene_count genes            
#   <chr>      <chr>           <int> <chr>            
# 1 Cell cycle Strongly Up         1 TP53             
# 2 DNA repair Up                  1 BRCA1            
# 3 Growth     Strongly Up         1 HER2             
# 4 Growth     Unchanged           1 EGFR             
# 5 Signaling  Unchanged           1 KRAS             
```

### Practice Exercises

1. Create a function that normalizes expression values using z-scores for each condition (control and treated separately).
2. Write a function that identifies genes with consistent fold changes (similar values between replicates).
3. Create a pipeline function that:
   - Calculates fold changes
   - Performs statistical tests
   - Generates a summary report with significant genes

### Tips for Creating Functions

1. **Start Simple**: Begin with a basic function and add complexity gradually
2. **Use Clear Names**: Choose descriptive names for functions and arguments
3. **Document Your Functions**: Add comments explaining what the function does
4. **Handle Edge Cases**: Consider what happens with missing or invalid data
5. **Test Your Functions**: Try different inputs to ensure your function works as expected

Next, we'll look at some common mistakes to avoid and best practices for data manipulation.

## Common Mistakes and Best Practices

### Common Mistakes to Avoid

1. **Forgetting to Handle Missing Values**
```r
# Bad: Missing values might cause unexpected results
data %>% 
  mutate(ratio = value_1 / value_2)  # Will produce NA for any missing value_2

# Good: Handle missing values explicitly
data %>%
  mutate(ratio = if_else(is.na(value_2) | value_2 == 0, NA_real_, value_1 / value_2))
```

2. **Modifying Data Without Checking**
```r
# Bad: Directly modifying without inspection
data %>% mutate(across(everything(), as.numeric))

# Good: Check data types and validate conversions
data %>%
  summarise(across(everything(), ~class(.))) %>%
  glimpse()  # Inspect before converting
```

3. **Inefficient Group Operations**
```r
# Bad: Unnecessary grouping/ungrouping
data %>%
  group_by(group1) %>%
  summarise(mean_val = mean(value)) %>%
  ungroup() %>%
  group_by(group1) %>%  # Unnecessary regrouping
  mutate(centered = value - mean_val)

# Good: Maintain grouping when needed
data %>%
  group_by(group1) %>%
  mutate(
    mean_val = mean(value),
    centered = value - mean_val
  ) %>%
  ungroup()
```

### Best Practices

1. **Code Organization**
   - Keep related operations together
   - Use meaningful intermediate variables
   - Break complex pipelines into smaller steps

```r
# Good organization
gene_analysis <- function(data) {
  # Step 1: Calculate basic statistics
  basic_stats <- data %>%
    group_by(gene_id) %>%
    summarise(
      mean_expr = mean(c(control_1, control_2, treated_1, treated_2)),
      sd_expr = sd(c(control_1, control_2, treated_1, treated_2))
    )
  
  # Step 2: Calculate fold changes
  fold_changes <- data %>%
    calculate_fold_change()
  
  # Step 3: Combine results
  results <- basic_stats %>%
    left_join(fold_changes, by = "gene_id")
  
  return(results)
}
```

2. **Performance Optimization**
   - Use `summarise()` instead of `mutate()` when reducing data
   - Avoid unnecessary type conversions
   - Filter early in the pipeline to reduce data size

```r
# Bad: Late filtering
data %>%
  mutate(complex_calculation = expensive_function(value)) %>%
  filter(group == "target")  # Should filter first

# Good: Early filtering
data %>%
  filter(group == "target") %>%
  mutate(complex_calculation = expensive_function(value))
```

3. **Documentation and Reproducibility**
   - Add comments for complex operations
   - Include example usage
   - Document expected inputs and outputs

```r
#' Calculate differential expression statistics
#'
#' @param data A tibble with columns: gene_id, control_1, control_2, treated_1, treated_2
#' @param fc_threshold Minimum fold change threshold (default: 1.5)
#' @return A tibble with differential expression statistics
#' @examples
#' gene_data %>% calculate_diff_expression(fc_threshold = 2)
calculate_diff_expression <- function(data, fc_threshold = 1.5) {
  # Function implementation...
}
```

### Final Tips

1. Always validate your data before complex operations
2. Use appropriate data types for better performance
3. Keep your pipelines modular and reusable
4. Test your functions with different input scenarios
5. Document your code as you write it

Remember: The goal is to write code that is not only functional but also maintainable and reproducible by others.

[Continue with the rest of the content, including results for each code block...] 
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

Let's start by loading the required packages:

```r
# Install packages if not already installed
if (!require("tidyverse")) install.packages("tidyverse")

# Load the tidyverse (includes dplyr and tidyr)
library(tidyverse)
```

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

Before diving into data manipulation, let's understand the pipe operator (`%>%`), which is fundamental to writing clear and readable code in R.

### What is Piping?

The pipe operator (`%>%`) takes the output from one function and passes it as the first argument to the next function. It helps write code that can be read from left to right, making it more intuitive and easier to understand.

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

### Pro Tips for Using Pipes

1. Start with the data object
2. Add one operation per line
3. Indent lines after the first pipe
4. Use pipes for 2 or more operations
5. In RStudio, type `Ctrl/Cmd + Shift + M` to insert the pipe operator

```r
# Example of well-formatted piped operations
result <- gene_data %>%
  filter(chromosome == "17") %>%
  select(gene_id, control_1, treated_1) %>%
  mutate(fold_change = treated_1 / control_1) %>%
  arrange(desc(fold_change))
```

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
  filter(chromosome == "17", 
         control_1 > 100)

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

Data often comes in different formats, and we frequently need to convert between them for different types of analysis:

- **Wide format**: Each sample/condition is in a separate column (e.g., control_1, control_2, treated_1, treated_2)
  - Good for: Viewing data in spreadsheets, manual data entry
  - Example use: When you want to see all measurements for a gene in one row

- **Long format**: Each observation is in a separate row
  - Good for: Statistical analysis, plotting with ggplot2, most modeling functions
  - Example use: When you need to compare conditions or create box plots

Common reasons for converting formats:
1. **Visualization**: Many plotting functions (especially ggplot2) prefer long format
2. **Statistical Analysis**: Functions like t.test() and ANOVA expect data in long format
3. **Data Manipulation**: Some calculations are easier in one format vs. another
4. **Data Export**: Different tools might require specific formats

Let's see this in practice:

```r
# Convert to long format
gene_data_long <- gene_data %>%
  pivot_longer(
    cols = c(control_1, control_2, treated_1, treated_2),
    names_to = "sample",
    values_to = "expression"
  )

# Convert back to wide format
gene_data_wide <- gene_data_long %>%
  pivot_wider(
    names_from = sample,
    values_from = expression
  )
```

### 2. Separating and Uniting Columns

Sometimes we need to split or combine columns:

```r
# Add a column with gene info to split
gene_data_info <- gene_data %>%
  mutate(gene_info = paste(gene_id, chromosome, sep = "_chr"))

# Separate the gene_info column
gene_data_info %>%
  separate(gene_info, 
          into = c("gene", "chromosome"),
          sep = "_chr")

# Unite columns back together
gene_data_info %>%
  separate(gene_info, 
          into = c("gene", "chromosome"),
          sep = "_chr") %>%
  unite("gene_chr", gene, chromosome, sep = "_chr")
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

# Left join - keep all genes from gene_data
gene_data %>%
  left_join(gene_annotations, by = "gene_id")

# Full join - keep all genes from both datasets
gene_data %>%
  full_join(gene_annotations, by = "gene_id")
```

### Set Operations

dplyr provides functions for set operations between data frames:

```r
# Create two datasets with some overlapping genes
set1 <- gene_data %>% filter(chromosome == "17")
set2 <- gene_data %>% filter(pathway == "Growth")

# Union - combine unique rows
bind_rows(set1, set2) %>% distinct()

# Intersect - find common rows
inner_join(set1, set2, by = names(set1))

# Setdiff - find rows in set1 not in set2
anti_join(set1, set2, by = names(set1))
```

### Advanced Grouping Operations

```r
# Group by multiple columns
gene_data %>%
  group_by(chromosome, pathway) %>%
  summarise(
    n_genes = n(),
    mean_expression = mean(control_1),
    .groups = "drop"
  )

# Grouped mutations
gene_data %>%
  group_by(chromosome) %>%
  mutate(
    rel_expression = control_1 / mean(control_1),
    rank = min_rank(desc(control_1))
  ) %>%
  ungroup()
```

## Creating Custom Functions

### Basic Function Creation

```r
# Create a function to calculate fold change
calculate_fold_change <- function(treated, control) {
  if (any(control <= 0)) {
    warning("Control values should be positive")
    return(NA)
  }
  return(treated / control)
}

# Use the function with mutate
gene_data %>%
  mutate(
    fc_1 = calculate_fold_change(treated_1, control_1),
    fc_2 = calculate_fold_change(treated_2, control_2)
  )
```

### Functions with Multiple Arguments

```r
# Function to filter and summarize expression data
analyze_expression <- function(data, chr = NULL, min_expression = 0) {
  # Start with the data
  result <- data
  
  # Filter by chromosome if specified
  if (!is.null(chr)) {
    result <- result %>% filter(chromosome == chr)
  }
  
  # Apply expression threshold
  result <- result %>%
    filter(control_1 > min_expression) %>%
    mutate(
      mean_control = (control_1 + control_2) / 2,
      mean_treated = (treated_1 + treated_2) / 2,
      fold_change = mean_treated / mean_control
    ) %>%
    select(gene_id, chromosome, pathway, mean_control, mean_treated, fold_change)
  
  return(result)
}

# Use the custom function
gene_data %>%
  analyze_expression(chr = "17", min_expression = 100)
```

### Creating Pipeline Functions

```r
# Function to perform standard analysis pipeline
standard_analysis <- function(data, group_col) {
  group_col <- enquo(group_col)  # Quote the grouping column
  
  data %>%
    group_by(!!group_col) %>%
    summarise(
      n_genes = n(),
      mean_expression = mean(control_1),
      up_regulated = sum(treated_1 > control_1),
      down_regulated = sum(treated_1 < control_1),
      .groups = "drop"
    ) %>%
    mutate(
      pct_up = up_regulated / n_genes * 100,
      pct_down = down_regulated / n_genes * 100
    )
}

# Use the pipeline function
gene_data %>%
  standard_analysis(pathway)
```

## Practice Exercises

### Exercise 1: Data Manipulation
Using the gene_data dataset:
1. Filter for genes on chromosome 17
2. Calculate the fold change between treated and control conditions
3. Select only gene_id and fold change columns

```r
gene_data %>%
  filter(chromosome == "17") %>%
  mutate(
    mean_control = (control_1 + control_2) / 2,
    mean_treated = (treated_1 + treated_2) / 2,
    fold_change = mean_treated / mean_control
  ) %>%
  select(gene_id, fold_change)
```

### Exercise 2: Data Reshaping
1. Convert the expression data to long format
2. Calculate mean expression per condition
3. Create a summary of fold changes per pathway

```r
# Convert to long format and summarize
gene_data %>%
  pivot_longer(
    cols = c(control_1, control_2, treated_1, treated_2),
    names_to = "sample",
    values_to = "expression"
  ) %>%
  group_by(gene_id, pathway) %>%
  summarise(
    mean_expression = mean(expression),
    .groups = "drop"
  )
```

### Exercise 3: Custom Functions
1. Create a function to normalize expression values
2. Apply the function to both control and treated samples
3. Calculate statistics on the normalized values

```r
# Create normalization function
normalize_expression <- function(x) {
  (x - mean(x)) / sd(x)
}

# Apply to data
gene_data %>%
  mutate(across(
    .cols = c(control_1, control_2, treated_1, treated_2),
    .fns = normalize_expression,
    .names = "norm_{.col}"
  )) %>%
  select(gene_id, starts_with("norm_"))
```

## Next Steps

After mastering these basics, you can move on to:
- Advanced data manipulation techniques
- Working with grouped data
- Complex data transformations
- Combining multiple operations with pipes 
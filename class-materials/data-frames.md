---
title: Working with Data Frames
layout: default
nav_order: 8
---

# Working with Data Frames in R

[<img src="https://img.shields.io/badge/Download-HTML-blue?style=for-the-badge&logo=html5" alt="Download HTML" />](../rendered-html/data-frames.html)
[<img src="https://img.shields.io/badge/Download-R_Markdown-green?style=for-the-badge&logo=r" alt="Download R Markdown" />](data-frames.Rmd)

## Introduction

Data frames are one of the most commonly used data structures in R. They are particularly useful for working with tabular data, such as gene expression datasets, clinical data, or experimental results. A data frame is a 2-dimensional structure where:

- Each column can contain different types of data (numeric, character, logical)
- All columns must have the same length
- Each column has a unique name

## Creating Data Frames

### Method 1: From Scratch

```r
# Create a simple data frame
df <- data.frame(
  patient_id = c("P001", "P002", "P003", "P004"),
  age = c(45, 52, 38, 61),
  diabetic = c(TRUE, FALSE, FALSE, TRUE)
)

# Results:
#   patient_id age diabetic
# 1      P001  45    TRUE
# 2      P002  52   FALSE
# 3      P003  38   FALSE
# 4      P004  61    TRUE

# Structure of the data frame:
# 'data.frame': 4 obs. of 3 variables:
#  $ patient_id: chr "P001" "P002" "P003" "P004"
#  $ age      : num 45 52 38 61
#  $ diabetic : logi TRUE FALSE FALSE TRUE
```

### Method 2: From Existing Vectors

```r
# Create vectors (similar to our previous RNA-seq examples)
gene_names <- c("BRCA1", "TP53", "EGFR", "KRAS", "HER2")
expression_values <- c(1543.7, 2345.2, 1234.5, 876.3, 2345.6)
is_significant <- c(TRUE, TRUE, FALSE, FALSE, TRUE)
p_values <- c(0.001, 0.0001, 0.08, 0.07, 0.001)
fold_changes <- c(2.5, 3.2, 1.1, 0.9, 2.8)

# Combine into a data frame
gene_expression_df <- data.frame(
  gene = gene_names,
  expression = expression_values,
  significant = is_significant,
  p_value = p_values,
  fold_change = fold_changes
)

# Results:
#    gene expression significant p_value fold_change
# 1 BRCA1    1543.7       TRUE  0.0010        2.5
# 2  TP53    2345.2       TRUE  0.0001        3.2
# 3  EGFR    1234.5      FALSE  0.0800        1.1
# 4  KRAS     876.3      FALSE  0.0700        0.9
# 5  HER2    2345.6       TRUE  0.0010        2.8
```

### Method 3: Reading from Files

```r
# Create a sample CSV file
write.csv(gene_expression_df, "gene_expression.csv", row.names = FALSE)

# Read it back
df_from_csv <- read.csv("gene_expression.csv")

# Results will be identical to the original data frame
```

## Examining Data Frames

```r
# Basic information about the data frame
dim(gene_expression_df)  # Returns [5, 5] (5 rows, 5 columns)

# Column names
names(gene_expression_df)  # Returns: "gene" "expression" "significant" "p_value" "fold_change"

# Summary statistics
# Results:
#      gene            expression     significant       p_value         fold_change   
# BRCA1:1   Min.   : 876.3   Mode :logical   Min.   :0.0001   Min.   :0.900  
# EGFR :1   1st Qu.:1234.5   FALSE:2         1st Qu.:0.0010   1st Qu.:1.100  
# HER2 :1   Median :1543.7   TRUE :3         Median :0.0010   Median :2.500  
# KRAS :1   Mean   :1669.1                   Mean   :0.0304   Mean   :2.100  
# TP53 :1   3rd Qu.:2345.2                   3rd Qu.:0.0700   3rd Qu.:2.800  
#           Max.   :2345.6                   Max.   :0.0800   Max.   :3.200  
```

## Accessing Elements in Data Frames

### 1. Accessing Columns

```r
# Using $ notation
expression_values <- gene_expression_df$expression
# Results: 1543.7 2345.2 1234.5 876.3 2345.6

# Using column name with brackets
p_values <- gene_expression_df["p_value"]
# Results:
#   p_value
# 1  0.0010
# 2  0.0001
# 3  0.0800
# 4  0.0700
# 5  0.0010

# Multiple columns
selected_cols <- gene_expression_df[c("gene", "fold_change")]
# Results:
#    gene fold_change
# 1 BRCA1        2.5
# 2  TP53        3.2
# 3  EGFR        1.1
# 4  KRAS        0.9
# 5  HER2        2.8
```

### 2. Accessing Rows

```r
# Single row
row_1 <- gene_expression_df[1, ]
# Results:
#    gene expression significant p_value fold_change
# 1 BRCA1    1543.7       TRUE   0.001        2.5

# Multiple rows
rows_2_4 <- gene_expression_df[2:4, ]
# Results:
#   gene expression significant p_value fold_change
# 2 TP53    2345.2       TRUE  0.0001        3.2
# 3 EGFR    1234.5      FALSE  0.0800        1.1
# 4 KRAS     876.3      FALSE  0.0700        0.9
```

### 3. Accessing Specific Elements

```r
# Single element using row and column numbers
element <- gene_expression_df[1, 2]  # First row, second column
# Result: 1543.7 (expression value for BRCA1)

# Single element using row number and column name
p_val <- gene_expression_df[2, "p_value"]
# Result: 0.0001 (p-value for TP53)

# Multiple elements
subset <- gene_expression_df[1:2, c("gene", "expression")]
# Results:
#    gene expression
# 1 BRCA1    1543.7
# 2  TP53    2345.2
```

## Filtering Data Frames

### 1. Using Logical Conditions

```r
# Find significantly expressed genes
significant_genes <- gene_expression_df[gene_expression_df$significant == TRUE, ]
# Results:
#    gene expression significant p_value fold_change
# 1 BRCA1    1543.7       TRUE  0.0010        2.5
# 2  TP53    2345.2       TRUE  0.0001        3.2
# 5  HER2    2345.6       TRUE  0.0010        2.8

# Find highly expressed genes
high_expression <- gene_expression_df[gene_expression_df$expression > 2000, ]
# Results:
#   gene expression significant p_value fold_change
# 2 TP53    2345.2       TRUE  0.0001        3.2
# 5 HER2    2345.6       TRUE  0.0010        2.8

# Multiple conditions
important_genes <- gene_expression_df[
  gene_expression_df$significant == TRUE & 
  gene_expression_df$fold_change > 2.5, 
]
# Results:
#   gene expression significant p_value fold_change
# 2 TP53    2345.2       TRUE  0.0001        3.2
# 5 HER2    2345.6       TRUE  0.0010        2.8
```

### 2. Using which() Function

```r
# Find indices of significant genes
sig_indices <- which(gene_expression_df$significant)
# Results: 1 2 5

# Use indices to get rows
sig_genes <- gene_expression_df[sig_indices, ]
# Results same as significant_genes above
```

## Modifying Data Frames

### 1. Adding Columns

```r
# Add a single column
gene_expression_df$log2_expression <- log2(gene_expression_df$expression)

# Add multiple columns at once
gene_expression_df <- cbind(
  gene_expression_df,
  neg_log10_pvalue = -log10(gene_expression_df$p_value),
  pass_filter = gene_expression_df$p_value < 0.05
)

# Results:
#    gene expression significant p_value fold_change log2_expression neg_log10_pvalue pass_filter
# 1 BRCA1    1543.7       TRUE  0.0010        2.5        10.5934           3.0000       TRUE
# 2  TP53    2345.2       TRUE  0.0001        3.2        11.1952           4.0000       TRUE
# 3  EGFR    1234.5      FALSE  0.0800        1.1        10.2697           1.0969      FALSE
# 4  KRAS     876.3      FALSE  0.0700        0.9         9.7754           1.1549      FALSE
# 5  HER2    2345.6       TRUE  0.0010        2.8        11.1957           3.0000       TRUE
```

### 2. Adding Rows

```r
# Create a new row
new_gene <- data.frame(
  gene = "BRAF",
  expression = 1876.5,
  significant = TRUE,
  p_value = 0.002,
  fold_change = 2.1,
  log2_expression = log2(1876.5),
  neg_log10_pvalue = -log10(0.002),
  pass_filter = TRUE
)

# Add the row
gene_expression_df <- rbind(gene_expression_df, new_gene)

# Results: New row added to the bottom of the data frame
```

### 3. Modifying Values

```r
# Change a single value
gene_expression_df$expression[1] <- 1600

# Change multiple values
gene_expression_df$significant[gene_expression_df$p_value > 0.05] <- FALSE

# Results will show updated values in the data frame
```
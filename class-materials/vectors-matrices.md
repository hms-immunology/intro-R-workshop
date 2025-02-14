---
title: Vectors and Matrices in R
layout: default
nav_order: 7
---

# Vectors and Matrices in R

[<img src="https://img.shields.io/badge/Download-HTML-blue?style=for-the-badge&logo=html5" alt="Download HTML" />](../rendered-html/vectors-matrices.html)
[<img src="https://img.shields.io/badge/Download-R_Markdown-green?style=for-the-badge&logo=r" alt="Download R Markdown" />](vectors-matrices.Rmd)

## Introduction

In R, vectors and matrices are fundamental data structures that allow us to work with collections of data. They are especially important in bioinformatics and RNA-seq analysis, where we often need to handle large sets of gene expression values or sample measurements.

## Vectors

A vector is a one-dimensional array that can hold elements of the same type (numeric, character, or logical).

### Creating Vectors

There are several ways to create vectors in R:

```r
# Create vectors for different types of gene expression data
gene_expression <- c(156.7, 238.9, 184.3, 145.6)  # Raw expression values
gene_names <- c("BRCA1", "TP53", "EGFR", "KRAS")  # Gene identifiers
is_significant <- c(TRUE, FALSE, TRUE, TRUE)       # Significance flags

# Create sequences for different purposes
sample_numbers <- 1:10                             # Create sequence from 1 to 10
time_points <- seq(0, 48, by = 6)                 # Create sequence from 0 to 48 in steps of 6 hours

# RNA-seq data manipulation example
raw_counts <- c(1200, 1500, 800, 2000)           # Raw read counts from sequencing
scaling_factor <- 0.5                             # Normalization factor
normalized_counts <- raw_counts * scaling_factor  # Apply normalization

# Compare expression between conditions
control_expression <- c(100, 150, 80, 200)        # Expression values in control samples
treated_expression <- c(150, 180, 90, 250)        # Expression values in treated samples
expression_difference <- treated_expression - control_expression  # Calculate absolute difference
fold_change <- treated_expression / control_expression  # Calculate fold change

# Calculate basic statistics for a vector
length(gene_names)                                # Count number of genes
mean(raw_counts)                                  # Calculate average read count
median(raw_counts)                                # Find middle value
max(raw_counts)                                   # Find highest count
min(raw_counts)                                   # Find lowest count
sum(raw_counts)                                   # Total read count

# Sort values in different ways
sorted_counts <- sort(raw_counts)                 # Sort counts in ascending order
sorted_counts_desc <- sort(raw_counts, decreasing = TRUE)  # Sort in descending order

# Access vector elements by position
first_gene <- gene_names[1]                       # Get first gene name
selected_genes <- gene_names[c(1, 3)]             # Get first and third gene names

# Filter elements using logical conditions
high_expression <- raw_counts > 1000              # Create logical vector for high expression
high_expressed_genes <- gene_names[high_expression]  # Get names of highly expressed genes

# Use which() to find positions meeting criteria
significant_indices <- which(is_significant)      # Get indices of significant genes
significant_genes <- gene_names[significant_indices]  # Get names of significant genes

# Create a matrix from expression data
expression_matrix <- matrix(
  c(100, 200, 150, 300,    # Expression values for sample 1
    120, 180, 160, 280,    # Expression values for sample 2
    90, 220, 170, 320),    # Expression values for sample 3
  nrow = 3,                # Number of rows (genes)
  ncol = 4,                # Number of columns (samples)
  byrow = TRUE             # Fill matrix by rows
)

# Add row and column names to matrix
rownames(expression_matrix) <- c("Gene1", "Gene2", "Gene3")  # Label genes
colnames(expression_matrix) <- c("Sample1", "Sample2", "Sample3", "Sample4")  # Label samples

# Perform matrix operations
transposed_matrix <- t(expression_matrix)         # Transpose matrix (swap rows and columns)
correlation_matrix <- t(expression_matrix) %*% expression_matrix  # Calculate correlation matrix
scaled_matrix <- expression_matrix * 2            # Multiply all values by 2
log_matrix <- log2(expression_matrix)             # Convert to log2 scale

# Access matrix elements
value <- expression_matrix[1, 2]                  # Get value for Gene1, Sample2
gene1_expression <- expression_matrix[1, ]        # Get all values for Gene1
sample1_values <- expression_matrix[, 1]          # Get all values for Sample1
subset_matrix <- expression_matrix[1:2, c(1,3)]   # Get values for first two genes in samples 1 and 3

# Create RNA-seq expression matrix with replicates
expression_data <- matrix(
  c(
    1200, 1300, 1250, 1800, 1900, 1850,  # Expression values for Gene1
    800,  750,  780,  1200, 1180, 1220,   # Expression values for Gene2
    2000, 2100, 2050, 2080, 2150, 2090,   # Expression values for Gene3
    300,  320,  310,  900,  920,  880,    # Expression values for Gene4
    1500, 1450, 1480, 1600, 1580, 1620    # Expression values for Gene5
  ),
  nrow = 5,                               # 5 genes
  ncol = 6,                               # 6 samples (3 control, 3 treated)
  byrow = TRUE                            # Fill matrix by rows
)

# Label rows and columns
rownames(expression_data) <- c("Gene1", "Gene2", "Gene3", "Gene4", "Gene5")  # Gene names
colnames(expression_data) <- c("Ctrl1", "Ctrl2", "Ctrl3", "Treat1", "Treat2", "Treat3")  # Sample names

# Calculate mean expression for each condition
control_means <- rowMeans(expression_data[, 1:3])    # Mean of control replicates
treated_means <- rowMeans(expression_data[, 4:6])    # Mean of treated replicates

# Calculate fold changes
fold_changes <- treated_means / control_means         # Ratio of treated to control means

# Identify differentially expressed genes
is_differential <- abs(fold_changes) > 1.5           # Genes with >1.5-fold change
differential_genes <- rownames(expression_data)[is_differential]  # Names of differential genes

# Practice exercises
exp_condition1 <- c(1200, 800, 2000, 300, 1500)     # Expression values for condition 1
exp_condition2 <- c(1800, 1200, 2080, 900, 1600)    # Expression values for condition 2

# Calculate statistics
mean_exp1 <- mean(exp_condition1)                    # Average expression in condition 1
mean_exp2 <- mean(exp_condition2)                    # Average expression in condition 2

# Find highly expressed genes
high_exp1 <- exp_condition1 > 1000                   # Logical vector for high expression in condition 1
high_exp2 <- exp_condition2 > 1000                   # Logical vector for high expression in condition 2

# Calculate fold changes between conditions
fold_changes <- exp_condition2 / exp_condition1       # Ratio of condition 2 to condition 1

# Extract specific genes from matrix
gene1_expression <- expression_data["Gene1", ]        # Expression profile of Gene1

# Calculate mean expression per sample
sample_means <- colMeans(expression_data)             # Average expression in each sample

# Find highest expressed gene in each sample
max_expression <- apply(expression_data, 2, which.max)  # Index of highest expressed gene per sample
highest_genes <- rownames(expression_data)[max_expression]  # Names of highest expressed genes

# Create and transform sample matrix
sample_matrix <- matrix(rnorm(20, mean=100, sd=20),  # Generate random expression data
                       nrow=4,                        # 4 genes
                       ncol=5)                        # 5 samples
rownames(sample_matrix) <- paste0("Gene", 1:4)       # Label genes
colnames(sample_matrix) <- paste0("Sample", 1:5)     # Label samples

# Transform data
log_data <- log2(sample_matrix)                      # Convert to log2 scale
scaled_data <- t(scale(t(log_data)))                 # Scale and center the data

# Results:
# Gene Expression Values: 156.7, 238.9, 184.3, 145.6
# Gene Names: "BRCA1", "TP53", "EGFR", "KRAS"
# Time Points: 0, 6, 12, 18, 24, 30, 36, 42, 48
```

### Vector Operations

Vectors in R support element-wise operations:

```r
# RNA-seq example: normalizing expression values
raw_counts <- c(1200, 1500, 800, 2000)
scaling_factor <- 0.5
normalized_counts <- raw_counts * scaling_factor

# Adding vectors
control_expression <- c(100, 150, 80, 200)
treated_expression <- c(150, 180, 90, 250)
expression_difference <- treated_expression - control_expression

# Calculate fold change
fold_change <- treated_expression / control_expression

# Results:
# Normalized counts: 600, 750, 400, 1000
# Expression difference: 50, 30, 10, 50
# Fold change: 1.5, 1.2, 1.125, 1.25
```

### Vector Functions

R provides many useful functions for working with vectors:

```r
# Length of a vector
length(gene_names)  # Returns 4

# Summary statistics
mean(raw_counts)    # 1375
median(raw_counts)  # 1350
max(raw_counts)     # 2000
min(raw_counts)     # 800
sum(raw_counts)     # 5500

# Sort values
sorted_counts <- sort(raw_counts)
sorted_counts_desc <- sort(raw_counts, decreasing = TRUE)

# Results:
# Sorted counts (ascending): 800, 1200, 1500, 2000
# Sorted counts (descending): 2000, 1500, 1200, 800
```

### Accessing Vector Elements

Elements in vectors can be accessed using indices or logical conditions:

```r
# By position (index)
first_gene <- gene_names[1]  # Gets "BRCA1"
selected_genes <- gene_names[c(1, 3)]  # Gets "BRCA1" and "EGFR"

# By logical condition
high_expression <- raw_counts > 1000
high_expressed_genes <- gene_names[high_expression]

# Using which() function
significant_indices <- which(is_significant)
significant_genes <- gene_names[significant_indices]

# Results:
# First gene: "BRCA1"
# Selected genes: "BRCA1", "EGFR"
# Highly expressed genes: "BRCA1", "TP53", "KRAS"
```

## Matrices

Matrices are two-dimensional arrays that also hold elements of the same type. They are particularly useful for representing expression data where rows might be genes and columns might be samples.

### Creating Matrices

```r
# Create a matrix from vectors
expression_matrix <- matrix(
  c(100, 200, 150, 300,
    120, 180, 160, 280,
    90, 220, 170, 320),
  nrow = 3,
  ncol = 4,
  byrow = TRUE
)

# Add row and column names
rownames(expression_matrix) <- c("Gene1", "Gene2", "Gene3")
colnames(expression_matrix) <- c("Sample1", "Sample2", "Sample3", "Sample4")

# Results:
#        Sample1 Sample2 Sample3 Sample4
# Gene1     100     200     150     300
# Gene2     120     180     160     280
# Gene3      90     220     170     320
```

### Matrix Operations

```r
# Transpose a matrix
transposed_matrix <- t(expression_matrix)

# Matrix multiplication
correlation_matrix <- t(expression_matrix) %*% expression_matrix

# Element-wise operations
scaled_matrix <- expression_matrix * 2
log_matrix <- log2(expression_matrix)

# Results shown in scientific notation for correlation matrix
```

### Accessing Matrix Elements

```r
# Access single element
value <- expression_matrix[1, 2]  # Row 1, Column 2: 200

# Access entire row
gene1_expression <- expression_matrix[1, ]  # 100, 200, 150, 300

# Access entire column
sample1_values <- expression_matrix[, 1]  # 100, 120, 90

# Access multiple rows/columns
subset_matrix <- expression_matrix[1:2, c(1,3)]

# Results:
#        Sample1 Sample3
# Gene1     100     150
# Gene2     120     160
```

## RNA-seq Example: Differential Expression Analysis

```r
# Create an expression matrix with 5 genes and 6 samples (3 control, 3 treated)
expression_data <- matrix(
  c(
    1200, 1300, 1250, 1800, 1900, 1850,  # Gene1
    800,  750,  780,  1200, 1180, 1220,   # Gene2
    2000, 2100, 2050, 2080, 2150, 2090,   # Gene3
    300,  320,  310,  900,  920,  880,    # Gene4
    1500, 1450, 1480, 1600, 1580, 1620    # Gene5
  ),
  nrow = 5,
  ncol = 6,
  byrow = TRUE
)

# Add gene and sample names
rownames(expression_data) <- c("Gene1", "Gene2", "Gene3", "Gene4", "Gene5")
colnames(expression_data) <- c("Ctrl1", "Ctrl2", "Ctrl3", "Treat1", "Treat2", "Treat3")

# Calculate mean expression for control and treated groups
control_means <- rowMeans(expression_data[, 1:3])
treated_means <- rowMeans(expression_data[, 4:6])

# Calculate fold changes
fold_changes <- treated_means / control_means

# Identify differentially expressed genes (fold change > 1.5)
is_differential <- abs(fold_changes) > 1.5
differential_genes <- rownames(expression_data)[is_differential]

# Results:
# Control Means: 1250, 776.7, 2050, 310, 1476.7
# Treated Means: 1850, 1200, 2106.7, 900, 1600
# Fold Changes: 1.48, 1.54, 1.03, 2.90, 1.08
# Differentially Expressed Genes: "Gene2", "Gene4"
```

## Practice Exercises

### Exercise 1: Vector Operations
Create two vectors of gene expression values and perform calculations:

```r
# Create vectors
exp_condition1 <- c(1200, 800, 2000, 300, 1500)
exp_condition2 <- c(1800, 1200, 2080, 900, 1600)

# Calculate mean expression
mean_exp1 <- mean(exp_condition1)  # 1160
mean_exp2 <- mean(exp_condition2)  # 1516

# Find highly expressed genes
high_exp1 <- exp_condition1 > 1000  # TRUE, FALSE, TRUE, FALSE, TRUE
high_exp2 <- exp_condition2 > 1000  # TRUE, TRUE, TRUE, FALSE, TRUE

# Calculate fold changes
fold_changes <- exp_condition2 / exp_condition1  # 1.5, 1.5, 1.04, 3.0, 1.07
```

### Exercise 2: Matrix Manipulation
Using the example RNA-seq matrix:

```r
# Extract specific genes
gene1_expression <- expression_data["Gene1", ]  # 1200, 1300, 1250, 1800, 1900, 1850

# Calculate mean expression per sample
sample_means <- colMeans(expression_data)
# Results: Ctrl1=1160, Ctrl2=1184, Ctrl3=1174, Treat1=1516, Treat2=1546, Treat3=1532

# Find highest expressed gene in each sample
max_expression <- apply(expression_data, 2, which.max)
highest_genes <- rownames(expression_data)[max_expression]
# Results: "Gene3" for all samples
```

### Exercise 3: Data Transformation
Create a matrix of expression values and transform it:

```r
# Create a sample matrix
sample_matrix <- matrix(rnorm(20, mean=100, sd=20), nrow=4, ncol=5)
rownames(sample_matrix) <- paste0("Gene", 1:4)
colnames(sample_matrix) <- paste0("Sample", 1:5)

# Log transform
log_data <- log2(sample_matrix)

# Scale rows
scaled_data <- t(scale(t(log_data)))

# Results will vary due to random data generation
```

## Next Steps

After mastering vectors and matrices, you can move on to:
- Working with data frames
- Statistical analysis and hypothesis testing
- Advanced visualization techniques
- Machine learning applications in R 
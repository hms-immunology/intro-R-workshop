---
title: Objects and Variables in R
layout: default
nav_order: 6
---

# Objects and Variables in R

[<img src="https://img.shields.io/badge/Download-HTML-blue?style=for-the-badge&logo=html5" alt="Download HTML" />](../rendered-html/objects-variables.html)
[<img src="https://img.shields.io/badge/Download-R_Markdown-green?style=for-the-badge&logo=r" alt="Download R Markdown" />](objects-variables.Rmd)

## Introduction

In R, we work with objects to store and manipulate data. Understanding how to create and work with objects is fundamental to using R effectively. This lesson will cover the basics of working with objects and variables in R, using examples relevant to medical and health sciences, including RNA sequencing analysis.

## Creating Objects

In R, we create objects using the assignment operator `<-` (or `=`). The basic syntax is:

```r
# Creating a numeric object (gene expression value)
expression_level <- 1543.7

# Creating a text (character) object
gene_name <- "BRCA1"

# Creating a logical object
is_differentially_expressed <- TRUE

# Results:
# Expression level: 1543.7
# Gene name: "BRCA1"
# Is differentially expressed? TRUE
```

### Pro Tip
In RStudio, you can type `Alt + -` (Windows/Linux) or `Option + -` (Mac) to create the assignment operator `<-` in one keystroke!

## Naming Conventions

When naming objects in R, follow these guidelines:

✅ **Good Names:**
- Use descriptive names: `read_count`, `expression_level`
- Start with letters: `gene_1`, `sample_id`
- Use underscores for spaces: `fold_change`

❌ **Avoid:**
- Starting with numbers: `2nd_replicate` (invalid)
- Using spaces: `gene expression` (invalid)
- Using special characters: `gene@1` (invalid)
- Using R reserved words: `if`, `else`, `function`

## Working with Objects

Once you create an object, you can use it in calculations or operations:

```r
# RNA-seq example: calculating fold change
control_expression <- 100
treated_expression <- 200
fold_change <- treated_expression / control_expression

# Results:
# Fold change: 2

# Medical example: BMI calculation
weight_kg <- 70.5
height_m <- 1.75
bmi <- weight_kg / (height_m^2)

# Results:
# BMI: 23.02
```

## Practice Challenges

### Challenge 1: Basic Calculations
Try to predict the values after each operation:

```r
read_count <- 1000       # What is read_count?
scaling_factor <- 1.5    # What is scaling_factor?
read_count <- read_count * scaling_factor  # Now what is read_count?
normalized_count <- read_count / 10     # What is normalized_count?

# Results:
# Final read count: 1500
# Normalized count: 150
```

### Challenge 2: Temperature Conversion
Convert a patient's temperature from Celsius to Fahrenheit using the formula: °F = (°C × 9/5) + 32

```r
# Convert temperature
temp_celsius <- 37.5  # Normal body temperature
temp_fahrenheit <- (temp_celsius * 9/5) + 32

# Results:
# 37.5°C = 99.5°F
```

### Challenge 3: Sample Information
Create three variables and combine them into a single sentence:

```r
sample_id <- "RNA_01"
gene_name <- "TP53"
expression_value <- 2456

message <- paste("Sample", sample_id, "shows", expression_value, "counts for gene", gene_name)

# Results:
# "Sample RNA_01 shows 2456 counts for gene TP53"
```

## Common Mistakes and How to Avoid Them

1. **Case Sensitivity**
```r
# These are three different objects!
expression <- 5000
Expression <- 6000
EXPRESSION <- 7000
```

```r
# Results:
# expression: 5000
# Expression: 6000
# EXPRESSION: 7000
```

2. **Overwriting Objects**

```r
read_depth <- 1000000
# Results: read_depth is 1000000

read_depth <- 1500000  # The original value (1000000) is now gone
# Results: read_depth is now 1500000
```

3. **Invalid Names**
```r
# This won't work:
1st_sample <- 5  # Invalid: starts with number
sample name <- "Control"  # Invalid: contains space
```

## Tips for Success

1. Always use clear, descriptive names for your objects
2. Be consistent with your naming style (e.g., `gene_name`, `sample_id`)
3. Check your objects exist by typing their name
4. Use the `ls()` function to see all objects in your environment
5. Use `rm(object_name)` to remove objects you no longer need

```r
# List all objects in environment
ls()
# Results: Shows all object names in current environment

# Remove an object
rm(expression)
# Results: 'expression' is removed from environment
```

## Next Steps

After mastering basic objects and variables, you can move on to:
- Working with data vectors and matrices
- Understanding data types and structures
- Learning how to create and use functions
- Working with data frames

## Exercise Solutions

### Challenge 1 Solution:
```r
read_count <- 1000              # read_count is 1000
scaling_factor <- 1.5           # scaling_factor is 1.5
read_count <- read_count * scaling_factor  # read_count is now 1500
normalized_count <- read_count / 10        # normalized_count is now 150
```

### Challenge 2 Solution:
```r
temp_celsius <- 37.5
temp_fahrenheit <- (temp_celsius * 9/5) + 32  # Result: 99.5°F
```

### Challenge 3 Solution:
```r
sample_id <- "RNA_01"
gene_name <- "TP53"
expression_value <- 2456
message <- paste("Sample", sample_id, "shows", expression_value, "counts for gene", gene_name)
# Result: "Sample RNA_01 shows 2456 counts for gene TP53"
```

## Additional Details

### Basic variable assignment in R
x <- 5                     # Assign the value 5 to variable x using the assignment operator '<-'
y = 10                     # Alternative assignment using '=' (though '<-' is preferred in R)
z <- x + y                 # Perform arithmetic and store result in new variable

### Numeric vectors
numbers <- c(1, 2, 3, 4, 5)           # Create a numeric vector using c() function
more_numbers <- 1:10                   # Create a sequence from 1 to 10
seq_numbers <- seq(0, 10, by = 2)     # Create sequence with custom step size

### Character vectors
names <- c("Alice", "Bob", "Charlie")  # Create a character vector
fruits <- c("apple", "banana", "orange")  # Another character vector example

### Logical vectors
is_true <- c(TRUE, FALSE, TRUE)        # Create a logical vector
bigger_than_5 <- numbers > 5           # Create logical vector through comparison

### Factors (categorical variables)
gender <- factor(c("M", "F", "F", "M"))  # Create a factor from character vector
levels(gender)                           # View the levels of the factor

### Lists (can contain different types)
my_list <- list(
  numbers = 1:5,                      # Numeric vector element
  text = "Hello World",              # Character element
  logical = TRUE                     # Logical element
)

### Accessing list elements
my_list$numbers                      # Access using $ operator
my_list[[1]]                        # Access using double brackets
my_list[["text"]]                   # Access by name using double brackets

### Data frames
df <- data.frame(
  name = c("Alice", "Bob", "Charlie"),     # Character vector for names
  age = c(25, 30, 35),                     # Numeric vector for ages
  student = c(TRUE, FALSE, TRUE)           # Logical vector for student status
)

### Accessing data frame elements
df$name                             # Access column by name using $
df[1, ]                            # Access first row
df[, "age"]                        # Access age column
df[df$student == TRUE, ]           # Filter rows where student is TRUE

### Basic data types
numeric_var <- 42.5                # Numeric (double)
integer_var <- 42L                 # Integer (note the L suffix)
character_var <- "Hello"           # Character string
logical_var <- TRUE                # Logical (boolean)
complex_var <- 3 + 2i              # Complex number

### Type checking functions
class(numeric_var)                 # Check the class of an object
typeof(numeric_var)                # Check the type of an object
is.numeric(numeric_var)           # Check if object is numeric
is.character(character_var)       # Check if object is character

### Type conversion
as.character(42)                  # Convert number to character
as.numeric("42")                 # Convert character to number
as.logical(1)                    # Convert to logical (0 is FALSE, non-zero is TRUE)

### Vector operations
vec1 <- c(1, 2, 3)              # First vector
vec2 <- c(4, 5, 6)              # Second vector
vec_sum <- vec1 + vec2          # Element-wise addition
vec_prod <- vec1 * vec2         # Element-wise multiplication
vec_mean <- mean(vec1)          # Calculate mean of vector
vec_sum <- sum(vec1)            # Calculate sum of vector

### Matrix creation
mat <- matrix(1:9, nrow = 3, ncol = 3)  # Create 3x3 matrix
rownames(mat) <- c("R1", "R2", "R3")    # Add row names
colnames(mat) <- c("C1", "C2", "C3")    # Add column names

### Matrix operations
t(mat)                          # Transpose matrix
mat * 2                         # Multiply all elements by 2
mat %*% mat                     # Matrix multiplication

### Working with missing values
vec_with_na <- c(1, NA, 3, NA, 5)       # Vector with missing values
is.na(vec_with_na)                      # Check for NA values
na.omit(vec_with_na)                    # Remove NA values
mean(vec_with_na, na.rm = TRUE)         # Calculate mean ignoring NA values

### Variable naming conventions
camelCase <- "follows Java style"        # camelCase naming
snake_case <- "follows Python style"     # snake_case naming (common in R)
CONSTANT_VALUE <- 100                    # Constants typically in all caps

### Environment functions
ls()                                    # List all variables in environment
rm(x)                                  # Remove variable x from environment 
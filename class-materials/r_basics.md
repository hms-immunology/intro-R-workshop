---
title: R Programming Basics
layout: default
nav_order: 2
parent: Course Materials
---

# R Programming Basics

[<img src="https://img.shields.io/badge/Download-HTML-blue?style=for-the-badge&logo=html5" alt="Download HTML" />](../rendered-html/r_basics.html)
[<img src="https://img.shields.io/badge/Download-R_Markdown-green?style=for-the-badge&logo=r" alt="Download R Markdown" />](r_basics.Rmd)

## Getting Started with R

R is a powerful programming language designed for statistical computing and data analysis. This tutorial will cover the fundamental concepts you need to get started with R programming.

### Using R as a Calculator

R can be used as a simple calculator. Type expressions directly in the console:

```r
# Basic arithmetic operations
2 + 2       # Addition
10 - 5      # Subtraction
4 * 3       # Multiplication
15 / 3      # Division
2^3         # Exponentiation

# Results:
# Addition: 2 + 2 = 4
# Subtraction: 10 - 5 = 5
# Multiplication: 4 * 3 = 12
# Division: 15 / 3 = 5
# Exponentiation: 2^3 = 8
```

### Objects and Variables

In R, you can store values in objects using the assignment operator `<-` (or `=`):

```r
# Creating objects
x <- 10
my_number = 42
text <- "Hello, R!"

# Results:
# Value of x: 10
# Value of my_number: 42
# Value of text: "Hello, R!"
```

### Data Types in R

R has several basic data types:

```r
# Numeric
age <- 25

# Character (string)
name <- "John"

# Logical (boolean)
is_student <- TRUE

# Results:
# Type of 'age': "numeric"
# Type of 'name': "character"
# Type of 'is_student': "logical"
```

### Vectors

Vectors are one-dimensional arrays that can hold data of the same type:

```r
# Create a vector using c()
numbers <- c(1, 2, 3, 4, 5)
fruits <- c("apple", "banana", "orange")

# Vector operations
numbers_plus_2 <- numbers + 2     # Adds 2 to each element: 3, 4, 5, 6, 7
numbers_times_3 <- numbers * 3     # Multiplies each element by 3: 3, 6, 9, 12, 15

# Vector indexing (starts at 1, not 0)
first_number <- numbers[1]      # First element: 1
second_fruit <- fruits[2]       # Second element: "banana"
```

### Saving Objects

There are several ways to save R objects for later use:

```r
# Create some objects to save
numbers <- c(1, 2, 3, 4, 5)
fruits <- c("apple", "banana", "orange")

# Save a single object to a .RData file
save(numbers, file = "my_numbers.RData")

# Save multiple objects
save(numbers, fruits, file = "my_objects.RData")

# Save entire workspace
save.image(file = "workspace.RData")

# Load saved objects
load("my_numbers.RData")
```

### Working with Files

You can write data to and read data from files:

```r
# Create a data frame to write
df <- data.frame(
  numbers = 1:5,
  letters = LETTERS[1:5]
)

# Write a CSV file
write.csv(df, file = "example.csv", row.names = FALSE)

# Read the CSV file back
data <- read.csv("example.csv")
```

### Getting Help

R has excellent built-in documentation:

```r
# Get help on a function
?mean
help(sum)

# See examples
example(mean)
```

## Practice Exercises

Try these exercises to test your understanding:

### Exercise 1: Create and Manipulate a Vector
```r
# Create a numeric vector with numbers 1 through 10
my_vector <- 1:10

# Calculate the mean
vector_mean <- mean(my_vector)  # Result: 5.5
```

### Exercise 2: Working with Different Data Types
```r
# Create a character vector with three colors
colors <- c("red", "blue", "green")

# Create a list combining numeric and character vectors
my_list <- list(
  numbers = my_vector,
  colors = colors
)
```

## Next Steps

After mastering these basics, you can move on to:
- Data frames and tibbles
- Basic plotting with base R
- Installing and using packages
- Basic statistical functions
- Control structures (if/else, loops)

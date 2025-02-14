---
title: R Programming Basics
layout: default
nav_order: 4
---

# R Programming Basics

[<img src="https://img.shields.io/badge/Download-HTML-blue?style=for-the-badge&logo=html5" alt="Download HTML" />](../rendered-html/r_basics.html)
[<img src="https://img.shields.io/badge/Download-R_Markdown-green?style=for-the-badge&logo=r" alt="Download R Markdown" />](r_basics.Rmd)

## Getting Started with R

R is a powerful programming language designed for statistical computing and data analysis. This tutorial will cover the fundamental concepts you need to get started with R programming.

### Using R as a Calculator

R can be used as a simple calculator. Type expressions directly in the console:

```r
# Basic arithmetic operations in R
2 + 2                  # Addition
10 - 5                 # Subtraction
4 * 3                  # Multiplication
15 / 3                 # Division
2^3                    # Exponentiation
10 %% 3                # Modulo (remainder)
10 %/% 3              # Integer division

# Variable assignment and basic operations
x <- 10                # Assign value 10 to variable x
y <- 5                 # Assign value 5 to variable y
z <- x + y            # Add x and y, store result in z
result <- x * y       # Multiply x and y, store in result

# Working with vectors
numbers <- c(1, 2, 3, 4, 5)          # Create numeric vector
letters <- c("a", "b", "c")          # Create character vector
logical_vec <- c(TRUE, FALSE, TRUE)  # Create logical vector

# Vector operations
sum(numbers)                         # Sum all elements
mean(numbers)                        # Calculate mean
length(numbers)                      # Get vector length
sort(numbers)                        # Sort vector
rev(numbers)                         # Reverse vector

# Sequence generation
seq_1 <- 1:10                       # Create sequence from 1 to 10
seq_2 <- seq(0, 10, by = 2)         # Sequence with step size 2
rep_vec <- rep(1:3, times = 2)      # Repeat sequence

# Basic data types
numeric_val <- 42.5                 # Numeric (double)
integer_val <- 42L                  # Integer
character_val <- "Hello"            # Character string
logical_val <- TRUE                 # Logical (boolean)

# Type checking and conversion
class(numeric_val)                  # Check object class
is.numeric(numeric_val)             # Check if numeric
as.character(numeric_val)           # Convert to character
as.numeric("42.5")                  # Convert to numeric

# Basic statistical functions
data <- c(15, 20, 25, 30, 35)      # Sample data
mean(data)                         # Calculate mean
median(data)                       # Calculate median
sd(data)                          # Calculate standard deviation
var(data)                         # Calculate variance
range(data)                       # Get range (min and max)
summary(data)                     # Get summary statistics

# Working with missing values (NA)
data_with_na <- c(1, NA, 3, NA, 5)  # Vector with missing values
is.na(data_with_na)                 # Check for NA values
na.omit(data_with_na)               # Remove NA values
mean(data_with_na, na.rm = TRUE)    # Calculate mean ignoring NA

# Basic plotting
plot(1:10, type = "l")              # Line plot
hist(rnorm(100))                    # Histogram of random normal data
boxplot(data)                       # Box plot

# Basic string operations
text <- "Hello, World!"             # Create string
nchar(text)                         # Count characters
toupper(text)                       # Convert to uppercase
tolower(text)                       # Convert to lowercase
substr(text, 1, 5)                  # Extract substring

# Logical operations
a <- 10
b <- 5
a > b                               # Greater than
a < b                               # Less than
a == b                              # Equal to
a != b                              # Not equal to
a >= b                              # Greater than or equal to
a <= b                              # Less than or equal to

# Conditional statements
if (a > b) {                        # If statement
  print("a is greater than b")
} else {
  print("a is not greater than b")
}

# Basic functions
square <- function(x) {             # Define function
  return(x^2)                       # Return square of input
}
square(4)                           # Call function

# Working with packages
# install.packages("tidyverse")     # Install package (commented out)
library(stats)                      # Load built-in stats package
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

# R Programming Basics

## Getting Started with R

R is a powerful programming language designed for statistical computing and data analysis. This tutorial will cover the fundamental concepts you need to get started with R programming.

### Using R as a Calculator

R can be used as a simple calculator. Type expressions directly in the console:

```r
2 + 2       # Addition
10 - 5      # Subtraction
4 * 3       # Multiplication
15 / 3      # Division
2^3         # Exponentiation
```

### Objects and Variables

In R, you can store values in objects using the assignment operator `<-` (or `=`):

```r
# Creating objects
x <- 10
my_number = 42
text <- "Hello, R!"

# Print objects
print(x)
my_number    # Just typing the object name will print it
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

# Check the type of an object
class(age)      # "numeric"
class(name)     # "character"
class(is_student)   # "logical"
```

### Vectors

Vectors are one-dimensional arrays that can hold data of the same type:

```r
# Create a vector using c()
numbers <- c(1, 2, 3, 4, 5)
fruits <- c("apple", "banana", "orange")

# Vector operations
numbers + 2     # Adds 2 to each element
numbers * 3     # Multiplies each element by 3

# Vector indexing (starts at 1, not 0)
numbers[1]      # First element
fruits[2]       # Second element
```

### Saving Objects

There are several ways to save R objects for later use:

```r
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
# Write a CSV file
write.csv(numbers, file = "numbers.csv")

# Read a CSV file
data <- read.csv("numbers.csv")
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

1. Create a numeric vector with the numbers 1 through 10
2. Calculate the mean of your vector
3. Save your vector to a file
4. Create a new character vector with three of your favorite colors
5. Combine both vectors into a list and print it

## Next Steps

After mastering these basics, you can move on to:
- Data frames and tibbles
- Basic plotting with base R
- Installing and using packages
- Basic statistical functions
- Control structures (if/else, loops)

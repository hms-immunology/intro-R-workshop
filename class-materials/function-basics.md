---
title: Introduction to Functions in R
layout: default
nav_order: 12
---

# Introduction to Functions in R

[<img src="https://img.shields.io/badge/Download-HTML-blue?style=for-the-badge&logo=html5" alt="Download HTML" />](../rendered-html/function-basics.html)
[<img src="https://img.shields.io/badge/Download-R_Markdown-green?style=for-the-badge&logo=r" alt="Download R Markdown" />](function-basics.Rmd)

## Introduction to Functions in R

Functions are like recipes - they take ingredients (inputs), follow a set of instructions, and produce a result (output). In R, functions help us:
- Avoid repeating code
- Make our code more organized
- Make our code reusable

### Basic Function Structure

A function in R has this basic structure:
```r
function_name <- function(parameter1, parameter2) {
  # Function body - what the function does
  result <- # some operation
  return(result)
}
```

### Simple Function Examples

Let's start with some very simple functions:

```r
# 1. A function to calculate the square of a number
square_number <- function(x) {
  result <- x * x
  return(result)
}

# Try it out
square_number(5)  # Returns 25
square_number(3)  # Returns 9

# 2. A function to greet someone
greet_person <- function(name) {
  greeting <- paste("Hello,", name, "!")
  return(greeting)
}

# Try it out
greet_person("Alice")
greet_person("Bob")
```

### Functions with Multiple Parameters

```r
# 1. Calculate rectangle area
calculate_rectangle_area <- function(length, width) {
  area <- length * width
  return(area)
}

# Try it out
calculate_rectangle_area(5, 3)  # Returns 15

# 2. Create a personalized message
create_message <- function(name, age, hobby) {
  message <- paste(name, "is", age, "years old and loves", hobby)
  return(message)
}

# Try it out
create_message("Sarah", 25, "painting")
```

### Functions for Data Manipulation

Let's create some functions that work with data:

```r
# Create sample data
student_scores <- data.frame(
  name = c("Alice", "Bob", "Charlie", "Diana"),
  math = c(85, 92, 78, 95),
  science = c(92, 88, 85, 90),
  history = c(88, 85, 82, 87)
)

# 1. Function to calculate average score for a student
calculate_average <- function(math, science, history) {
  avg <- (math + science + history) / 3
  return(round(avg, 1))
}

# Apply to our data
student_scores$average <- with(student_scores, 
                             calculate_average(math, science, history))

# 2. Function to determine grade based on score
determine_grade <- function(score) {
  if (score >= 90) {
    return("A")
  } else if (score >= 80) {
    return("B")
  } else if (score >= 70) {
    return("C")
  } else {
    return("D")
  }
}

# Apply to our average scores
student_scores$grade <- sapply(student_scores$average, determine_grade)
```

### Functions with Default Values

Sometimes we want functions to have default values for parameters:

```r
# Function to calculate tip
calculate_tip <- function(bill_amount, tip_percentage = 15) {
  tip <- bill_amount * (tip_percentage / 100)
  return(round(tip, 2))
}

# Try it out
calculate_tip(50)  # Uses default 15% tip
calculate_tip(50, 20)  # Specifies 20% tip
```

### Functions That Return Multiple Values

Functions can return multiple values using a list:

```r
# Function to analyze a numeric vector
analyze_numbers <- function(numbers) {
  result <- list(
    mean = mean(numbers),
    median = median(numbers),
    std_dev = sd(numbers),
    range = max(numbers) - min(numbers)
  )
  return(result)
}

# Try it out with some numbers
test_scores <- c(85, 92, 78, 95, 88, 90)
analysis <- analyze_numbers(test_scores)

# Access individual results
analysis$mean
analysis$median
analysis$std_dev
analysis$range
```

### Practice Exercises

Try creating these functions on your own:

1. Create a function that converts temperature from Fahrenheit to Celsius
2. Create a function that takes a vector of numbers and returns both the sum and the product
3. Create a function that takes a student's name and scores and returns a formatted report

Here are the solutions:

```r
# 1. Temperature conversion
fahrenheit_to_celsius <- function(fahrenheit) {
  celsius <- (fahrenheit - 32) * (5/9)
  return(round(celsius, 1))
}

# Test it
fahrenheit_to_celsius(72)

# 2. Sum and product function
calculate_sum_product <- function(numbers) {
  list(
    sum = sum(numbers),
    product = prod(numbers)
  )
}

# Test it
calculate_sum_product(c(2, 3, 4))

# 3. Student report function
create_student_report <- function(name, scores) {
  avg_score <- mean(scores)
  max_score <- max(scores)
  min_score <- min(scores)
  
  report <- paste(
    "Student Report for", name, "\n",
    "Average Score:", round(avg_score, 1), "\n",
    "Highest Score:", max_score, "\n",
    "Lowest Score:", min_score
  )
  
  return(report)
}

# Test it
test_scores <- c(85, 92, 78, 95)
create_student_report("Alice", test_scores)
```

### Tips for Writing Good Functions

1. **Use Clear Names**: Function names should describe what they do
2. **Document Your Functions**: Add comments explaining what the function does
3. **Keep Functions Simple**: Each function should do one thing well
4. **Test Your Functions**: Always test with different inputs
5. **Handle Errors**: Consider what happens with unexpected inputs

### Common Mistakes to Avoid

1. Forgetting to return a value
2. Not checking input validity
3. Using global variables instead of parameters
4. Making functions too complex
5. Not testing edge cases

Try modifying these examples and creating your own functions to get more practice! 
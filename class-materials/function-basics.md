---
title: Introduction to Functions in R
layout: default
nav_order: 8
---

# Introduction to Functions in R

[<img src="https://img.shields.io/badge/Download-HTML-blue?style=for-the-badge&logo=html5" alt="Download HTML" />](../rendered-html/function_basics.html)
[<img src="https://img.shields.io/badge/Download-R_Markdown-green?style=for-the-badge&logo=r" alt="Download R Markdown" />](function_basics.Rmd)

## Introduction to Functions in R

Functions are like recipes - they take ingredients (inputs), follow a set of instructions, and produce a result (output). In R, functions help us:
- Avoid repeating code
- Make our code more organized
- Make our code reusable

### Basic Function Structure

A function in R has this basic structure:
```r
# Basic function structure in R
function_name <- function(parameter1, parameter2) {
  # Function body - what the function does
  result <- # some operation using parameters
  return(result)  # Send result back to caller
}
```

### Simple Function Examples

Let's start with some very simple functions:

```r
# 1. Simple function to calculate square of a number
square_number <- function(x) {
  result <- x * x     # Multiply number by itself
  return(result)      # Return the squared value
}

# Test the square_number function
square_number(5)  # Returns 25 (5 * 5)
square_number(3)  # Returns 9 (3 * 3)

# 2. Function to create personalized greeting
greet_person <- function(name) {
  greeting <- paste("Hello,", name, "!")  # Combine text with name
  return(greeting)                        # Return the complete greeting
}

# Test the greeting function
greet_person("Alice")  # Returns "Hello, Alice!"
greet_person("Bob")    # Returns "Hello, Bob!"
```

### Functions with Multiple Parameters

```r
# Function with multiple parameters
# 1. Calculate area of a rectangle
calculate_rectangle_area <- function(length, width) {
  area <- length * width    # Area formula: length × width
  return(area)             # Return calculated area
}

# Test rectangle area calculation
calculate_rectangle_area(5, 3)  # Returns 15 (5 × 3)

# 2. Create personalized message with multiple pieces of information
create_message <- function(name, age, hobby) {
  # Combine all information into a single message
  message <- paste(name, "is", age, "years old and loves", hobby)
  return(message)  # Return the complete message
}

# Test message creation
create_message("Sarah", 25, "painting")  # Returns complete sentence about Sarah
```

### Functions for Data Manipulation

Let's create some functions that work with data:

```r
# Create sample data for data manipulation examples
student_scores <- data.frame(
  name = c("Alice", "Bob", "Charlie", "Diana"),  # Student names
  math = c(85, 92, 78, 95),                      # Math scores
  science = c(92, 88, 85, 90),                   # Science scores
  history = c(88, 85, 82, 87)                    # History scores
)

# 1. Function to calculate average score for a student
calculate_average <- function(math, science, history) {
  avg <- (math + science + history) / 3  # Average of three subjects
  return(round(avg, 1))                  # Round to 1 decimal place
}

# Apply average calculation to our data
student_scores$average <- with(student_scores, 
                             calculate_average(math, science, history))

# 2. Function to determine letter grade based on numeric score
determine_grade <- function(score) {
  if (score >= 90) {           # 90 or above
    return("A")                # A grade
  } else if (score >= 80) {    # 80-89
    return("B")                # B grade
  } else if (score >= 70) {    # 70-79
    return("C")                # C grade
  } else {                     # Below 70
    return("D")                # D grade
  }
}

# Apply grade determination to average scores
student_scores$grade <- sapply(student_scores$average, determine_grade)
```

### Functions with Default Values

Sometimes we want functions to have default values for parameters:

```r
# Function with default parameter values
# Calculate tip amount with default 15% tip
calculate_tip <- function(bill_amount, tip_percentage = 15) {
  tip <- bill_amount * (tip_percentage / 100)  # Convert percentage to decimal
  return(round(tip, 2))                        # Round to 2 decimal places
}

# Test tip calculation
calculate_tip(50)       # Uses default 15% tip
calculate_tip(50, 20)   # Specifies 20% tip
```

### Functions That Return Multiple Values

Functions can return multiple values using a list:

```r
# Function that returns multiple values using a list
analyze_numbers <- function(numbers) {
  result <- list(
    mean = mean(numbers),                    # Calculate average
    median = median(numbers),                # Find middle value
    std_dev = sd(numbers),                   # Calculate standard deviation
    range = max(numbers) - min(numbers)      # Calculate range (max - min)
  )
  return(result)  # Return all statistics in a list
}

# Test statistical analysis function
test_scores <- c(85, 92, 78, 95, 88, 90)  # Sample test scores
analysis <- analyze_numbers(test_scores)    # Analyze the scores

# Access individual results from the analysis
analysis$mean     # Get mean score
analysis$median   # Get median score
analysis$std_dev  # Get standard deviation
analysis$range    # Get range of scores
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
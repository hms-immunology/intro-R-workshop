---
title: Loops and Apply Functions in R
layout: default
nav_order: 13
---

# Loops and Apply Functions in R

[<img src="https://img.shields.io/badge/Download-HTML-blue?style=for-the-badge&logo=html5" alt="Download HTML" />](../rendered-html/loops-and-apply.html)
[<img src="https://img.shields.io/badge/Download-R_Markdown-green?style=for-the-badge&logo=r" alt="Download R Markdown" />](loops-and-apply.Rmd)

## Introduction to Loops and Apply Functions

In R, we often need to perform the same operation multiple times. We can do this using:
1. Loops (for, while)
2. Apply family functions (apply, lapply, sapply, mapply)

Let's learn both approaches with simple examples!

## Part 1: Loops in R

### For Loops

A for loop repeats a block of code for a specified number of times:

```r
# Basic for loop
for (i in 1:5) {
  print(paste("This is iteration number", i))
}

# Loop through a vector
fruits <- c("apple", "banana", "orange", "grape")
for (fruit in fruits) {
  print(paste("I like", fruit))
}
```

### Practical Examples with For Loops

```r
# 1. Calculate squares of numbers
numbers <- 1:5
squares <- numeric(length(numbers))  # Pre-allocate the vector

for (i in 1:length(numbers)) {
  squares[i] <- numbers[i]^2
}
print(squares)

# 2. Working with a data frame
students <- data.frame(
  name = c("Alice", "Bob", "Charlie"),
  score1 = c(85, 92, 78),
  score2 = c(88, 85, 90)
)

# Calculate average score for each student
for (i in 1:nrow(students)) {
  avg <- mean(c(students$score1[i], students$score2[i]))
  print(paste(students$name[i], "has an average score of", avg))
}
```

### While Loops

While loops continue until a condition becomes false:

```r
# Basic while loop
counter <- 1
while (counter <= 5) {
  print(paste("Counter is", counter))
  counter <- counter + 1
}

# Example: Keep adding numbers until sum exceeds 100
sum <- 0
count <- 0
while (sum < 100) {
  count <- count + 1
  sum <- sum + count
  print(paste("Added", count, "Sum is now", sum))
}
```

### Nested Loops

We can put loops inside other loops:

```r
# Create a multiplication table
for (i in 1:3) {
  for (j in 1:3) {
    print(paste(i, "x", j, "=", i*j))
  }
  print("---")  # Separator between numbers
}
```

## Part 2: Apply Functions

Apply functions are often more efficient and readable than loops in R. They're a key part of functional programming.

### lapply(): List Apply

`lapply()` applies a function to each element of a list or vector and returns a list:

```r
# Basic lapply example
numbers <- list(a = 1:3, b = 4:6, c = 7:9)
lapply(numbers, sum)

# Using lapply with our own function
double_it <- function(x) {
  return(x * 2)
}

lapply(numbers, double_it)

# lapply with anonymous function
lapply(numbers, function(x) x * 3)
```

### sapply(): Simplified Apply

`sapply()` is similar to `lapply()` but tries to simplify the output:

```r
# Compare lapply and sapply
numbers <- 1:5

# lapply returns a list
lapply(numbers, sqrt)

# sapply returns a vector
sapply(numbers, sqrt)

# Example with character lengths
words <- c("cat", "dog", "elephant", "rhinoceros")
sapply(words, nchar)
```

### apply(): Matrix or Array Apply

`apply()` works with matrices and arrays:

```r
# Create a matrix
mat <- matrix(1:9, nrow = 3)
print(mat)

# Calculate row means (MARGIN = 1 for rows)
apply(mat, 1, mean)

# Calculate column means (MARGIN = 2 for columns)
apply(mat, 2, mean)

# More complex example
grades <- matrix(c(
  85, 90, 88,  # Student 1
  92, 85, 87,  # Student 2
  78, 83, 85   # Student 3
), nrow = 3, byrow = TRUE)

colnames(grades) <- c("Math", "Science", "History")
rownames(grades) <- c("Alice", "Bob", "Charlie")

print(grades)

# Calculate average for each student
student_averages <- apply(grades, 1, mean)
print(student_averages)

# Calculate average for each subject
subject_averages <- apply(grades, 2, mean)
print(subject_averages)
```

### mapply(): Multivariate Apply

`mapply()` applies a function to multiple arguments:

```r
# Basic mapply example
mapply(rep, times = 1:4, x = letters[1:4])

# Create a custom function for mapply
create_sequence <- function(start, end) {
  return(start:end)
}

mapply(create_sequence, 
       start = c(1, 2, 3), 
       end = c(3, 4, 5))
```

## Practical Examples: Loops vs Apply Functions

Let's compare loops and apply functions for the same tasks:

```r
# Task: Calculate the square of each number
numbers <- 1:5

# Using a for loop
squares_loop <- numeric(length(numbers))
for (i in 1:length(numbers)) {
  squares_loop[i] <- numbers[i]^2
}

# Using sapply
squares_sapply <- sapply(numbers, function(x) x^2)

# Compare results
print(squares_loop)
print(squares_sapply)

# Task: Process a data frame
df <- data.frame(
  name = c("Alice", "Bob", "Charlie"),
  age = c(25, 30, 35),
  score = c(88, 92, 85)
)

# Using a for loop
for (i in 1:nrow(df)) {
  if (df$score[i] >= 90) {
    print(paste(df$name[i], "got an A!"))
  }
}

# Using sapply with an anonymous function
high_scorers <- sapply(1:nrow(df), function(i) {
  if (df$score[i] >= 90) return(paste(df$name[i], "got an A!"))
})
# Remove NULL results
high_scorers[!sapply(high_scorers, is.null)]
```

## When to Use What?

1. **Use For Loops When**:
   - The operation is complex
   - You need to modify the original data
   - You need more control over the iteration process
   - The code needs to be very clear for beginners

2. **Use Apply Functions When**:
   - The operation is simple
   - You're working with lists, vectors, or matrices
   - You want more concise code
   - Performance is important

## Practice Exercises

Try these exercises to practice:

1. Create a for loop that prints the first 10 Fibonacci numbers
2. Use `sapply()` to find the length of each word in a sentence
3. Use `apply()` to find the maximum value in each row of a matrix
4. Use `mapply()` to create pairs of numbers

Here are the solutions:

```r
# 1. Fibonacci numbers with for loop
fibonacci <- numeric(10)
fibonacci[1] <- 1
fibonacci[2] <- 1

for (i in 3:10) {
  fibonacci[i] <- fibonacci[i-1] + fibonacci[i-2]
}
print(fibonacci)

# 2. Word lengths with sapply
sentence <- c("The", "quick", "brown", "fox", "jumps")
word_lengths <- sapply(sentence, nchar)
print(word_lengths)

# 3. Row maximums with apply
matrix_data <- matrix(1:20, nrow = 4)
row_maxes <- apply(matrix_data, 1, max)
print(row_maxes)

# 4. Number pairs with mapply
starts <- 1:3
ends <- 4:6
number_pairs <- mapply(function(x, y) paste(x, "and", y),
                      starts, ends)
print(number_pairs)
```

## Tips and Best Practices

1. **Pre-allocate vectors** in loops for better performance
2. **Use meaningful iterator names** (not just `i`, `j`, `k`)
3. **Consider readability** when choosing between loops and apply functions
4. **Test your code** with small examples first
5. **Comment your code** to explain complex operations 
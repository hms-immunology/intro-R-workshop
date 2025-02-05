---
title: R Markdown Basics
layout: default
nav_order: 3
parent: Class Materials
---

# Getting Started with R Markdown

[<img src="https://img.shields.io/badge/Download-HTML-blue?style=for-the-badge&logo=html5" alt="Download HTML" />](../rendered-html/r-markdown-basics.html)
[<img src="https://img.shields.io/badge/Download-R_Markdown-green?style=for-the-badge&logo=r" alt="Download R Markdown" />](r-markdown-basics.Rmd)

## Welcome to R Markdown!

Have you ever wanted to:
- Create beautiful documents that combine text and R code?
- Share your analysis with others in a professional format?
- Make your research reproducible?

R Markdown is your answer! Think of it as a special document where you can:
- Write text to explain your work
- Include R code and its output
- Add tables, figures, and equations
- Create PDFs, Word documents, or web pages

## Part 1: Basic Structure

An R Markdown document has three main parts:

### 1. YAML Header
This is the part at the top of your document between the `---` marks:

```yaml
---
title: "My First R Markdown"
author: "Your Name"
date: "2024-03-20"
output: html_document
---
```

### 2. Text Content
Write regular text using Markdown formatting:

# This is a big heading
## This is a smaller heading
### Even smaller heading

- Bullet points are made with dashes
- *Italics* are made with asterisks
- **Bold** is made with double asterisks
- [Links](https://www.r-project.org/) are made with brackets and parentheses

### 3. Code Chunks
Code chunks are where you put your R code. They look like this:

```r
# This is a code chunk
x <- 1:10
mean(x)
# Result: 5.5
```

## Part 2: Code Chunks in Detail

### Creating Code Chunks

There are three ways to create a code chunk:
1. Click the "Insert" button in RStudio
2. Use the keyboard shortcut: 
   - Mac: Cmd + Option + I
   - Windows/Linux: Ctrl + Alt + I
3. Type the chunk delimiters manually: \```{r chunk-name}

### Chunk Options

Code chunks can be customized using options:

```r
# This chunk will:
# - Show the code (echo=TRUE)
# - Hide messages (message=FALSE)
# - Hide warnings (warning=FALSE)
library(tidyverse)
ggplot(mtcars, aes(x = mpg, y = wt)) +
  geom_point()
```

Common chunk options:
- `echo`: Should the code be shown? (TRUE/FALSE)
- `eval`: Should the code be run? (TRUE/FALSE)
- `message`: Show messages? (TRUE/FALSE)
- `warning`: Show warnings? (TRUE/FALSE)
- `fig.width`, `fig.height`: Control figure size
- `fig.cap`: Add a figure caption

## Part 3: Best Practices

### 1. Document Organization

✅ **Do:**
- Start with a clear introduction
- Use consistent heading levels
- Include a table of contents for longer documents
- End with conclusions or next steps

❌ **Don't:**
- Skip heading levels (e.g., going from # to ###)
- Write very long sections without breaks
- Leave code without explanation

### 2. Code Chunk Management

✅ **Do:**
- Give meaningful names to important chunks
- Use chunk options to control output
- Keep chunks focused on one task
- Comment your code

❌ **Don't:**
- Use spaces or special characters in chunk names
- Leave chunk names empty for important chunks
- Put too much code in one chunk

Example of good chunk naming:
```r
# Load required packages
library(tidyverse)
```

```r
# Clean the data
data <- mtcars %>%
  select(mpg, wt, cyl) %>%
  filter(mpg > 20)
```

### 3. Text Formatting

✅ **Do:**
- Use consistent formatting for similar elements
- Include spaces between sections
- Use lists for related items
- Include relevant links

❌ **Don't:**
- Mix different formatting styles
- Write very long paragraphs
- Forget to explain acronyms

### 4. Output Management

✅ **Do:**
- Control figure sizes explicitly
- Use chunk options to manage output
- Consider your audience when showing/hiding code

Example:
```r
ggplot(mtcars, aes(x = mpg, y = wt, color = factor(cyl))) +
  geom_point(size = 3) +
  labs(title = "Car Weight vs MPG",
       x = "Miles Per Gallon",
       y = "Weight (1000 lbs)",
       color = "Cylinders") +
  theme_minimal()
```

## Part 4: Common Patterns

### Including Tables

```r
# Create a nice table
library(knitr)
head(mtcars) %>%
  kable()
```

### Including Equations
You can add equations using LaTeX syntax:

Inline equation: $y = mx + b$

Display equation:
$$
\bar{X} = \frac{1}{n}\sum_{i=1}^n X_i
$$

### Including Images
![RStudio Logo](https://www.rstudio.com/wp-content/uploads/2018/10/RStudio-Logo-Flat.png)

## Part 5: Troubleshooting Tips

Common issues and solutions:

1. **Knitting Fails**
   - Check for missing packages
   - Look for syntax errors in code chunks
   - Verify file paths are correct

2. **Figures Don't Look Right**
   - Adjust figure dimensions
   - Check plot device settings
   - Verify data is correct

3. **Code Chunks Don't Run**
   - Check for missing dependencies
   - Verify chunk names are unique
   - Look for syntax errors

## Practice Exercises

1. Create a new R Markdown document
2. Add sections with different heading levels
3. Include code chunks with different options
4. Add a table and a plot
5. Try knitting to different formats

## Next Steps

After mastering these basics, you can explore:
- Different output formats (PDF, Word, presentations)
- Advanced formatting options
- Custom templates
- Interactive documents with Shiny

## Additional Resources

1. [R Markdown Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf)
2. [R Markdown Cookbook](https://bookdown.org/yihui/rmarkdown-cookbook/)
3. [R Markdown: The Definitive Guide](https://bookdown.org/yihui/rmarkdown/) 
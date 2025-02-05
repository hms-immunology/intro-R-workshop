---
title: Installing and Using R Packages
layout: default
nav_order: 3
---

# Installing and Using R Packages

## Understanding R Packages

R packages are collections of R functions, data, and compiled code that extend the capabilities of base R. They are fundamental to the R ecosystem for several reasons:

- They allow you to access specialized functions and tools without writing them from scratch
- They provide access to cutting-edge statistical methods and visualizations
- They make it easier to perform complex analyses with well-tested, maintained code
- They help maintain reproducibility in your analysis

### The R Package Ecosystem

R has two main types of packages:

1. **Base Packages**: Come pre-installed with R (like `stats`, `graphics`, `utils`)
2. **Contributed Packages**: Created by the R community and available on CRAN (Comprehensive R Archive Network)

## Installing Packages

There are several ways to install R packages:

### Using install.packages()

The most common way to install packages is using the `install.packages()` function:

```r
# Install a single package
install.packages("tidyverse")

# Install multiple packages
install.packages(c("ggplot2", "dplyr", "readr"))
```

### Essential Packages for this Workshop

Here are the key packages we'll be using throughout this workshop:

```r
# Install all essential packages
install.packages(c(
  "tidyverse",  # Collection of data science packages
  "ggplot2",    # For data visualization
  "dplyr",      # For data manipulation
  "readr",      # For reading data
  "tidyr",      # For tidying data
  "rmarkdown",  # For creating documents
  "knitr"       # For knitting Rmd files
))
```

## Loading Packages

Once installed, packages need to be loaded into your R session before you can use them:

```r
# Load individual packages
library(tidyverse)

# You can also load specific packages from tidyverse
library(ggplot2)
library(dplyr)
```

### Checking Package Version

You can check which version of a package you have installed:

```r
# Check package version
packageVersion("tidyverse")
```

## Managing Packages

### Updating Packages

It's good practice to keep your packages up to date:

```r
# Update all packages
update.packages()

# Update specific packages
install.packages("ggplot2")  # reinstalling will update to the latest version
```

### Viewing Installed Packages

You can see what packages are installed on your system:

```r
# List installed packages
installed.packages()[, c("Package", "Version")]
```

## Best Practices

1. **Document Dependencies**: Always list the packages your analysis requires at the beginning of your script
2. **Version Control**: Note the versions of key packages used in your analysis
3. **Load Packages Early**: Load all required packages at the start of your script
4. **Use Specific Functions**: When using functions from specific packages, you can use the `package::function()` notation

## Example Usage

Here's a simple example using some common packages:

```r
# Load required packages
library(ggplot2)
library(dplyr)

# Create some sample data
data <- data.frame(
  x = 1:10,
  y = rnorm(10)
)

# Use dplyr to manipulate data
data <- data %>%
  mutate(z = y * 2)

# Create a plot with ggplot2
ggplot(data, aes(x = x, y = y)) +
  geom_point() +
  geom_line() +
  theme_minimal() +
  labs(title = "Sample Plot",
       x = "X axis",
       y = "Y axis")
```

## Troubleshooting

Common issues when working with packages:

1. **Package not found**: Make sure the package is installed
2. **Loading conflicts**: Some functions might have the same name in different packages
3. **Dependencies**: Some packages require other packages to be installed first

```r
# Check if a package is installed
if (!require("ggplot2")) {
  install.packages("ggplot2")
}

# See which packages are currently loaded
search()

# Get help with a package
help(package = "ggplot2")
```

## Finding Help and Documentation

R packages come with extensive documentation that can help you understand how to use them effectively:

### Package Documentation

```r
# Get overview of a package
help(package = "dplyr")

# Get help for a specific function
?dplyr::filter
help("filter", package = "dplyr")

# See examples for a function
example("filter", package = "dplyr")
```

### Package Vignettes

Vignettes are detailed guides that show you how to use the package:

```r
# List all vignettes for installed packages
vignette()

# List vignettes for a specific package
vignette(package = "dplyr")

# Open a specific vignette
vignette("dplyr")

# If you know the specific vignette name
vignette("programming", package = "dplyr")
```

### Online Resources

Many packages also have additional resources:

1. **Package websites**: Most tidyverse packages have dedicated websites (e.g., [dplyr.tidyverse.org](https://dplyr.tidyverse.org))
2. **GitHub repositories**: Source code and issue tracking
3. **Cheatsheets**: Quick reference guides (Help -> Cheatsheets in RStudio)

```r
# Open package documentation in browser (if available)
browseVignettes("dplyr")

# Get package news/changelog
news(package = "dplyr")
```

## Next Steps

After understanding how to install and manage packages, you can:
- Explore package documentation using `?` or `help()`
- Look for packages that suit your needs on [CRAN](https://cran.r-project.org/)
- Learn about package development if you want to create your own packages 
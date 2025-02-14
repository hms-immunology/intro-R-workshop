# Script to render all Rmd files to HTML
library(rmarkdown)

# List all Rmd files in class-materials directory
rmd_files <- list.files("class-materials", pattern = "\\.Rmd$", full.names = TRUE)

# Create rendered-html directory if it doesn't exist
if (!dir.exists("rendered-html")) {
  dir.create("rendered-html")
}

# Render each file
for (file in rmd_files) {
  cat("Rendering", file, "...\n")
  try({
    rmarkdown::render(file, 
                     output_format = "html_document",
                     output_dir = "rendered-html")
  })
}

cat("Done!\n") 
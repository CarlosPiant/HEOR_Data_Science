---
title: "Getting Started with R, RStudio, and Quarto"
subtitle: "Academic Guide"
author: "Carlos Pineda-Antunez"
date: last-modified
format:
  html:
  toc: true
toc-depth: 3
code-fold: show
number-sections: true
theme: cosmo
page-layout: article
title-block-banner: "#4b2e83"
title-block-style: default
include-in-header:
  - text: |
  <style>
  /* University of Washington purple + gold accent */
  :root {
    --bs-primary: #4b2e83;   /* UW Purple */
      --bs-secondary: #b7a57a; /* UW Gold */
      --bs-link-color: #4b2e83;
      --bs-link-hover-color: #3a2265;
  }
/* Title banner styling */
  .quarto-title-block .quarto-title-banner {
    background-color: #4b2e83 !important;
      color: #ffffff !important;
  }
.quarto-title-block .quarto-title-banner h1,
.quarto-title-block .quarto-title-banner .quarto-title-meta,
.quarto-title-block .quarto-title-banner .quarto-title {
  color: #ffffff !important;
}
/* Sidebar logo space */
  .sidebar-logo img { max-height: 60px; }
/* Accent headings */
  h2, h3, h4 { color: #4b2e83; }
      /* Code block accent */
      pre code { background-color: #f7f2ff; border-left: 4px solid #4b2e83; }
          /* Buttons and callouts */
          .btn-primary { background-color: #4b2e83; border-color: #4b2e83; }
              .callout { border-left-color: #4b2e83; }
                  </style>
                  sidebar:
                  style: floating
                logo: images/uw-logo.png
                contents: toc
                title-block-preamble: |
                  <!-- Optional: shows your logo near the title if present -->
                  ![Institution Logo](images/uw-logo.png){fig-alt="Institution Logo" height="60"}
                execute:
                  echo: true
                warning: false
                message: false
                ---
                  
                  Introduction
                
                - This guide shows how to:
                  - Download and install R and RStudio
                - Understand how base R differs from RStudio
                - Navigate the RStudio environment (the 4 panes)
                - Format flat files (like CSV) for loading
                - Load a dataset (flat file and pointers to other resources)
                - Install and load libraries
                - Create objects
                - Conduct basic analyses
                - Save datasets
                - Save R Markdown and Quarto files
                
                Note on academic styling and logo
                
                - The page uses an academic-style layout with a floating sidebar and a purple theme inspired by the University of Washington (#4b2e83).
                  - To display your logo, place an image file at images/uw-logo.png. The logo will appear in the sidebar and below the title. You can change the path under sidebar: logo and title-block-preamble in the YAML header.
                  
                  # Download and Install R and RStudio
                  
                  - R is the programming language. RStudio (by Posit) is a popular Integrated Development Environment (IDE) for R.
                  - Install R first, then RStudio.
                  
                  Steps
                  
                  1) Download R (CRAN):
                  - https://cran.r-project.org/
                  - Click “Download R for Windows” or “macOS” or “Linux”
                - Choose the latest release, then run the installer
                
                2) Download RStudio Desktop (free):
  - https://posit.co/download/rstudio-desktop/
  - Download the installer for your OS and run it
- Open RStudio after installing (R should already be installed)

Check versions

```{r}
R.version.string
# If running inside RStudio, this may show RStudio version:
if (exists("RStudio.Version")) {
  try({
    v <- RStudio.Version()
    paste("RStudio version:", v$version)
  }, silent = TRUE)
}
```

# How Base R Differs from RStudio

- Base R
- The language + interpreter/engine
- Comes with a console and basic GUI (varies by OS)
- You can run scripts and commands via the R console or terminal

- RStudio IDE (by Posit)
- A graphical environment wrapping R
- Offers script editor, plotting viewer, environment browser, package manager, project management, and integrated help
- Makes development, reproducibility, and visualization easier, but does not replace R itself

Example: Base R functionality (works the same in RStudio since RStudio calls R under the hood)

```{r}
# Base R calculations
x <- c(1, 2, 3, 4, 5)
mean(x)
sd(x)
sum(x^2)
```

# Introduction to the RStudio Environment (The 4 Panes)

- Source (top-left, by default)
- Your editor for .R scripts, .Rmd, .qmd files
- Run code lines or chunks into the Console

- Console (bottom-left)
- Where R commands execute
- Shows outputs, errors, warnings

- Environment/History (top-right)
- Environment: objects currently in memory
- History: previously run commands

- Files/Plots/Packages/Help/Viewer (bottom-right)
- Files: browse project files
- Plots: view figures
- Packages: installed packages and load/unload controls
- Help: documentation for functions and packages
- Viewer: renders HTML content (e.g., Quarto docs)

Quick demonstrations

```{r}
# Create a few objects (watch the Environment pane update)
nums <- rnorm(10)
df <- data.frame(id = 1:5, value = c(10, 20, 15, 30, NA))

# Use Help pane: open documentation
help("mean")   # or ?mean

# Show a basic plot (appears in Plots tab)
plot(nums, type = "b", main = "Demo plot", xlab = "Index", ylab = "Value")
```

# Formatting Flat Files for Loading

Good practices for CSV/TSV flat files

- Use a header row with short, clear, alphanumeric column names (avoid spaces; use underscores if needed)
- Use UTF-8 encoding
- Use a consistent delimiter (comma for CSV, tab for TSV)
- Represent missing values consistently (e.g., empty cell or NA; avoid mixed values like "-", "N/A", "null")
- Use ISO 8601 for dates (YYYY-MM-DD) and include time zones if timestamps are present
- Avoid embedded line breaks in cells; if present, ensure proper quoting
- Keep one “tidy” table per file: each row is one observation, each column is one variable

Create and save a well-formatted CSV

```{r}
# Example tidy dataset
tidy_example <- data.frame(
  subject_id = 1:6,
  group = c("control", "control", "control", "treatment", "treatment", "treatment"),
  age_years = c(34, 45, 51, 29, 40, NA),
  visit_date = as.Date(c("2025-01-10", "2025-01-12", "2025-01-13", "2025-01-11", "2025-01-12", "2025-01-14")),
  score = c(87, 90, 85, 92, 88, 91)
)

# Create a data folder, then save CSV
dir.create("data", showWarnings = FALSE)
csv_path <- file.path("data", "tidy_example.csv")
write.csv(tidy_example, csv_path, row.names = FALSE, na = "")
csv_path
```

# Loading a Dataset (Flat File and Other Resources)

Load the CSV using base R

```{r}
loaded_base <- read.csv(csv_path, stringsAsFactors = FALSE)
str(loaded_base)
head(loaded_base)
```

Load the CSV using readr (tidyverse) for better performance and type control

```{r}
# Install readr if needed (run once; eval is FALSE so it won't execute automatically)
# install.packages("readr")
```

```{r}
# If readr is available, demonstrate its use safely
if (requireNamespace("readr", quietly = TRUE)) {
  loaded_readr <- readr::read_csv(csv_path, show_col_types = FALSE)
  print(loaded_readr)
}
```

Handling column types and missing values explicitly with readr

```{r}
if (requireNamespace("readr", quietly = TRUE)) {
  loaded_typed <- readr::read_csv(
    csv_path,
    col_types = readr::cols(
      subject_id = readr::col_integer(),
      group = readr::col_factor(levels = c("control", "treatment")),
      age_years = readr::col_double(),
      visit_date = readr::col_date(),
      score = readr::col_double()
    ),
    show_col_types = FALSE
  )
  str(loaded_typed)
}
```

Reading Excel files

```{r}
# install.packages("readxl")  # run once
if (requireNamespace("readxl", quietly = TRUE)) {
  # Example: readxl::read_excel("data/example.xlsx", sheet = 1)
  # (We won’t read here unless a file exists)
}
```

Other dataset resources

- Built-in datasets: datasets::mtcars, iris, airquality
- Public datasets:
  - palmerpenguins: https://allisonhorst.github.io/palmerpenguins/
  - TidyTuesday datasets: https://github.com/rfordatascience/tidytuesday
- UCI Machine Learning Repository: https://archive.ics.uci.edu/
  - Kaggle: https://www.kaggle.com/datasets
- data.gov (US): https://data.gov/
  - World Bank Data: https://data.worldbank.org/
  
  # Installing and Loading Libraries
  
  Install packages (run once; do not run inside production pipelines without a lockfile)

```{r}
# Example install (set eval: false to avoid automatic install)
# install.packages(c("tidyverse", "readr", "dplyr", "ggplot2", "readxl", "data.table"))
```

Load packages

```{r}
# Load if available; fall back gracefully if not
loaded_pkgs <- c()
for (pkg in c("dplyr", "ggplot2")) {
  if (requireNamespace(pkg, quietly = TRUE)) {
    library(pkg, character.only = TRUE)
    loaded_pkgs <- c(loaded_pkgs, pkg)
  }
}
loaded_pkgs
```

Notes

- Use install.packages("packagename") once per machine or project
- Use library(packagename) in each session/script where needed
- Consider project environments for reproducibility (e.g., renv)

# Creating Objects

Basic objects

```{r}
# Numeric and character vectors
a <- c(10, 20, 30)
b <- c("alpha", "beta", "gamma")

# Factors
grp <- factor(c("control", "treatment", "control"), levels = c("control", "treatment"))

# Matrices
m <- matrix(1:9, nrow = 3)

# Lists (heterogeneous containers)
my_list <- list(nums = a, labels = b, flag = TRUE)

# Data frames (tabular)
df2 <- data.frame(id = 1:3, group = grp, score = c(88, 92, 85))
str(df2)

# Functions
add_two <- function(x) x + 2
add_two(5)
```

# Conducting Analyses

Descriptive statistics (base R)

```{r}
x <- rnorm(100, mean = 50, sd = 10)
summary(x)
mean(x); median(x); sd(x); quantile(x, probs = c(0.25, 0.5, 0.75))
```

Group-wise summaries (dplyr, if available)

```{r}
if (requireNamespace("dplyr", quietly = TRUE)) {
  library(dplyr)
  loaded_base %>%
    group_by(group) %>%
    summarise(
      n = n(),
      mean_score = mean(score, na.rm = TRUE),
      mean_age = mean(age_years, na.rm = TRUE)
    )
}
```

Visualization (ggplot2, if available)

```{r}
if (requireNamespace("ggplot2", quietly = TRUE)) {
  library(ggplot2)
  ggplot(loaded_base, aes(x = group, y = score, fill = group)) +
    geom_boxplot() +
    geom_jitter(width = 0.1, alpha = 0.6) +
    labs(title = "Scores by Group", x = "Group", y = "Score") +
    theme_minimal() +
    scale_fill_manual(values = c(control = "#4b2e83", treatment = "#b7a57a"))
}
```

Linear regression

```{r}
# Fit a simple model on built-in mtcars dataset
fit <- lm(mpg ~ wt + cyl, data = mtcars)
summary(fit)
```

T-test (group comparison)

```{r}
# Compare mpg for automatic vs manual transmissions
t.test(mpg ~ am, data = mtcars)
```

Contingency table and chi-squared test

```{r}
tbl <- table(mtcars$cyl, mtcars$gear)
tbl
chisq.test(tbl)
```

# Saving Datasets

Save to CSV (portable)

```{r}
# Save mtcars as CSV
out_csv <- file.path("data", "mtcars_export.csv")
dir.create("data", showWarnings = FALSE)
write.csv(mtcars, out_csv, row.names = FALSE)
out_csv
```

Save to RDS (preserves R types precisely, single object)

```{r}
out_rds <- file.path("data", "mtcars.rds")
saveRDS(mtcars, out_rds)
# Load back
mtcars_loaded <- readRDS(out_rds)
identical(mtcars, mtcars_loaded)
```

Save multiple objects to .RData (workspace-like)

```{r}
out_rdata <- file.path("data", "analysis_objects.RData")
obj1 <- 123
obj2 <- data.frame(x = 1:3, y = c("a", "b", "c"))
save(obj1, obj2, file = out_rdata)
# Load back
rm(obj1, obj2)
load(out_rdata)
obj1; obj2
```

# Saving R Markdown and Quarto Files

Saving files

- In RStudio:
  - File -> New File -> Quarto Document
- File -> Save (choose .qmd extension)
- For R Markdown: File -> New File -> R Markdown, then Save as .Rmd

Rendering (turn .qmd or .Rmd into HTML/PDF/Word)

```{r}
# Quarto render (requires Quarto installed)
# Quarto is a separate tool: https://quarto.org/
if (requireNamespace("quarto", quietly = TRUE)) {
  # quarto::quarto_render("your_document.qmd")
}
```

```{r}
# R Markdown render (requires rmarkdown package)
# install.packages("rmarkdown")  # run once
if (requireNamespace("rmarkdown", quietly = TRUE)) {
  # rmarkdown::render("your_document.Rmd", output_format = "html_document")
}
```

Command-line rendering (outside R)

- Quarto:
  - Install Quarto: https://quarto.org/docs/get-started/
  - In a terminal: quarto render your_document.qmd

- R Markdown (legacy):
  - In RStudio: click “Knit”
- Or in R: rmarkdown::render("your_document.Rmd")

Export formats

- HTML (default), PDF (requires LaTeX), Word (docx)
- Choose output format in the YAML header or via render arguments

# Sources and Further Reading

- R (CRAN) downloads: https://cran.r-project.org/
  - RStudio Desktop by Posit: https://posit.co/download/rstudio-desktop/
  - Quarto documentation: https://quarto.org/docs/
  - R for Data Science (2e): https://r4ds.hadley.nz/
  - Advanced R (3e): https://adv-r.hadley.nz/
  - Tidyverse packages: https://www.tidyverse.org/
  - readr (fast reading/writing): https://readr.tidyverse.org/
  - dplyr (data manipulation): https://dplyr.tidyverse.org/
  - ggplot2 (visualization): https://ggplot2.tidyverse.org/
  - R Markdown (legacy): https://rmarkdown.rstudio.com/
  - Base R documentation (manuals): https://cran.r-project.org/manuals.html
- RStudio IDE docs: https://docs.posit.co/ide/
  - Data import best practices (readr vignette): https://readr.tidyverse.org/articles/readr.html
- Palmer Penguins dataset: https://allisonhorst.github.io/palmerpenguins/
  - TidyTuesday: https://github.com/rfordatascience/tidytuesday
- UCI ML Repository: https://archive.ics.uci.edu/
  - Kaggle datasets: https://www.kaggle.com/datasets
- data.gov: https://data.gov/
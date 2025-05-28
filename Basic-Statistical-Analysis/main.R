# Create outputs folder if not exists
if (!dir.exists("outputs")) {
    dir.create("outputs")
    cat("Created outputs folder\n")
} else {
    cat("Outputs folder already exists\n")
}

sink("outputs/results_summary.txt", split = TRUE)

cat("Starting Basic Statistical Analysis\n")

# Try t-test script with error capture
tryCatch({
    source("scripts/t_test_analysis.R")
}, error = function(e) {
    cat("Error in t_test_analysis.R: ", e$message, "\n")
})

# Try ANOVA script
tryCatch({
    source("scripts/anova_analysis.R")
}, error = function(e) {
    cat("Error in anova_analysis.R: ", e$message, "\n")
})

# Try Chi-square script
tryCatch({
    source("scripts/chi_square_analysis.R")
}, error = function(e) {
    cat("Error in chi_square_analysis.R: ", e$message, "\n")
})

cat("Analysis complete\n")

sink()

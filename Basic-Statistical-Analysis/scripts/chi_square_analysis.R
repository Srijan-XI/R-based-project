data <- matrix(c(30, 20, 20, 30), nrow = 2)
colnames(data) <- c("Yes", "No")
rownames(data) <- c("Male", "Female")

result <- chisq.test(data)

cat("\n--- Chi-Square Test ---\n")
print(result)

group1 <- c(20, 22, 23, 24, 25)
group2 <- c(28, 29, 30, 31, 32)

result <- t.test(group1, group2)

cat("\n--- T-Test Result ---\n")
print(result)

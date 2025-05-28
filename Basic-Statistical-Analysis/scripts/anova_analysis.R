group <- factor(rep(c("A", "B", "C"), each = 5))
scores <- c(20, 21, 19, 22, 20, 25, 27, 26, 24, 25, 30, 29, 28, 27, 29)

anova_result <- aov(scores ~ group)

cat("\n--- ANOVA Result ---\n")
print(summary(anova_result))

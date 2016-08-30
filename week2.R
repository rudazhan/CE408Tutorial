# Chap. 2 (12, 17, 26, 30, 33)
#install.packages('tibble')   #if not already installed
library(tibble)

# 2.12
age <- c(seq(0, 20, by = 5), seq(30, 80, by = 10))
tb <- tibble(
  age_low = age,
  age_high = c(age[-1], 100),
  male = c(120, 184, 44, 24, 23, 50, 60, 102, 167, 150, 49),
  female = c(67, 120, 22, 15, 25, 22, 40, 76, 104, 90, 27)
)
tb$age_mean <- (tb$age_low + tb$age_high) / 2
# Summary stats
summary_male <- summary(rep(tb$age_mean, tb$male))
summary_female <- summary(rep(tb$age_mean, tb$female))
# Approximate sample means
summary_male['Mean']
summary_female['Mean']
# Approximate quantiles
summary_male[c('1st Qu.', 'Median', '3rd Qu.')]
summary_female[c('1st Qu.', 'Median', '3rd Qu.')]

# 2.17
# Stem and leaf plot is a pre-computer age technique for making histograms.
# If you have computer, just plot histogram.
percent_shrinkage <-
  c(18.2, 21.2, 23.1, 18.5, 15.6, 20.8, 19.4, 15.4, 21.2, 13.4, 16.4, 18.7,
    18.2, 19.6, 14.3, 16.6, 24.0, 17.6, 17.8, 20.2, 17.4, 23.6, 17.5, 20.3,
    16.6, 19.3, 18.5, 19.3, 21.2, 13.9, 20.5, 19.0, 17.6, 22.3, 18.4, 21.2,
    20.4, 21.4, 20.3, 20.1, 19.6, 20.6, 14.8, 19.7, 20.5, 18.0, 20.8, 15.8,
    23.1, 17.0)
hist(percent_shrinkage)
# sample mean, median, and mode.
mean(percent_shrinkage)
median(percent_shrinkage)
frequencies <- table(percent_shrinkage)
names(which.max(frequencies))
# sample variance
var(percent_shrinkage)
# Histogram (with return values)
histogram <- hist(percent_shrinkage, breaks = 13:24)
# Sample mean and variance of simulated data.
simulated_data <- rep(histogram$mids, histogram$counts)
mean(simulated_data)
var(simulated_data)

# 2.26
gpa <- c(3.46, 3.72, 3.95, 3.55, 3.62, 3.80, 3.86, 3.71, 3.56, 3.49, 3.96,
         3.90, 3.70, 3.61, 3.72, 3.65, 3.48, 3.87, 3.82, 3.91, 3.69, 3.67,
         3.72, 3.66, 3.79, 3.75, 3.93, 3.74, 3.50, 3.83)
# sample mean
(m <- mean(gpa))
# sample standard deviation
(s <- sd(gpa))
# proportion within 1.5 standard deviations
mean(abs((gpa - m) / s) < 1.5)
# proportion within 2 standard deviations
mean(abs((gpa - m) / s) < 2)
# Chebyshev’s inequality: P(|(X - m) / s| > c) < c^{-2}
#   1 - 1.5^(-2) = 5/9
#   1 - 2^(-2) = 3/4

# 2.30
cohort <- tibble(
  height = c(64, 65, 66, 67, 69, 70, 72, 72, 74, 74, 75, 76),
  salary = c(91, 94, 88, 103, 77, 96, 105, 88, 122, 102, 90, 114)
)
# scatterplot
plot(cohort)
# sample correlation coefficient (diagonal of covariance matrix)
cor(cohort)[1, 2]

# 2.33
# install.packages("data.table")  #if not already installed
library(data.table)
students <- fread(
'Hours GPA
6 2.8
14 3.2
3 3.1
22 3.6
9 3.0
11 3.3
12 3.4
5 2.7
18 3.1
24 3.8
15 3.0
17 3.9')
# sample correlation coefficient
cor(students)[1, 2]

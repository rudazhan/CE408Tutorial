# 9.1
library(data.table)
dt <- fread(
  'moisture density
  5 7.4
  6 9.3
  7 10.6
  10 15.4
  12 18.1
  15 22.2
  18 24.1
  20 24.8')
plot(dt)
fit <- lm(density ~ moisture, data = dt)
lines(fit$model$moisture, fit$fitted.values, col = 2)
# without computer
colSums(dt)
colSums(dt * dt$moisture)

# 9.4
dt <- fread(
  'gravity strength
  0.41 1850
  0.46 2620
  0.44 2340
  0.47 2690
  0.42 2160
  0.39 1760
  0.41 2500
  0.44 2750
  0.43 2730
  0.44 3120')
plot(dt)
fit <- lm(strength ~ gravity, data = dt)
lines(fit$model$gravity, fit$fitted.values, col = 2)
predict(fit, list(gravity = 0.43))

# 9.6
dt <- fread(
'percentage reading
0 0.734
20 0.885
40 1.050
60 1.191
80 1.314
100 1.432')
plot(dt$reading, dt$percentage)
fit <- lm(percentage ~ reading, data = dt)
lines(fit$model$reading, fit$fitted.values, col = 2)
predict(fit, list(reading = 1.15))

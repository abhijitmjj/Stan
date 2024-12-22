set.seed(32)

m <- 1000
a <- 2.0
b <- 1.0 / 3.0

theta <- rgamma(n = m, shape = a, rate = b)


# Monte Carlo

se <- sd(theta) / sqrt(m)

# CI from sample

mean(theta) - 1.96 * se
mean(theta) + 1.96 * se


# indicator function
ind <- theta < 5.0

# Monte Carlo
# se <- sqrt(mean(ind) * (1 - mean(ind)) / m)

se <- sd(ind) / sqrt(m)

# simulate phi_i from Beta(2, 2)
# phi <- rbeta (n = m, shape1 = 2, shape2 = 2)

# simulate y_i from Binomial(10, phi_i)

m <- 1000
phi <- rbeta(n = m, shape1 = 2, shape2 = 2)
y <- rbinom(n = m, size = 10, prob = phi)


phi <- numeric(m)
y <- numeric(m)
for (i in 1:m) {
  phi[i] <- rbeta(1, shape1 = 2, shape2 = 2)
  y[i] <- rbinom(1, size = 10, prob = phi[i])
}

plot(table(y) / m) # marginal distribution of y

# Monte Carlo
se <- sd(y) / sqrt(m)


# Set seed for reproducibility
set.seed(42)

# Number of samples
n <- 1000

# Generate 1000 samples from Unif(0, pi)
samples <- runif(n, min = 0, max = pi)

# Calculate sin(x) for each sample
sin_values <- sin(samples)

# Monte Carlo estimate of the integral
integral_estimate <- mean(sin_values) / pi

# Print the result
cat("Monte Carlo estimate of the integral:", integral_estimate, "\n")

# Compare with the true value of the integral
true_integral <- integrate(function(x) sin(x) / pi, 0, pi)$value
cat("True value of the integral:", true_integral, "\n")


# Set the number of simulations
n_simulations <- 100000 # Increased for better accuracy

# Simulate from the Beta(5, 3) posterior distribution
theta_simulations <- rbeta(n_simulations, 5, 3)

# Calculate the odds for each simulated theta
odds_simulations <- theta_simulations / (1 - theta_simulations)

# Calculate the posterior mean of the odds
posterior_mean_odds <- mean(odds_simulations)

# Print the result, rounded to one decimal place
print(round(posterior_mean_odds, 1))


# Set seed for reproducibility
set.seed(42)

# Number of samples
n <- 10000

# Simulate samples from Beta(5, 3)
theta_samples <- rbeta(n, shape1 = 5, shape2 = 3)

# Calculate odds for each sample
odds <- theta_samples / (1 - theta_samples)

# Calculate the posterior mean of odds
posterior_mean_odds <- mean(odds)

# Print the result
cat("Posterior mean of odds:", posterior_mean_odds, "\n")


# Calculate the probability that odds > 1
prob_odds_greater_1 <- mean(odds > 1)

# Print the result
cat("Probability that odds are greater than 1:", prob_odds_greater_1, "\n")


# Simulate samples from N(0, 1)
normal_samples <- rnorm(n)

# Calculate the 0.3 quantile
quantile_0_3 <- quantile(normal_samples, probs = 0.3)

# Print the result
cat("Monte Carlo approximation of the 0.3 quantile:", quantile_0_3, "\n")

# Compare with theoretical value
theoretical_quantile <- qnorm(0.3)
cat("Theoretical 0.3 quantile using qnorm:", theoretical_quantile, "\n")

# Given values
sample_variance <- 5.2
m <- 5000

# Calculate standard error
standard_error <- sqrt(sample_variance / m)

# Print the result
cat("Standard error for sample size 5000:", round(standard_error, 3), "\n")

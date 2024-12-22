data {
  int<lower=0> N; // number of data points
  int<lower=0> K; // number of predictors
  matrix[N, K] X; // predictor matrix
  vector[N] y; // outcome vector

}
parameters {
  vector[K] beta; // regression coefficients
  real alpha; // prior location for the intercept
  real<lower=0> sigma; // error scale
}
model {
  y ~ normal(X * beta + alpha, sigma); // likelihood
}

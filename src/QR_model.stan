data {
  int<lower=0> N;   // Number of data items
  int<lower=0> K;   // Number of predictors
  matrix[N, K] x;   // Predictor matrix
  vector[N] y;      // Outcome vector
}
transformed data {
  vector[K] x_mean;               // Mean of each predictor
  matrix[N, K] x_centered;        // Centered predictor matrix
  matrix[N, K] Q_ast;
  matrix[K, K] R_ast;
  matrix[K, K] R_ast_inverse;

  // Compute the mean of each predictor (column-wise)
  x_mean = rep_vector(0.0, K);
  for (k in 1:K) {
    x_mean[k] = mean(col(x, k));
  }

  // Center the predictors by subtracting the mean
  x_centered = x;
  for (n in 1:N) {
    for (k in 1:K) {
      x_centered[n, k] -= x_mean[k];
    }
  }

  // Perform the thin QR decomposition on the centered predictors
  Q_ast = qr_thin_Q(x_centered) * sqrt(N - 1);
  R_ast = qr_thin_R(x_centered) / sqrt(N - 1);

  // Precompute the inverse of R_ast
  R_ast_inverse = inverse(R_ast);
}
parameters {
  real alpha;           // Intercept (mean of y when predictors are at their mean)
  vector[K] theta;      // Coefficients on Q_ast
  real<lower=1e-6> sigma;  // Error scale (standard deviation)
}
model {
  // Prior distributions (if any) can be specified here
  // Priors
  sigma ~ cauchy(0, 2);         // Half-Cauchy prior on sigma

  // Likelihood
  y ~ normal(Q_ast * theta + alpha, sigma);
}
generated quantities {
  vector[K] beta;       // Coefficients on the original predictors
  beta = R_ast_inverse * theta;  // Recover beta from theta
}

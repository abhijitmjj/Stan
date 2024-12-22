data {
  int <lower=0> n; // Number of observation
  vector[n] y;
}

parameters {
  real mu; // True population mean
}

model {
  // Prior for mu
  // mu ~ student_t(nu, mu, sigma)
  mu ~ student_t(1,0,1); // nu, mu, sigma; X = mu + sigma*T
  
  // Likelihood
  y ~ normal(mu, 1);      // Normal distribution for each observation
}

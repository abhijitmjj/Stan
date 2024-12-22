library(cmdstanr)
file <- file.path("~/workspace/Stan/src/QR_model.stan")
model <- cmdstan_model(
  file,
  cpp_options = list(
    stan_opencl = TRUE,
    stan_threads = TRUE,
    cpp_options = c(
      "-O3",
      "-march=native",
      "-mtune=native",
      "-ftree-vectorize",
      "-funroll-loops",
      "-fomit-frame-pointer"
      # Only add these if you get errors!
      #"-stdlib=libc++",
      #"-std=c++17"
    )
  ),
  force_recompile = TRUE
)


fit <- model$sample(
  data = list(
    N = 1000,
    K = 3,
    x = matrix(rnorm(1000 * 3), nrow = 1000),
    y = rnorm(1000)
  ),
  chains = 4,
  parallel_chains = 4,
  refresh = 100,
  seed = 123,
  opencl_ids = c(0, 0),
  threads_per_chain = 8,
  iter_warmup = 500,
  init = function()
    list(sigma = 1)  # Initialize sigma to 1
  
)

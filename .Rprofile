# Get existing environment variables
old_ld_library_path <- Sys.getenv("LD_LIBRARY_PATH")
old_path <- Sys.getenv("PATH")

# Set new environment variables, including the old values
Sys.setenv(
  LD_LIBRARY_PATH = paste("/usr/local/cuda-12.6/lib64", old_ld_library_path, sep = if (nzchar(old_ld_library_path)) ":" else ""),
  PATH = paste("/usr/local/cuda-12.6/bin", old_path, sep = if (nzchar(old_path)) ":" else "")
)


source("renv/activate.R")

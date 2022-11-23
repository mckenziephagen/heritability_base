# Start with R version 4.1.0
FROM ghcr.io/mckenziephagen/heritability_base:nightly
# Install some linux libraries that R packages need

# Create a directory named after our project directory
WORKDIR /heritability_base

# Copy the lockfile over to the Docker image
COPY renv.lock renv.lock

# Install all R packages specified in renv.lock - this takes a really long time 
RUN Rscript -e 'renv::restore()'

# Default to bash terminal when running docker image
CMD ["bash"]
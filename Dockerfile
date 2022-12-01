FROM rocker/r-ver:4.1.0

# Install some linux libraries that R packages need
RUN apt-get update && apt-get install -y libcurl4-openssl-dev libssl-dev libxml2-dev cmake libglu1-mesa-dev libpng-dev tcl tk libfontconfig1-dev libharfbuzz-dev libfribidi-dev libtiff5-dev 
## @ ariel, this is getting bloated, how do we cull? 
# Use renv version 
ENV RENV_VERSION 0.16.0

# Install _specific_ renv 
RUN Rscript -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN Rscript -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

# Create a directory named after our project directory
WORKDIR /tracto

# approach one
ENV RENV_PATHS_LIBRARY renv/library

# Copy the lockfile over to the Docker image
COPY renv.lock renv.lock

# Install all R packages specified in renv.lock - this takes a really long time 
#but I don't know how to do it better
RUN Rscript -e 'renv::restore()'

# Default to bash terminal when running docker image
CMD ["bash"]
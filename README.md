# rancher-os-cron-container

  * Run a cron-like script off entrypoint.  This requires that your Rancher host be pre-configured with whatever directory and executables you need to run your
    scheduled commands.  The commands are actually just sleeps that are set in your script under `./scripts/`.
    1. Drop your script into the scripts/ directory.
    2. Build the container with a clever tag.
    3. Supply the full path of your script under the `artifacts/` directory to docker as the CMD.
      
       Ex: `docker run -v /Users/jknepper/rancher-os-docker-cron/opt/cloudwatch:/opt/cloudwatchmonitoring -itd ubuntu-cron /artifacts/run_metric_scripts.sh`

         * run_metrics_scripts.sh points to a script that runs off the host through a mounted volume (above). 

---

# Docker Build:

  * `docker build --no-cache -t rancher-os-cron .`
  * `docker-compose build --no-cache`

# Docker run:

  * `docker run -v <path-to-rancher-host-directory>:/opt/cloudwatchmonitoring -itd ubuntu-cron /artifacts/run_metric_scripts.sh`

    Ex: `docker run -v /Users/jknepper/rancher-os-docker-cron/opt/cloudwatch:/opt/cloudwatchmonitoring -itd ubuntu-cron /artifacts/run_metric_scripts.sh`

  * Docker-Compose run:
    1. Export / Set your `SOURCE_DIR` variable so it can be used in your docker-compose.yml file.
      Ex: `export SOURCE_DIR=/Users/jknepper/rancher-os-docker-cron/opt/cloudwatch`
        * `docker-compose -f docker-compose.yml run --entrypoint /artifacts/run_metric_scripts.sh rancher-os-cron`


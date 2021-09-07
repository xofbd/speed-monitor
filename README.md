# Internet Speed Monitoring
A simple internet speed monitoring script using [Ookla's Speedtest CLI](https://www.speedtest.net/apps/cli) to create a JSON of network speed results.

## Getting started
If you want to use [Docker](https://www.docker.com)(recommended), skip to [Using Docker](#using-docker).

Make sure you have the following installed:

1. [Ookla's Speedtest CLI](https://www.speedtest.net/apps/cli)
1. Python 3.8+

## How it works
There are two scripts:
* `src/speed-test` creates a JSON with the network speed results
* `src/process-results` processes and condenses all the JSONs for a given day into one JSON file

## Using Docker
A `Dockerfile` is provided if you wish to run the scripts in a Docker container. A `Makefile` is also provided; all you need to do is `make run`. You can specify the optional environmental variable `TZ` if you wish to control the timezone used for the generated filenames (defaults to UTC). Without the `Makefile`, you first must create a directory named `data/snapshots`. Afterwards, build the image with
* `docker build -t speed-monitor --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) .`

and run the test with
* `docker run --rm -v $(PWD)/data/snapshots:data/snapshots speed-monitor`

To run the daily processing script, run
* `docker run --rm -v $(PWD)/data/snapshots:/data/snapshots speed-monitor process-results`

## Automation with cron
You can set up cron jobs to run snapshots at a set interval and process the generated JSONs. For example:
```bash
0,30 9-18 * * * /path/to/speed-monitor/src/run-test
2 18 * * * /path/to/speed-monitor/src/process-results
```

The above will run tests every 30 minutes from 9 am to 6 pm and condense all those snapshot results at 6:02 pm. Look at `crontab.example` for more details and examples of how your `crontab` should look like.

## License
This project is distributed under the MIT license. Please see `LICENSE` for more information.

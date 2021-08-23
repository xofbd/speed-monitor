# Internet Speed Monitoring
A simple internet speed monitoring script using [Ookla's Speedtest CLI](https://www.speedtest.net/apps/cli) to create a JSON of network speed results.

## Getting started
Make sure you have the following installed:

1. [Ookla's Speedtest CLI](https://www.speedtest.net/apps/cli)
1. Python 3.8+

## How it works
There are two scripts:
* `src/speed-test` creates a JSON with the network speed results
* `src/process-results` processes and condenses all the JSONs for a given day into one JSON file

With these two scripts, you can set up cron jobs to run snapshots at a set interval and process the generated JSONs. For example:

```bash
0,30 9-18 * * * /path/to/speed-monitor/src/run-test
1 18 * * * /path/to/speed-monitor/src/process-results
```

The above will run tests every 30 minutes from 9 am to 6 pm and condense all those snapshot results at 6:02 pm.

## Using Docker

A `Dockerfile` is provided if you wish to run the scripts in a Docker container. A `Makefile` is also provided; all you need to do is `make docker-run`. You can specify the optional environmental variable `TZ` if you wish to control the timezone used for the generated filenames (defaults to UTC). Without the `Makefie`, you can run

* `docker build -t speed-test --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) .`
* `docker run --rm -v $(PWD)/data/snapshots:data/snapshots speed-test`

## License
This project is distributed under the MIT license. Please see ``LICENSE`` for more information.

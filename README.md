# Internet Speed Monitoring
A simple internet speed monitoring script using [Ookla's Speedtest CLI](https://www.speedtest.net/apps/cli) to create a JSON of network speed results.

## Getting started
Make sure you have the following installed:

1. [Ookla's Speedtest CLI](https://www.speedtest.net/apps/cli)
1. Python 3

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

# Eventbrite API

With python script `event_cli.py`, you can send request from a terminal to
Eventbrite website. You can either copy an event or update it. 

## Install the python dependency

The python script `event_cli.py` uses built-in libraries like `requests` and
`json`. However, the event data are stored in the file `event_data.yml` that is
in `yml` format. This format is chosen as it is more user friendly than `json`.
To load a `event_data.yml`, the package `ruamel.yaml` is needed. To install it,
in a terminal:

```
pip install ruamel.yaml
```

## Run the command line

Depending on what you want to do, run one of the commands below in a terminal:

### to only copy an event

```sh
python event_cli.py --event_id id --token token --copy 
```

### to only update an event

```sh
python event_cli.py --event_id id --token token --update
```

### to first copy and then update event

```sh
python event_cli.py --event_id id --token token --copy --update
```


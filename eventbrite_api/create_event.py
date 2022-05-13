"""Script to create eventbrite events.

python create_event.py --event_id id --token token

"""

import argparse
import requests
import json

from ruamel.yaml import YAML

yaml = YAML()
yaml.default_flow_style = False

def cli():
    """create an eventbrite event."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--event_id', '-i',
                        help='ID of event in eventbrite')
    parser.add_argument('--token', '-t',
                        help='your oauth token in eventbrite')
    args = parser.parse_args()
    
    # Make headers
    headers = {
      'Authorization': f'Bearer {args.token}',
      'Content-Type': 'application/json'
    }

    ## Update an event
    # Open event data from a yml file
    with open("./event_data.yml") as f:
          event_data_dict = yaml.load(f)

    # Reformat event data to json
    event_data_json = json.dumps(event_data_dict)

    # Send the request
    request = requests.post(f'https://www.eventbriteapi.com/v3/events/{args.event_id}/', data=event_data_json, headers=headers)
    print(request)

if __name__ == "__main__":
    cli()


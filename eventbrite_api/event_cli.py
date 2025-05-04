"""Script to create eventbrite events.

python event_cli.py --event_id id --token token --copy --update
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
    parser.add_argument('--copy', '-c',
                        action='store_true',
                        help='copy an existing event')
    parser.add_argument('--update', '-u',
                        action='store_true',
                        help='update an existing event')
    parser.add_argument('--data', '-d',
                        action='store_true',
                        help='return event data in yaml format')
    args = parser.parse_args()

    # Make headers
    headers = {
        'Authorization': f'Bearer {args.token}',
        'Content-Type': 'application/json'
    }

    # Load event data from a yaml file
    with open("./event_data.yml") as f:
        event_data_dict = yaml.load(f)

    # Reformat event data to json
    event_data_json = json.dumps(event_data_dict)

    # Send the request
    url = "https://www.eventbriteapi.com/v3/events"
    if args.copy:
        response = requests.post(f'{url}/{args.event_id}/copy/', headers=headers)
        status_code = response.status_code
        if status_code == 200:
            new_event_id = response.json()["id"]
            print(f'This the id of new event : {new_event_id}')
            if args.update:
                response = requests.post(f'{url}/{new_event_id}/', data=event_data_json, headers=headers)
                status_code = response.status_code
    elif args.update:
        response = requests.post(f'{url}/{args.event_id}/', data=event_data_json, headers=headers)
        status_code = response.status_code
    else:
        print('Provide more argument: -c for copying an event, -u for updating an event')
            
    if status_code == 200:
        print('Success. Refresh the event page on eventbrite!')
        # Return event data to a yaml file
        # however, cannot be used to pass data to eventbrite!
        if args.data:
            with open("new_event_data.yml", "w+") as f:
                event_data_dict = yaml.dump(response.json(), f)
            print('Event data is stored in ./new_event_data.yml!')
    else:
        print(
        'Failed. If you are copying an event, check the event id or authorization token. '
        'If you are updating an event, check also the event data.'
        )


if __name__ == "__main__":
    cli()
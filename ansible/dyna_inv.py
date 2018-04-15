#!/usr/bin/env python
from pprint import pprint
from googleapiclient import discovery
from oauth2client.client import GoogleCredentials
import json

project = 'mydrive-1232'
zone = 'europe-west1-c'
credentials = GoogleCredentials.get_application_default()

service = discovery.build('compute', 'v1', credentials=credentials)

request = service.instances().list(project=project, zone=zone)
while request is not None:
    response = request.execute()
    instances = dict()
    for instance in response['items']:
        # TODO: Change code below to process each `instance` resource:
        ip = list()
        name = instance['name'].split('-')[1]
        ip.append(instance['networkInterfaces'][0]['accessConfigs'][0]['natIP'])
        instances[name] = ip
    request = service.instances().list_next(previous_request=request, previous_response=response)
json_data = json.dumps(instances)
print(json_data)

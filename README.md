# Hermes

A proxy server for sending notifications to HipChat, Stash, etc.

The API is running at ```http://localhost:8080/api/v1```.

## Requirements

- Python 3.6: [Instructions](https://www.python.org/downloads/)

## Installation

Run ```make``` for a local setup and then ```env/bin/start_debug``` to start the API in debug mode.

To start the uWSGI, run ```make start```

## Procedure

First, define your REST API in the configuration under ```/config/api.yml```, 
then add the Python logic for the *operationId* under /hermes/api

## SwaggerUI

Go to [here](http://localhost:8080/api/v1/ui) to view the brilliant SwaggerUI documentation of your API.## Docker

If configured, a Dockerfile ist autmatically generated at the project root. Call ``make build-docker`` to build a new image or 
``make build-and-push`` to upload the image to the registry afterwards. 

In case you want to run a container locally, run ``make start-docker``. With ``make attach-to-docker`` you can easily open a bash
on the running container.

## Healthcheck

Configure a health check under /api/v1/health (GET).

The check should return 200 if everything is fine, 424 if a depending service is not working or 503 if the API does not work correctly.
Additionally, a JSON is returned containing the fields 'health', 'dependencies' and 'message'. The first one defines the color ('green', 'yellow', 'red') that
correspond to the status codes. The second one is the name of the depending services that cannot be reached and 'message'
can hold a string defining the cause of a problem.## Resources
### Connexion
[Documentation](https://connexion.readthedocs.io/en/latest/)
[Repository](https://github.com/zalando/connexion)

### Swagger
[API.yml Editor](http://editor.swagger.io/#/)


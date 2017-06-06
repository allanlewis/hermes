import logging


import connexion
import yaml
import json
from prance import ResolvingParser

from hermes import options

logging.basicConfig(level=logging.INFO)

# Logging configuration
logger = logging.getLogger('main')
logger.setLevel(logging.INFO)

ch = logging.StreamHandler()
ch.setLevel(logging.DEBUG)
formatter = logging.Formatter(
    '%(asctime)s - %(levelname)s - %(message)s')
ch.setFormatter(formatter)
logger.addHandler(ch)



app = connexion.App("Hermes")
parsed_definition = yaml.load(open("config/api.yml"))
swagger_definiton = ResolvingParser(
    spec_string=json.dumps(parsed_definition)).specification
app.add_api(swagger_definiton,
            strict_validation=True,
            validate_responses=True)

application = app.app

if __name__ == '__main__':
    app.run(port=8080, server='flask')

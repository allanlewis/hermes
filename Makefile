.PHONY: clean start build-docker build-and-push start-docker attach-to-docker

all: env/bin/python

env/bin/python:
	python3.6 -m venv env
	env/bin/pip install --upgrade pip
	env/bin/pip install wheel
	env/bin/pip install -r requirements.txt
	env/bin/python setup.py develop

clean:
	rm -rfv bin develop-eggs dist downloads eggs env parts
	rm -fv .DS_Store .coverage .installed.cfg bootstrap.py
	rm -fv logs/*.txt
	find . -name '*.pyc' -exec rm -fv {} \;
	find . -name '*.pyo' -exec rm -fv {} \;
	find . -depth -name '*.egg-info' -exec rm -rfv {} \;
	find . -depth -name '__pycache__' -exec rm -rfv {} \;

start: env/bin/python
	env/bin/uwsgi --yaml=config/uwsgi.yml

build-docker:
	docker build -t https://dockerreg.dev.youview.co.uk:5000/alewis/hermes:latest .

build-and-push: build-docker
	docker push https://dockerreg.dev.youview.co.uk:5000/alewis/hermes:latest

start-docker:
	docker rm hermes || true
	docker run --name "hermes" -p "127.0.0.1:8080:8080" https://dockerreg.dev.youview.co.uk:5000/alewis/hermes:latest

attach-to-docker:
	docker exec -i -t hermes /bin/bashupdate-all-packages: env/bin/python
	env/bin/pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 env/bin/pip install -U

test: env/bin/python
	env/bin/py.test --cov=hermes hermes_test -vv

requirements.txt:
	pip freeze -r requirements.txt | tee requirements.txt

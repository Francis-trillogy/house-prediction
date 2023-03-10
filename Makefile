## The Makefile includes instructions on environment setup and lint tests
# Create and activate a virtual environment
# Install dependencies in requirements.txt
# Dockerfile should pass hadolint
# app.py should pass pylint
# (Optional) Build a simple integration test

setup:
# 	Create python virtualenv & source it
	python3 -m venv ~/.devops
	# source ~/.devops/bin/activate


install:
# This should be run from inside a virtualenv
	pip install --no-cache-dir pip==23.0.1 && pip install --no-cache-dir -r requirements.txt

env:
	#Show information about environment
	which python3
	python3 --version
	which pytest
	which pylint

test:
# Additional, optional, tests could go here
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb

lint:
# See local hadolint install instructions:   https://github.com/hadolint/hadolint
# This is linter for Dockerfiles
	# ~/hadolint-Linux-x86_64 Dockerfile 
	
	hadolint Dockerfile
# This is a linter for Python source code linter: https://www.pylint.org/
# This should be run from inside a virtualenv
	pylint --disable=R,C,W1203,W1202 flask-app/predict.py

all: setup install env lint test

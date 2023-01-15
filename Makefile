PYTHONPATH=./src/
PYTHON=./venv/bin/python

lint: venv/bin/activate
	@$(PYTHON) -m flake8 src/
	@$(PYTHON) -m mypy src/

format: venv/bin/activate
	@$(PYTHON) -m black src/ $(ARGS)

test: venv/bin/activate
	PYTHONPATH=./src/ $(PYTHON) -m pytest --cov=src/ --cov-report=term --cov-report=html .

venv/bin/activate: requirements-dev.txt
	python -m venv venv
	./venv/bin/pip install -r requirements-dev.txt

build: venv/bin/activate
	$(PYTHON) -m flit build

publish: venv/bin/activate
	$(PYTHON) -m flit publish

clean:
	rm -rf __pycache__
	rm -rf venv

.PHONY: clean example

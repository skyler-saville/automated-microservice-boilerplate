#!/bin/bash

# Check if the project already exists
if [ -d mylib ] || [ -f mylib/__init__.py ]; then
  echo "Project already exists. Aborting initialization."
else
	# Run the needed make commands from within this shell script
	make venv
	make source-venv
	source .venv/bin/activate

  # Create project directories
  touch main.py
  mkdir -p mylib
  mkdir -p mylib/logic
  mkdir -p mylib/utils
  mkdir -p mylib/tests
  mkdir -p mylib/config
  mkdir -p mylib/exceptions
  touch mylib/__init__.py

# Create project files with Python comment placeholders
		echo '# Placeholder for data_access.py' > mylib/logic/data_access.py
		echo '# Placeholder for business_logic.py' > mylib/logic/business_logic.py
		echo '# Placeholder for api_handling.py' > mylib/logic/api_handling.py
		echo '# Placeholder for utils.py' > mylib/utils/utils.py
		echo '# Placeholder for config.py' > mylib/config/config.py
		echo '# Placeholder for custom_exceptions.py' > mylib/exceptions/custom_exceptions.py
		touch mylib/logic/__init__.py
		touch mylib/utils/__init__.py
		touch mylib/tests/__init__.py
		touch mylib/config/__init__.py
		touch mylib/exceptions/__init__.py

		# Create requirements.txt with common dependencies
		echo 'fastapi==0.68.1' > requirements.txt
		echo 'uvicorn==0.15.0' >> requirements.txt
		echo 'pytest==7.4.2' >> requirements.txt
		echo 'pylint==3.0.1' >> requirements.txt
		echo 'black==23.9.1' >> requirements.txt
		echo 'wikipedia==1.4.0' >> requirements.txt
		echo 'textblob==0.17.1' >> requirements.txt
		echo 'httpx==0.25.0' >> requirements.txt
		echo 'nltk==3.8.1' >> requirements.txt

		# Create a basic README.md file
		echo '# My Microservice' > README.md
		echo 'This is a detailed README for my microservice, explaining its purpose, features, and how to get started with development.' >> README.md
		echo '## Purpose' >> README.md
		echo 'The purpose of this microservice is to...' >> README.md
		echo '## Features' >> README.md
		echo '- Feature 1: ...' >> README.md
		echo '- Feature 2: ...' >> README.md
		echo '- Feature 3: ...' >> README.md
		echo '## Getting Started' >> README.md
		echo 'To get started with development, follow these steps:' >> README.md
		echo '1. Fork this repository.' >> README.md
		echo '2. Clone your forked repository to your local machine.' >> README.md
		echo '3. Activate the virtual environment: `source .venv/bin/activate`' >> README.md
		echo '4. Install the project dependencies using the Makefile: `make install`' >> README.md
		echo '5. Start developing your microservice!' >> README.md

		# Create a basic Dockerfile
		echo 'FROM python:3.8-slim' > Dockerfile
		echo 'WORKDIR /app' >> Dockerfile
		echo 'COPY . /app/' >> Dockerfile
		echo 'RUN pip install -r requirements.txt' >> Dockerfile
		echo 'EXPOSE 8080' >> Dockerfile
		echo 'CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]' >> Dockerfile

		# Create a logging configuration file (logging.conf)
		echo '[loggers]' > logging.conf
		echo 'keys=root' >> logging.conf
		echo '' >> logging.conf
		echo '[handlers]' >> logging.conf
		echo 'keys=consoleHandler' >> logging.conf
		echo '' >> logging.conf
		echo '[formatters]' >> logging.conf
		echo 'keys=consoleFormatter' >> logging.conf
		echo '' >> logging.conf
		echo '[logger_root]' >> logging.conf
		echo 'level=DEBUG' >> logging.conf
		echo 'handlers=consoleHandler' >> logging.conf
		echo '' >> logging.conf
		echo '[handler_consoleHandler]' >> logging.conf
		echo 'class=StreamHandler' >> logging.conf
		echo 'level=DEBUG' >> logging.conf
		echo 'formatter=consoleFormatter' >> logging.conf
		echo '' >> logging.conf
		echo '[formatter_consoleFormatter]' >> logging.conf
		echo 'format=%(asctime)s - %(name)s - %(levelname)s - %(message)s' >> logging.conf

		# Add a basic monitoring setup example
		echo 'Monitoring setup goes here' > monitoring-setup.txt

		# Add a basic testing and quality assurance setup
		echo 'Testing and QA setup goes here' > mylib/tests/testing-and-qa-setup.txt

		# Add Contributing Guidelines
		echo 'Contributing Guidelines go here' > CONTRIBUTING.md

		# Add a Documentation Standards section
		echo 'Documentation Standards go here' > documentation-standards.md

		# install the python libraries
		make install
		make post-install
		make update-requirements


		make clean-venv-state
		echo 'Project initialized. You can start developing your microservice.'; \
	fi

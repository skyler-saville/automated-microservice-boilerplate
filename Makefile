# Create a Python Virtual Environment
venv:
	@if [ ! -d .venv ]; then \
		echo "Creating a Python Virtual Environment file..."; \
		virtualenv .venv; \
		echo "Python Virtual Environment file created."; \
	else \
		echo "Python Virtual Environment file already exists."; \
	fi

# Source the Python Virtual Environment
source-venv:
	@echo "To activate the virtual environment, run the following command in your terminal:"
	@echo "source .venv/bin/activate"
	@. .venv/bin/activate

# Initialize the project structure, create a virtual environment, and source it
init: 
	@echo "Initializing the project structure..."
	./init_project.sh
	@echo "Project initialized."

# Install project dependencies
install: 
	@echo "Installing project dependencies..."
	@pip install --upgrade pip &&\
		pip install -r requirements.txt
	@echo "Project dependencies installed."

# Install textblob dependency
post-install: 
	@echo "Installing textblob dependency..."
	@python -m textblob.download_corpora
	@echo "Textblob dependency installed."


# Update the requirements.txt file with the installed packages
update-requirements: venv source-venv
	@echo "Updating the requirements.txt file..."
	@pip freeze > requirements.txt
	@echo "requirements.txt file updated."

# Format the code using Black
format: check-venv
	@echo "Formatting code using Black..."
	@black *.py mylib/*.py
	@echo "Code formatted."

# Lint the code using Pylint
lint: check-venv
	@echo "Linting code using Pylint..."
	@pylint --disable=R,C *.py mylib/*.py
	@echo "Code linted."

# Run unit tests using pytest
test: 
	@echo "Running unit tests using pytest..."
	@python -m pytest -vv --cov=mylib --cov=main test_*.py
	@echo "Unit tests complete."

# Build a Docker container
build: 
	@echo "Building a Docker container..."
	@docker build -t deploy-fastapi .
	@echo "Docker container built."

# Run the Docker container
run:
	@echo "Running the Docker container..."
	@docker run -p 127.0.0.1:8080:8080 deploy-fastapi

# Deploy the microservice (additional details needed)
deploy: 
	@echo "Deployment details needed to proceed."


# Add a new target to activate the virtual environment
start-venv:
	@VENV_ACTIVE=0; \
	if [ -f .venv_active ]; then \
		VENV_ACTIVE=$$(cat .venv_active); \
	fi; \
	if [ "$$VENV_ACTIVE" -eq 1 ]; then \
		echo "Virtual environment is already active"; \
	else \
		echo "To activate the virtual environment, run the following command in your terminal:"; \
		echo "source .venv/bin/activate"; \
		. .venv/bin/activate; \
	fi


# Check status of python virtual environment and set VENV_ACTIVE accordingly
check-venv:
	@if [ -n "$$VIRTUAL_ENV" ]; then \
		echo "Virtual environment is ACTIVE: $$VIRTUAL_ENV"; \
		echo "Python interpreter in use: $$(which python)" \
		echo "VENV_ACTIVE=1" > .venv_active; \
	else \
		echo "Virtual environment is NOT ACTIVE"; \
		echo "Python interpreter in use: $$(which python)" \
		echo "VENV_ACTIVE=0" > .venv_active; \
	fi

# Deactivate the python virtual environment if it was active
stop-venv:
	@VENV_ACTIVE=0; \
	if [ -f .venv_active ]; then \
		VENV_ACTIVE=$$(cat .venv_active); \
	fi; \
	if [ "$$VENV_ACTIVE" -eq 1 ]; then \
		deactivate; \
		echo "Deactivated virtual environment"; \
	else \
		echo "No active virtual environment to deactivate"; \
	fi

# Clean up VENV_ACTIVE
clean-venv-state:
	@VENV_ACTIVE=0; \
	if [ -f .venv_active ]; then \
		VENV_ACTIVE=$$(cat .venv_active | cut -d= -f2); \
		rm -f .venv_active; \
	fi; \
	if [ "$$VENV_ACTIVE" -eq 1 ]; then \
		deactivate; \
	fi

# Delete all files, the .venv directory, and the mylib directory in the current directory except Makefile and init_project.sh
clean: stop-venv
	@echo "Cleaning the project..."
	@find . -maxdepth 1 -type f ! -name "Makefile" ! -name "init_project.sh" -exec rm -f {} \;
	@rm -rf .venv mylib
	@echo "Project cleaned."

# Provide instructions for each available target
instruct:
	@echo "Makefile Targets and Instructions:"
	@echo "---------------------------------------------------------"
	@echo "1. make venv: Create a Python Virtual Environment."
	@echo "2. make source-venv: Source the Python Virtual Environment."
	@echo "3. make init: Initialize the project structure, create a virtual environment, and source it."
	@echo "4. make install: Install project dependencies."
	@echo "5. make post-install: Install textblob dependency."
	@echo "6. make update-requirements: Update the requirements.txt file with the installed packages."
	@echo "7. make format: Format the code using Black."
	@echo "8. make lint: Lint the code using Pylint."
	@echo "9. make test: Run unit tests using pytest."
	@echo "10. make build: Build a Docker container."
	@echo "11. make run: Run the Docker container."
	@echo "12. make deploy: Deploy the microservice (additional details needed)."
	@echo "13. make start-venv: Start the virtual environment if it's not already active."
	@echo "14. make check-venv: Check if the virtual environment is active."
	@echo "15. make stop-venv: Deactivate the virtual environment if it's active."
	@echo "16. make clean-venv-state: Clean up VENV_ACTIVE."
	@echo "17. make clean: Delete all files, the .venv directory, and the mylib directory in the current directory except Makefile and init_project.sh."
	@echo "---------------------------------------------------------"
	@echo "For a detailed description of each step and its purpose, you can check the Makefile comments."
	@echo "Please follow these steps in order to set up your project."
	@echo "Thank you and happy coding!"

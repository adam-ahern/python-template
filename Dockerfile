# Use an official Python runtime as a parent image
FROM python:3.9-slim-buster

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container
COPY . /app/

# Install poetry
RUN pip install poetry

# Install project dependencies
RUN poetry install

# Run main.py when the container launches
CMD ["python", "my_module/main.py"]

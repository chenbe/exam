# Use an official Python runtime as a parent image
FROM python:3.6.8-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY counter-service.py /app/

# Install any needed packages specified in requirements.txt
RUN pip install Flask

# Make port 80 available to the world outside this container
EXPOSE 80

# Define the command to run your application
CMD ["python", "counter_service.py"]


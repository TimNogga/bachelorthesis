FROM python:3.10-slim

# Install git
RUN apt-get update && apt-get install -y git

# Create the folder and set it as home
WORKDIR /bachelorthesis

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
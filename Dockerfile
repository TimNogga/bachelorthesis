FROM python:3.10-slim

# 1. Install System Dependencies
# dlib needs: cmake, build-essential, and linear algebra libs (openblas/lapack)
RUN apt-get update && apt-get install -y \
    git \
    git-lfs \
    cmake \
    build-essential \
    wget \
    libopenblas-dev \
    liblapack-dev \
    libx11-dev \
    libgtk-3-dev \
    && git lfs install \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /bachelorthesis

# 2. Install dlib SEPARATELY first
# This prevents it from blocking other packages and allows us to see errors clearly.
# We use --verbose so you can see the compilation progress in the logs.
RUN pip install --upgrade pip && \
    pip install --no-cache-dir --verbose dlib

# 3. Install the rest of your libraries
COPY requirements.txt .
# Remove dlib from requirements.txt to avoid double-install (sed deletes the line)
RUN sed -i '/dlib/d' requirements.txt && \
    pip install --no-cache-dir -r requirements.txt

# 4. Keep container alive
CMD ["/bin/sh", "-c", "while sleep 1000; do :; done"]
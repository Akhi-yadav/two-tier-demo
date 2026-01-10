# ------------------- Stage 1: Build Stage ------------------------------
    FROM python:3.12 AS builder

    WORKDIR /app
    
    # Install build dependencies
    RUN apt-get update && \
        apt-get install -y --no-install-recommends gcc default-libmysqlclient-dev pkg-config && \
        rm -rf /var/lib/apt/lists/*
    
    # Copy and install Python dependencies
    COPY requirements.txt .
    RUN pip install --no-cache-dir -r requirements.txt
    
    # ------------------- Stage 2: Final Stage ------------------------------
    FROM python:3.12-slim
    
    WORKDIR /app

    
    # Copy dependencies and application code from the builder stage
    COPY --from=builder /usr/local/lib/python3.12/site-packages/ /usr/local/lib/python3.12/site-packages/
    COPY . .
    
    CMD ["python", "app.py"]
    



# # Use an official Python runtime as the base image
# FROM python:3.9-slim

# # Set the working directory in the container
# WORKDIR /app

# # install required packages for system
# RUN apt-get update \
#     && apt-get upgrade -y \
#     && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
#     && rm -rf /var/lib/apt/lists/*

# # Copy the requirements file into the container
# COPY requirements.txt .

# # Install app dependencies
# RUN pip install mysqlclient
# RUN pip install --no-cache-dir -r requirements.txt

# # Copy the rest of the application code
# COPY . .

# # Specify the command to run your application
# CMD ["python", "app.py"]


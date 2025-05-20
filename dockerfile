# Base image
FROM python:3.11-slim

# Install dependencies
RUN apt-get update && \
    apt-get install -y git curl unzip openjdk-17-jdk && \
    rm -rf /var/lib/apt/lists/*

# Install Allure
RUN mkdir -p /opt && \
    curl -o allure.zip -L https://github.com/allure-framework/allure2/releases/latest/download/allure-2.27.0.zip && \
    unzip allure.zip -d /opt/ && \
    ln -s /opt/allure-2.27.0/bin/allure /usr/bin/allure && \
    rm allure.zip

# Set environment variable for Allure
ENV PATH="/opt/allure-2.27.0/bin:${PATH}"

# Install Python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . /app
WORKDIR /app

# Default command (can be overridden in Jenkins or Docker run)
CMD ["pytest"]

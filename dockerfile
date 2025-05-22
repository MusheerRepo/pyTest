# Base image
FROM python:3.11-slim

# Install required packages
RUN apt-get update && \
    apt-get install -y git curl unzip openjdk-17-jdk && \
    rm -rf /var/lib/apt/lists/*

# Set Allure version
ENV ALLURE_VERSION=2.27.0

# Install Allure CLI
RUN curl -sL "https://github.com/allure-framework/allure2/releases/download/${ALLURE_VERSION}/allure-${ALLURE_VERSION}.zip" -o /tmp/allure.zip && \
    unzip /tmp/allure.zip -d /opt && \
    mv /opt/allure-${ALLURE_VERSION} /opt/allure && \
    ln -s /opt/allure/bin/allure /usr/bin/allure && \
    rm /tmp/allure.zip

# Set environment variable for Allure
ENV PATH="/opt/allure/bin:${PATH}"

# Verify Allure installation
RUN allure --version

# Copy and install Python dependencies
COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Copy app code and set workdir
COPY . /app
WORKDIR /app

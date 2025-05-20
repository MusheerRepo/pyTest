# Base image
FROM python:3.11-slim

# Install required packages
RUN apt-get update && \
    apt-get install -y git curl unzip openjdk-17-jdk && \
    rm -rf /var/lib/apt/lists/*

# Set Allure version
ENV ALLURE_VERSION=2.27.0

# Install Allure
RUN mkdir -p /opt && \
    curl -sL "https://github.com/allure-framework/allure2/releases/download/${ALLURE_VERSION}/allure-${ALLURE_VERSION}.zip" -o allure.zip && \
    unzip allure.zip && \
    mv allure-${ALLURE_VERSION} /opt/ && \
    ln -s /opt/allure-${ALLURE_VERSION}/bin/allure /usr/bin/allure && \
    rm allure.zip

# Set environment variable for Allure
ENV PATH="/opt/allure-${ALLURE_VERSION}/bin:${PATH}"

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code and set workdir
COPY . /app
WORKDIR /app

# Default command
CMD ["pytest"]

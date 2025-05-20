FROM python:3.12-slim

# Install Java, Git, curl, unzip
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    git \
    curl \
    unzip \
    && apt-get clean

# Install pip packages
COPY requirements.txt /app/requirements.txt
RUN pip install --upgrade pip && pip install -r /app/requirements.txt

# Install Allure CLI
RUN curl -o allure.zip -L https://github.com/allure-framework/allure2/releases/latest/download/allure-2.27.0.zip && \
    unzip allure.zip -d /opt/ && \
    ln -s /opt/allure-2.27.0/bin/allure /usr/bin/allure && \
    rm allure.zip

# Set workdir
WORKDIR /app

CMD ["pytest"]

FROM jenkins/jenkins:lts

USER root
WORKDIR /app

# Copy project files and requirements.txt
COPY . .

# Install Python, venv, pip, and curl
RUN apt-get update && apt-get install -y python3 python3-venv python3-pip curl

# Create a virtual environment and install Python dependencies
RUN python3 -m venv /opt/venv \
 && /opt/venv/bin/pip install --upgrade pip \
 && /opt/venv/bin/pip install --no-cache-dir -r requirements.txt

# Add the venv to the PATH
ENV PATH="/opt/venv/bin:$PATH"

# Fix permissions for allure-results output directory
RUN mkdir -p output/allure-results \
 && chown -R jenkins:jenkins output

# Install kubectl for ARM64 architecture
RUN curl -LO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl" \
 && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
 && rm kubectl

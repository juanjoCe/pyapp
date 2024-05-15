FROM python:3.8

# Install Google Cloud SDK
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz \
  && mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh

# Install Google Fluentd
RUN curl -sSO https://dl.google.com/cloudagents/add-google-cloud-logging-agent-repo.sh \
  && bash add-google-cloud-logging-agent-repo.sh --quiet \
  && apt-get update && apt-get install -y google-fluentd

# Set working directory
WORKDIR /app

# Copy application code
COPY . .

# Install dependencies
RUN pip install -r requirements.txt

# Expose port
EXPOSE 5000

# Set environment variable for Google Application Credentials
ENV GOOGLE_APPLICATION_CREDENTIALS="/root/service-account-key.json"

# Run Google Fluentd and your application
CMD google-fluentd && python app.py


# # Use an official Python runtime as a parent image
# FROM python:3.8

# RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz \
#   && mkdir -p /usr/local/gcloud \
#   && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
#   && /usr/local/gcloud/google-cloud-sdk/install.sh

# WORKDIR /app

# COPY . .

# RUN pip install -r requirements.txt

# EXPOSE 5000

# CMD ["python", "app.py"]
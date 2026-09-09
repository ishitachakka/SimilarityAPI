# Use the official Python image as base
FROM python:3.12.4-bookworm

# Set the working directory inside the container
WORKDIR /usr/src/app
COPY . /usr/src/app

# Install system dependencies required for psutil
RUN apt-get update && apt-get install -y gcc python3-dev

# Set environment variables from build arguments
ARG OPENAI_API_KEY
ARG QDRANT_HOST
ARG QDRANT_API_KEY
ARG QDRANT_COLLECTION_NAME

ENV OPENAI_API_KEY $OPENAI_API_KEY
ENV QDRANT_HOST $QDRANT_HOST
ENV QDRANT_API_KEY $QDRANT_API_KEY
ENV QDRANT_COLLECTION_NAM $QDRANT_COLLECTION_NAME

# Upgrade pip and install dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port Uvicorn will run on
EXPOSE 8000

# Correct ENTRYPOINT syntax
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

# Build stage
FROM node:20-slim AS build-stage

WORKDIR /app

COPY package*.json ./
RUN npm install --ignore-scripts

COPY . .
RUN npm run build

# Runtime stage
FROM python:3.11-slim

WORKDIR /app

# Install security updates and system dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the built frontend and other necessary files
COPY --from=build-stage /app/static ./static
COPY --from=build-stage /app/templates ./templates
COPY --from=build-stage /app/main.py ./
COPY --from=build-stage /app/macro.py ./
COPY --from=build-stage /app/.env ./

# Expose the port
EXPOSE 5002

# Set environment variables
ENV PORT=5002
ENV FLASK_HOST=0.0.0.0

# Run the application
CMD ["python", "main.py"]

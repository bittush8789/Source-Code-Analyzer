#!/bin/bash

echo "🚀 Starting Local Setup..."

# 1. Build and Run with Docker Compose
echo "📦 Building Docker containers..."
docker-compose up --build -d

echo "✅ App is running at http://localhost:8080"
echo "📊 Monitoring stack setup (optional)..."
# Add commands to install Prometheus/Grafana via Helm if Kind is used

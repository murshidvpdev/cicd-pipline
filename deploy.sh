#!/bin/bash

set -e

echo "Starting deployment..."

PROJECT_DIR="$HOME/devops-practice/learn-cicd"

echo "Moving to project directory..."
cd "$PROJECT_DIR"

echo "Stopping old app..."
pkill -f uvicorn || true

echo "Installing dependencies..."
./venv/bin/pip install -r requirements.txt

echo "Starting app..."

nohup ./venv/bin/uvicorn app:app \
  --host 0.0.0.0 \
  --port 8000 \
  > app.log 2>&1 &

echo "Waiting for app..."
sleep 5

echo "Checking logs..."
cat app.log

echo "Health check..."
curl http://localhost:8000/health

echo ""
echo "Deployment successful!"
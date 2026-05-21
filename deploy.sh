#!/bin/bash

set -e

echo "Starting deployment..."

echo "Stopping old app..."
pkill -f uvicorn || true

echo "Activating venv..."
source venv/bin/activate

echo "Installing dependencies..."
pip install -r requirements.txt

echo "Starting app..."

nohup uvicorn app:app \
  --host 0.0.0.0 \
  --port 8000 \
  > app.log 2>&1 &

echo "Waiting for app..."
sleep 3

echo "Running health check..."
curl http://localhost:8000/health

echo ""
echo "Deployment complete"
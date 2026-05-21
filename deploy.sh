#!/bin/bash

set -e

echo "===== DEBUG INFO ====="
whoami
pwd
hostname
which python
which uvicorn
env | grep RUNNER || true
echo "======================"

echo "Starting deployment..."

echo "Starting deployment..."

PROJECT_DIR="$HOME/devops-practice/learn-cicd"

echo "Moving to project directory..."
cd "$PROJECT_DIR"

echo "Stopping old app..."
pkill -f uvicorn || true

echo "Installing dependencies..."
./venv/bin/pip install -r requirements.txt

echo "Starting app..."

./venv/bin/python3 -c "
import subprocess
p = subprocess.Popen(
    ['./venv/bin/uvicorn', 'app:app', '--host', '0.0.0.0', '--port', '8000'],
    stdout=open('app.log', 'w'),
    stderr=subprocess.STDOUT,
    start_new_session=True
)
print('Started uvicorn with PID', p.pid)
"

echo "Waiting for app..."
sleep 5

echo "Checking logs..."
cat app.log

echo "Health check..."
curl http://localhost:8000/health

echo ""
echo "Deployment successful!"
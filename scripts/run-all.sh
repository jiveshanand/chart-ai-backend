#!/bin/bash

# Script to run all microservices concurrently

echo "Starting Chart AI Backend Services..."
echo "======================================"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to cleanup on exit
cleanup() {
    echo -e "\n${BLUE}Stopping all services...${NC}"
    kill $(jobs -p) 2>/dev/null
    exit 0
}

# Set trap to cleanup on CTRL+C
trap cleanup SIGINT SIGTERM

# Get the script directory and project root
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "$SCRIPT_DIR/.." && pwd )"

# Start Chart Service
echo -e "${GREEN}Starting Chart Service on port 8001...${NC}"
cd "$PROJECT_ROOT/services/chart-service"
poetry run uvicorn app.main:app --reload --port 8001 > /tmp/chart-service.log 2>&1 &
CHART_PID=$!

# Wait a moment
sleep 2

# Start Data Service
echo -e "${GREEN}Starting Data Service on port 8002...${NC}"
cd "$PROJECT_ROOT/services/data-service"
poetry run uvicorn app.main:app --reload --port 8002 > /tmp/data-service.log 2>&1 &
DATA_PID=$!

# Wait a moment
sleep 2

echo -e "\n${GREEN}All services started!${NC}"
echo "======================================"
echo "Chart Service: http://localhost:8001/docs"
echo "Data Service:  http://localhost:8002/docs"
echo ""
echo "Logs:"
echo "  Chart Service: tail -f /tmp/chart-service.log"
echo "  Data Service:  tail -f /tmp/data-service.log"
echo ""
echo "Press CTRL+C to stop all services"
echo "======================================"

# Wait for all background jobs
wait

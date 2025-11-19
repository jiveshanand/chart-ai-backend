#!/bin/bash

# Script to set up the project using Python venv (alternative to Poetry)

echo "Setting up Chart AI Backend with Python venv..."
echo "================================================"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get the script directory and project root
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "$SCRIPT_DIR/.." && pwd )"

cd "$PROJECT_ROOT"

# Check Python version
echo -e "${BLUE}Checking Python version...${NC}"
PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
echo "Found Python $PYTHON_VERSION"

# Create virtual environment
echo -e "\n${BLUE}Creating virtual environment...${NC}"
if [ -d "venv" ]; then
    echo -e "${YELLOW}Virtual environment already exists. Skipping creation.${NC}"
else
    python3 -m venv venv
    echo -e "${GREEN}Virtual environment created successfully!${NC}"
fi

# Activate virtual environment
echo -e "\n${BLUE}Activating virtual environment...${NC}"
source venv/bin/activate

# Upgrade pip
echo -e "\n${BLUE}Upgrading pip...${NC}"
pip install --upgrade pip

# Install dependencies
echo -e "\n${BLUE}Installing dependencies...${NC}"
echo "This may take a few minutes..."

# Core dependencies
pip install fastapi "uvicorn[standard]" pydantic pydantic-settings python-dotenv httpx

# Dev dependencies
pip install pytest pytest-asyncio black ruff

# Create requirements.txt for reference
pip freeze > requirements.txt
echo -e "${GREEN}Dependencies installed successfully!${NC}"

# Create .env files from examples
echo -e "\n${BLUE}Setting up environment files...${NC}"

if [ ! -f "services/chart-service/.env" ]; then
    cp services/chart-service/.env.example services/chart-service/.env
    echo -e "${GREEN}Created services/chart-service/.env${NC}"
else
    echo -e "${YELLOW}services/chart-service/.env already exists${NC}"
fi

if [ ! -f "services/data-service/.env" ]; then
    cp services/data-service/.env.example services/data-service/.env
    echo -e "${GREEN}Created services/data-service/.env${NC}"
else
    echo -e "${YELLOW}services/data-service/.env already exists${NC}"
fi

echo -e "\n${GREEN}Setup complete!${NC}"
echo "================================================"
echo -e "${BLUE}To activate the virtual environment:${NC}"
echo "  source venv/bin/activate"
echo ""
echo -e "${BLUE}To run the services:${NC}"
echo ""
echo -e "${YELLOW}Terminal 1 - Chart Service:${NC}"
echo "  cd services/chart-service"
echo "  python -m uvicorn app.main:app --reload --port 8001"
echo ""
echo -e "${YELLOW}Terminal 2 - Data Service:${NC}"
echo "  cd services/data-service"
echo "  python -m uvicorn app.main:app --reload --port 8002"
echo ""
echo -e "${BLUE}API Documentation will be available at:${NC}"
echo "  Chart Service: http://localhost:8001/docs"
echo "  Data Service:  http://localhost:8002/docs"
echo ""
echo -e "${BLUE}To deactivate the virtual environment:${NC}"
echo "  deactivate"
echo "================================================"

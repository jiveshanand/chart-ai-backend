#!/bin/bash

# Script to install dependencies for all services

echo "Installing dependencies for all services..."
echo "==========================================="

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the script directory and project root
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "$SCRIPT_DIR/.." && pwd )"

# Install root dependencies
echo -e "${BLUE}Installing root workspace dependencies...${NC}"
cd "$PROJECT_ROOT"
poetry install

# Install chart-service dependencies
echo -e "\n${BLUE}Installing chart-service dependencies...${NC}"
cd "$PROJECT_ROOT/services/chart-service"
poetry install

# Install data-service dependencies
echo -e "\n${BLUE}Installing data-service dependencies...${NC}"
cd "$PROJECT_ROOT/services/data-service"
poetry install

echo -e "\n${GREEN}All dependencies installed successfully!${NC}"
echo "==========================================="
echo "You can now run the services with:"
echo "  ./scripts/run-all.sh"
echo "Or individually:"
echo "  cd services/chart-service && poetry run python -m app.main"
echo "  cd services/data-service && poetry run python -m app.main"

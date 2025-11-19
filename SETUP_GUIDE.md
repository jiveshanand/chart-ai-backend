# Local Setup Guide - Chart AI Backend

This guide will walk you through cloning and running the Chart AI Backend project on your local machine.

## Prerequisites

Before you begin, ensure you have the following installed:

- **Python 3.9 or higher** - [Download Python](https://www.python.org/downloads/)
- **Git** - [Download Git](https://git-scm.com/downloads)
- **Poetry** (recommended) OR **pip** for traditional venv

## Step-by-Step Setup

### Option 1: Using Poetry (Recommended)

Poetry manages dependencies and virtual environments automatically.

#### Step 1: Install Poetry

**macOS/Linux/WSL:**
```bash
curl -sSL https://install.python-poetry.org | python3 -
```

**Windows (PowerShell):**
```powershell
(Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | py -
```

**Alternative (using pip):**
```bash
pip install poetry
```

**Verify installation:**
```bash
poetry --version
```

#### Step 2: Clone the Repository

```bash
# Clone the repository
git clone <your-repository-url> chart-ai-backend

# Navigate to the project directory
cd chart-ai-backend

# Checkout the development branch
git checkout claude/poetry-fastapi-workspace-0184rfEVyqk4Cb6dieExKA8G
```

#### Step 3: Install Dependencies

**Option A: Use the provided script (Linux/macOS):**
```bash
chmod +x scripts/install-all.sh
./scripts/install-all.sh
```

**Option B: Install manually:**

```bash
# Install root workspace dependencies
poetry install

# Install chart-service dependencies
cd services/chart-service
poetry install
cd ../..

# Install data-service dependencies
cd services/data-service
poetry install
cd ../..
```

#### Step 4: Configure Environment Variables

```bash
# Copy example environment files
cp services/chart-service/.env.example services/chart-service/.env
cp services/data-service/.env.example services/data-service/.env

# Optional: Edit the .env files to customize configuration
# nano services/chart-service/.env
# nano services/data-service/.env
```

#### Step 5: Run the Services

**Option A: Run all services together (Linux/macOS):**
```bash
chmod +x scripts/run-all.sh
./scripts/run-all.sh
```

**Option B: Run services individually in separate terminals:**

**Terminal 1 - Chart Service:**
```bash
cd services/chart-service
poetry run uvicorn app.main:app --reload --port 8001
```

**Terminal 2 - Data Service:**
```bash
cd services/data-service
poetry run uvicorn app.main:app --reload --port 8002
```

#### Step 6: Verify Services are Running

Open your browser and visit:
- **Chart Service API Docs**: http://localhost:8001/docs
- **Data Service API Docs**: http://localhost:8002/docs
- **Chart Service Health**: http://localhost:8001/health
- **Data Service Health**: http://localhost:8002/health

---

### Option 2: Using Traditional Python venv

If you prefer not to use Poetry, you can use Python's built-in venv.

#### Step 1: Clone the Repository

```bash
# Clone the repository
git clone <your-repository-url> chart-ai-backend

# Navigate to the project directory
cd chart-ai-backend

# Checkout the development branch
git checkout claude/poetry-fastapi-workspace-0184rfEVyqk4Cb6dieExKA8G
```

#### Step 2: Create Virtual Environment

**Linux/macOS:**
```bash
# Create a virtual environment
python3 -m venv venv

# Activate the virtual environment
source venv/bin/activate
```

**Windows:**
```cmd
# Create a virtual environment
python -m venv venv

# Activate the virtual environment
venv\Scripts\activate
```

#### Step 3: Install Dependencies

Once the virtual environment is activated, install dependencies:

```bash
# Upgrade pip
pip install --upgrade pip

# Install dependencies for chart-service
pip install fastapi uvicorn[standard] pydantic pydantic-settings python-dotenv httpx

# Install dev dependencies
pip install pytest pytest-asyncio black ruff
```

#### Step 4: Configure Environment Variables

```bash
# Linux/macOS
cp services/chart-service/.env.example services/chart-service/.env
cp services/data-service/.env.example services/data-service/.env

# Windows
copy services\chart-service\.env.example services\chart-service\.env
copy services\data-service\.env.example services\data-service\.env
```

#### Step 5: Run the Services

**Terminal 1 - Chart Service:**
```bash
# Activate venv if not already activated
source venv/bin/activate  # Linux/macOS
# OR
venv\Scripts\activate  # Windows

# Run chart service
cd services/chart-service
python -m uvicorn app.main:app --reload --port 8001
```

**Terminal 2 - Data Service:**
```bash
# Activate venv if not already activated
source venv/bin/activate  # Linux/macOS
# OR
venv\Scripts\activate  # Windows

# Run data service
cd services/data-service
python -m uvicorn app.main:app --reload --port 8002
```

#### Step 6: Verify Services are Running

Same as Poetry option - visit:
- http://localhost:8001/docs (Chart Service)
- http://localhost:8002/docs (Data Service)

---

## Quick Reference Commands

### Poetry Commands

```bash
# Activate Poetry shell (optional, for interactive work)
poetry shell

# Run a command in the Poetry environment
poetry run <command>

# Add a new dependency
poetry add <package-name>

# Add a dev dependency
poetry add --group dev <package-name>

# Update dependencies
poetry update

# Show installed packages
poetry show

# Check for dependency issues
poetry check
```

### venv Commands

```bash
# Activate virtual environment
source venv/bin/activate  # Linux/macOS
venv\Scripts\activate     # Windows

# Deactivate virtual environment
deactivate

# Install a package
pip install <package-name>

# Save current dependencies
pip freeze > requirements.txt

# Install from requirements file
pip install -r requirements.txt
```

## Testing the API

### Using cURL

**Test Chart Service:**
```bash
# Health check
curl http://localhost:8001/health

# Get chart types
curl http://localhost:8001/api/v1/chart-types

# Create a chart
curl -X POST http://localhost:8001/api/v1/charts \
  -H "Content-Type: application/json" \
  -d '{
    "chart_type": "bar",
    "data": [
      {"category": "A", "value": 100},
      {"category": "B", "value": 150}
    ]
  }'
```

**Test Data Service:**
```bash
# Health check
curl http://localhost:8002/health

# List data sources
curl http://localhost:8002/api/v1/sources

# Query data
curl -X POST http://localhost:8002/api/v1/query \
  -H "Content-Type: application/json" \
  -d '{
    "source_id": "src_1",
    "query": "SELECT * FROM data"
  }'
```

### Using Python Requests

```python
import requests

# Test Chart Service
response = requests.get("http://localhost:8001/health")
print(response.json())

# Create a chart
chart_data = {
    "chart_type": "bar",
    "data": [
        {"category": "A", "value": 100},
        {"category": "B", "value": 150}
    ]
}
response = requests.post("http://localhost:8001/api/v1/charts", json=chart_data)
print(response.json())
```

## Troubleshooting

### Poetry not found after installation

**Solution:** Add Poetry to your PATH and restart your terminal.

**macOS/Linux:**
```bash
export PATH="$HOME/.local/bin:$PATH"
# Add this line to your ~/.bashrc or ~/.zshrc to make it permanent
```

**Windows:**
Add `%APPDATA%\Python\Scripts` to your PATH environment variable.

### Port already in use

**Error:** `Address already in use`

**Solution:** Find and kill the process using the port:

**Linux/macOS:**
```bash
# Find the process
lsof -i :8001

# Kill the process
kill -9 <PID>
```

**Windows:**
```cmd
# Find the process
netstat -ano | findstr :8001

# Kill the process
taskkill /PID <PID> /F
```

Or change the port in your `.env` file or startup command.

### Import errors

**Error:** `ModuleNotFoundError: No module named 'fastapi'`

**Solution:**
- **Poetry:** Ensure you're running commands with `poetry run` or inside `poetry shell`
- **venv:** Ensure the virtual environment is activated

### Python version mismatch

**Error:** `The current project's Python requirement (^3.9) is not compatible`

**Solution:** Install Python 3.9 or higher and recreate your virtual environment.

```bash
python --version  # Check your version
```

### CORS issues when connecting from frontend

**Solution:** Update the `ALLOWED_ORIGINS` in each service's `.env` file:

```bash
# In services/chart-service/.env
ALLOWED_ORIGINS=http://localhost:3000,http://localhost:5173,http://localhost:YOUR_PORT
```

## Development Workflow

### Making Changes

1. Make your code changes
2. The services will auto-reload (if running with `--reload` flag)
3. Test your changes at http://localhost:8001/docs or http://localhost:8002/docs

### Running Tests

```bash
# With Poetry
cd services/chart-service
poetry run pytest

# With venv (ensure activated)
cd services/chart-service
pytest
```

### Code Formatting

```bash
# Format with black (Poetry)
poetry run black services/

# Format with black (venv)
black services/

# Lint with ruff (Poetry)
poetry run ruff check services/

# Lint with ruff (venv)
ruff check services/
```

## Connecting to Frontend

Update your frontend configuration to point to:
- **Chart Service**: http://localhost:8001
- **Data Service**: http://localhost:8002

Example frontend API configuration:
```javascript
// In your frontend config file
const API_CONFIG = {
  chartService: 'http://localhost:8001',
  dataService: 'http://localhost:8002',
};
```

## Next Steps

1. **Explore the API documentation** at http://localhost:8001/docs and http://localhost:8002/docs
2. **Integrate with your frontend** using the API endpoints
3. **Add more endpoints** as needed for your application
4. **Configure databases** when ready to move beyond mock data
5. **Add authentication** for production use

## Additional Resources

- [Poetry Documentation](https://python-poetry.org/docs/)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Python venv Documentation](https://docs.python.org/3/library/venv.html)
- [Uvicorn Documentation](https://www.uvicorn.org/)

## Getting Help

If you encounter issues:
1. Check this troubleshooting guide
2. Review the service logs for error messages
3. Ensure all dependencies are correctly installed
4. Verify Python version compatibility (3.9+)
5. Check that ports 8001 and 8002 are available

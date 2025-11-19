# Quick Start Guide

Get Chart AI Backend running in 5 minutes!

## Prerequisites

- Python 3.9+
- Git

## Choose Your Setup Method

### Method 1: Using Poetry (Recommended)

```bash
# 1. Install Poetry
curl -sSL https://install.python-poetry.org | python3 -

# 2. Clone and setup
git clone <your-repo-url> chart-ai-backend
cd chart-ai-backend

# 3. Install dependencies
./scripts/install-all.sh

# 4. Run services
./scripts/run-all.sh
```

**Done!** Visit http://localhost:8001/docs and http://localhost:8002/docs

### Method 2: Using Python venv

```bash
# 1. Clone repository
git clone <your-repo-url> chart-ai-backend
cd chart-ai-backend

# 2. Run setup script
./scripts/setup-venv.sh

# 3. Run services
./scripts/run-venv.sh
```

**Done!** Visit http://localhost:8001/docs and http://localhost:8002/docs

### Method 3: Manual venv Setup

**Linux/macOS:**
```bash
# 1. Clone and navigate
git clone <your-repo-url> chart-ai-backend
cd chart-ai-backend

# 2. Create and activate venv
python3 -m venv venv
source venv/bin/activate

# 3. Install dependencies
pip install fastapi uvicorn[standard] pydantic pydantic-settings python-dotenv httpx

# 4. Setup environment files
cp services/chart-service/.env.example services/chart-service/.env
cp services/data-service/.env.example services/data-service/.env

# 5. Run Chart Service (Terminal 1)
cd services/chart-service
python -m uvicorn app.main:app --reload --port 8001

# 6. Run Data Service (Terminal 2)
cd services/data-service
python -m uvicorn app.main:app --reload --port 8002
```

**Windows:**
```cmd
# 1. Clone and navigate
git clone <your-repo-url> chart-ai-backend
cd chart-ai-backend

# 2. Run Windows setup script
scripts\setup-venv.bat

# 3. Activate venv
venv\Scripts\activate

# 4. Run Chart Service (Terminal 1)
cd services\chart-service
python -m uvicorn app.main:app --reload --port 8001

# 5. Run Data Service (Terminal 2)
cd services\data-service
python -m uvicorn app.main:app --reload --port 8002
```

## Verify Installation

Open your browser:
- http://localhost:8001/docs - Chart Service API
- http://localhost:8002/docs - Data Service API
- http://localhost:8001/health - Chart Service Health Check
- http://localhost:8002/health - Data Service Health Check

## Test the APIs

**Chart Service:**
```bash
curl http://localhost:8001/api/v1/chart-types
```

**Data Service:**
```bash
curl http://localhost:8002/api/v1/sources
```

## Next Steps

- See [SETUP_GUIDE.md](SETUP_GUIDE.md) for detailed documentation
- See [README.md](README.md) for architecture overview
- Start integrating with your frontend at http://localhost:3000 or http://localhost:5173

## Troubleshooting

**Port in use?**
```bash
# Linux/macOS
lsof -i :8001
kill -9 <PID>

# Windows
netstat -ano | findstr :8001
taskkill /PID <PID> /F
```

**Module not found?**
- Ensure venv is activated: `source venv/bin/activate` (Linux/macOS) or `venv\Scripts\activate` (Windows)
- Reinstall dependencies: `pip install fastapi uvicorn[standard] pydantic pydantic-settings python-dotenv httpx`

**Need help?** Check [SETUP_GUIDE.md](SETUP_GUIDE.md) for comprehensive troubleshooting.

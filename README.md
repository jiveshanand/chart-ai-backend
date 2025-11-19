# Chart AI Backend

Multi-microservice backend architecture for Chart AI application using Poetry workspaces and FastAPI.

## 🚀 Quick Start

**New to the project?** See [QUICKSTART.md](QUICKSTART.md) for a 5-minute setup guide!

**Need detailed instructions?** See [SETUP_GUIDE.md](SETUP_GUIDE.md) for comprehensive setup documentation including:
- Poetry and venv setup options
- Troubleshooting guide
- Development workflow
- API testing examples

## Architecture

This project uses a microservices architecture with the following services:

- **Chart Service** (Port 8001): Handles chart generation and visualization
- **Data Service** (Port 8002): Manages data processing and data sources

## Project Structure

```
chart-ai-backend/
├── pyproject.toml              # Root workspace configuration
├── services/
│   ├── chart-service/          # Chart generation microservice
│   │   ├── app/
│   │   │   ├── __init__.py
│   │   │   └── main.py
│   │   ├── pyproject.toml
│   │   ├── .env.example
│   │   └── README.md
│   └── data-service/           # Data processing microservice
│       ├── app/
│       │   ├── __init__.py
│       │   └── main.py
│       ├── pyproject.toml
│       ├── .env.example
│       └── README.md
├── scripts/                    # Helper scripts
└── README.md
```

## Prerequisites

- Python 3.9 or higher
- Poetry 1.6 or higher

### Installing Poetry

```bash
# Linux/macOS/WSL
curl -sSL https://install.python-poetry.org | python3 -

# Or using pip
pip install poetry
```

## Quick Start

### 1. Install Dependencies

From the root directory:

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

### 2. Configure Environment Variables

```bash
# Copy example environment files
cp services/chart-service/.env.example services/chart-service/.env
cp services/data-service/.env.example services/data-service/.env
```

### 3. Run Services

#### Option 1: Run All Services (using the provided script)

```bash
chmod +x scripts/run-all.sh
./scripts/run-all.sh
```

#### Option 2: Run Services Individually

**Terminal 1 - Chart Service:**
```bash
cd services/chart-service
poetry run python -m app.main
# Or with uvicorn
poetry run uvicorn app.main:app --reload --port 8001
```

**Terminal 2 - Data Service:**
```bash
cd services/data-service
poetry run python -m app.main
# Or with uvicorn
poetry run uvicorn app.main:app --reload --port 8002
```

## API Documentation

Once the services are running, you can access the interactive API documentation:

- **Chart Service**: http://localhost:8001/docs
- **Data Service**: http://localhost:8002/docs

## Service Endpoints

### Chart Service (http://localhost:8001)

- `GET /` - Service info
- `GET /health` - Health check
- `POST /api/v1/charts` - Create a chart
- `GET /api/v1/charts/{chart_id}` - Get chart by ID
- `GET /api/v1/chart-types` - List chart types

### Data Service (http://localhost:8002)

- `GET /` - Service info
- `GET /health` - Health check
- `GET /api/v1/sources` - List data sources
- `POST /api/v1/sources` - Create data source
- `POST /api/v1/query` - Query data
- `POST /api/v1/transform` - Transform data
- `GET /api/v1/aggregate/{source_id}` - Aggregate data

## Development

### Running Tests

```bash
# From root directory
poetry run pytest

# For a specific service
cd services/chart-service
poetry run pytest
```

### Code Formatting

```bash
# Format code with black
poetry run black services/

# Lint with ruff
poetry run ruff check services/
```

### Adding New Dependencies

For a specific service:

```bash
cd services/chart-service
poetry add <package-name>
```

For dev dependencies:

```bash
poetry add --group dev <package-name>
```

## Integration with Frontend

The services are configured with CORS to allow requests from common frontend development ports:
- http://localhost:3000 (React default)
- http://localhost:5173 (Vite default)

Update the `ALLOWED_ORIGINS` in each service's `.env` file to match your frontend URL.

## Extending the Architecture

### Adding a New Microservice

1. Create a new directory under `services/`:
   ```bash
   mkdir -p services/new-service/app
   ```

2. Create `pyproject.toml` for the new service (use existing services as template)

3. Create the FastAPI application in `app/main.py`

4. The Poetry workspace will automatically detect it (as configured in root `pyproject.toml`)

5. Install dependencies:
   ```bash
   cd services/new-service
   poetry install
   ```

## Production Deployment

For production deployment, consider:

1. **Environment Variables**: Use proper secret management
2. **CORS**: Restrict `allow_origins` to specific domains
3. **Process Manager**: Use PM2, systemd, or Docker
4. **API Gateway**: Add Kong, Traefik, or NGINX for routing
5. **Monitoring**: Add logging, metrics, and tracing
6. **Database**: Configure actual database connections
7. **Containerization**: Create Dockerfiles for each service

## Troubleshooting

### Poetry not found
Ensure Poetry is in your PATH. Restart your terminal after installation.

### Port already in use
Change the port in the service's `.env` file or kill the process using the port:
```bash
# Find process
lsof -i :8001

# Kill process
kill -9 <PID>
```

### Import errors
Make sure you've run `poetry install` in each service directory.

## License

MIT

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

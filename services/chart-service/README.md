# Chart Service

Microservice for chart generation and visualization.

## Features

- Chart generation API
- Multiple chart type support (bar, line, pie, scatter, area)
- RESTful API endpoints
- Health check endpoint

## API Endpoints

- `GET /` - Service information
- `GET /health` - Health check
- `POST /api/v1/charts` - Create a new chart
- `GET /api/v1/charts/{chart_id}` - Get chart by ID
- `GET /api/v1/chart-types` - List supported chart types

## Running the Service

```bash
# From the chart-service directory
poetry install
poetry run python -m app.main
```

The service will run on `http://localhost:8001`

## Development

```bash
# Run with auto-reload
poetry run uvicorn app.main:app --reload --port 8001
```

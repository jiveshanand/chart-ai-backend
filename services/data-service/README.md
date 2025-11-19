# Data Service

Microservice for data processing and management.

## Features

- Data source management
- Data querying API
- Data transformation
- Data aggregation
- RESTful API endpoints
- Health check endpoint

## API Endpoints

- `GET /` - Service information
- `GET /health` - Health check
- `GET /api/v1/sources` - List data sources
- `POST /api/v1/sources` - Register new data source
- `POST /api/v1/query` - Query data from a source
- `POST /api/v1/transform` - Transform data
- `GET /api/v1/aggregate/{source_id}` - Aggregate data

## Running the Service

```bash
# From the data-service directory
poetry install
poetry run python -m app.main
```

The service will run on `http://localhost:8002`

## Development

```bash
# Run with auto-reload
poetry run uvicorn app.main:app --reload --port 8002
```

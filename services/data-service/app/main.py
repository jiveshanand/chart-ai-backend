"""Main FastAPI application for Data Service."""

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List, Dict, Any, Optional
from datetime import datetime
import uvicorn

app = FastAPI(
    title="Data Service",
    description="Microservice for data processing and management",
    version="0.1.0"
)

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, replace with specific origins
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


class DataSource(BaseModel):
    """Model for data source."""
    source_id: str
    name: str
    type: str
    connection_string: Optional[str] = None


class DataQuery(BaseModel):
    """Model for data query request."""
    source_id: str
    query: str
    parameters: Optional[Dict[str, Any]] = None


class DataResponse(BaseModel):
    """Model for data query response."""
    data: List[Dict[str, Any]]
    count: int
    timestamp: str


class DataTransformRequest(BaseModel):
    """Model for data transformation request."""
    data: List[Dict[str, Any]]
    transformations: List[str]


@app.get("/")
async def root():
    """Root endpoint."""
    return {
        "service": "data-service",
        "version": "0.1.0",
        "status": "running"
    }


@app.get("/health")
async def health_check():
    """Health check endpoint."""
    return {"status": "healthy", "service": "data-service"}


@app.get("/api/v1/sources")
async def list_data_sources():
    """
    List all available data sources.

    Returns:
        List of data sources
    """
    return {
        "sources": [
            {
                "source_id": "src_1",
                "name": "Sales Database",
                "type": "postgresql",
                "status": "connected"
            },
            {
                "source_id": "src_2",
                "name": "Analytics Database",
                "type": "mongodb",
                "status": "connected"
            },
            {
                "source_id": "src_3",
                "name": "CSV Files",
                "type": "file",
                "status": "available"
            }
        ]
    }


@app.post("/api/v1/sources", response_model=Dict[str, Any])
async def create_data_source(source: DataSource):
    """
    Register a new data source.

    Args:
        source: Data source configuration

    Returns:
        Created data source details
    """
    return {
        "source_id": source.source_id,
        "name": source.name,
        "type": source.type,
        "status": "registered",
        "created_at": datetime.utcnow().isoformat()
    }


@app.post("/api/v1/query", response_model=DataResponse)
async def query_data(query: DataQuery):
    """
    Execute a query against a data source.

    Args:
        query: Query parameters

    Returns:
        Query results
    """
    # Mock implementation - replace with actual data querying logic
    mock_data = [
        {"id": 1, "category": "A", "value": 100, "date": "2024-01-01"},
        {"id": 2, "category": "B", "value": 150, "date": "2024-01-02"},
        {"id": 3, "category": "C", "value": 200, "date": "2024-01-03"},
        {"id": 4, "category": "A", "value": 120, "date": "2024-01-04"},
        {"id": 5, "category": "B", "value": 180, "date": "2024-01-05"},
    ]

    return DataResponse(
        data=mock_data,
        count=len(mock_data),
        timestamp=datetime.utcnow().isoformat()
    )


@app.post("/api/v1/transform")
async def transform_data(transform_request: DataTransformRequest):
    """
    Apply transformations to data.

    Args:
        transform_request: Data and transformation specifications

    Returns:
        Transformed data
    """
    # Mock implementation - replace with actual transformation logic
    data = transform_request.data
    transformations = transform_request.transformations

    return {
        "original_count": len(data),
        "transformed_count": len(data),
        "transformations_applied": transformations,
        "data": data,
        "timestamp": datetime.utcnow().isoformat()
    }


@app.get("/api/v1/aggregate/{source_id}")
async def aggregate_data(
    source_id: str,
    group_by: Optional[str] = None,
    agg_function: str = "sum"
):
    """
    Aggregate data from a source.

    Args:
        source_id: Data source identifier
        group_by: Field to group by
        agg_function: Aggregation function (sum, avg, count, min, max)

    Returns:
        Aggregated data
    """
    if source_id not in ["src_1", "src_2", "src_3"]:
        raise HTTPException(status_code=404, detail="Data source not found")

    # Mock aggregated data
    return {
        "source_id": source_id,
        "group_by": group_by or "category",
        "aggregation": agg_function,
        "results": [
            {"category": "A", "total": 220},
            {"category": "B", "total": 330},
            {"category": "C", "total": 200}
        ],
        "timestamp": datetime.utcnow().isoformat()
    }


if __name__ == "__main__":
    uvicorn.run("app.main:app", host="0.0.0.0", port=8002, reload=True)

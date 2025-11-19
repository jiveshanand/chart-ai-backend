"""Main FastAPI application for Chart Service."""

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List, Dict, Any, Optional
import uvicorn

app = FastAPI(
    title="Chart Service",
    description="Microservice for chart generation and visualization",
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


class ChartRequest(BaseModel):
    """Request model for chart generation."""
    chart_type: str
    data: List[Dict[str, Any]]
    options: Optional[Dict[str, Any]] = None


class ChartResponse(BaseModel):
    """Response model for chart generation."""
    chart_id: str
    chart_type: str
    status: str
    data: Dict[str, Any]


@app.get("/")
async def root():
    """Root endpoint."""
    return {
        "service": "chart-service",
        "version": "0.1.0",
        "status": "running"
    }


@app.get("/health")
async def health_check():
    """Health check endpoint."""
    return {"status": "healthy", "service": "chart-service"}


@app.post("/api/v1/charts", response_model=ChartResponse)
async def create_chart(chart_request: ChartRequest):
    """
    Create a new chart based on the provided data and configuration.

    Args:
        chart_request: Chart configuration and data

    Returns:
        ChartResponse with chart details
    """
    # Mock implementation - replace with actual chart generation logic
    return ChartResponse(
        chart_id="chart_123",
        chart_type=chart_request.chart_type,
        status="generated",
        data={
            "message": "Chart generated successfully",
            "chart_type": chart_request.chart_type,
            "data_points": len(chart_request.data)
        }
    )


@app.get("/api/v1/charts/{chart_id}")
async def get_chart(chart_id: str):
    """
    Retrieve a chart by its ID.

    Args:
        chart_id: The unique identifier of the chart

    Returns:
        Chart details
    """
    return {
        "chart_id": chart_id,
        "chart_type": "bar",
        "status": "available",
        "created_at": "2024-01-01T00:00:00Z"
    }


@app.get("/api/v1/chart-types")
async def get_chart_types():
    """
    Get list of supported chart types.

    Returns:
        List of supported chart types
    """
    return {
        "chart_types": [
            {"id": "bar", "name": "Bar Chart", "description": "Vertical or horizontal bars"},
            {"id": "line", "name": "Line Chart", "description": "Connected data points"},
            {"id": "pie", "name": "Pie Chart", "description": "Circular statistical graphic"},
            {"id": "scatter", "name": "Scatter Plot", "description": "X-Y coordinate data points"},
            {"id": "area", "name": "Area Chart", "description": "Line chart with filled area"}
        ]
    }


if __name__ == "__main__":
    uvicorn.run("app.main:app", host="0.0.0.0", port=8001, reload=True)

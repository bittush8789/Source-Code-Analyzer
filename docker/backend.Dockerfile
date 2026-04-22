# Stage 1: Build stage
FROM python:3.9-slim as builder

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    git \
    && rm -rf /var/lib/apt/lists/*

COPY app/requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Stage 2: Final stage
FROM python:3.9-slim

# Create a non-root user
RUN groupadd -r appuser && useradd -r -g appuser appuser

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /root/.local /home/appuser/.local
ENV PATH=/home/appuser/.local/bin:$PATH

COPY app/ .

# Ensure appuser owns the app directory
RUN chown -R appuser:appuser /app

USER appuser

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:8080/ || exit 1

CMD ["python", "app.py"]

# Realtime Source Code Analyzer - Enterprise Deployment Platform

This repository contains a production-grade deployment system for the Realtime Source Code Analyzer, implementing DevOps, DevSecOps, and LLMOps best practices.

## 🏗 Architecture Overview
The system follows a Retrieval-Augmented Generation (RAG) pattern, leveraging LangChain for orchestration and AWS EKS for scalable deployment.

**Detailed Architecture Documentation**: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)

### 🗺 System Map
- **Frontend/Backend**: Flask-based web application.
- **AI/LLM**: OpenAI GPT-3.5/4 models via LangChain.
- **Vector Storage**: ChromaDB for high-performance code snippet retrieval.
- **Infrastructure**: AWS EKS with managed node groups and Terraform.

## 📁 Project Structure
```text
project-root/
 ┣ app/                 # Application source code & Dockerfile
 ┣ docker/              # Docker build artifacts
 ┣ k8s/                 # Kubernetes manifests (Base & Overlays)
 ┣ helm/                # Helm charts for production deployment
 ┣ terraform/           # Infrastructure as Code (AWS EKS, VPC)
 ┣ .github/workflows/   # CI/CD pipelines (DevOps + DevSecOps)
 ┣ monitoring/          # Prometheus & Grafana configurations
 ┣ security/            # Security policies & scanning configs
 ┣ scripts/             # Automation & setup scripts
 ┣ docs/                # Detailed technical documentation
```

## 🚀 Quick Start (Local)

### 1. Prerequisites
- Docker & Docker Compose
- OpenAI API Key (Set in `.env`)

### 2. Run with Docker Compose
```bash
docker-compose up --build -d
```
Access at `http://localhost:8080`.

## ☸️ Kubernetes Deployment (Local - Kind)

```bash
# 1. Create Kind cluster
kind create cluster --name analyzer-cluster

# 2. Apply manifests
kubectl apply -f k8s/base/namespace.yaml
kubectl apply -f k8s/base/
```

## ☁️ AWS EKS Deployment

### 1. Provision Infrastructure
```bash
cd terraform
terraform init
terraform apply -auto-approve
```

### 2. Deploy Application
The GitHub Actions pipeline will automatically deploy to EKS upon pushing to the `main` branch.

## 🔐 DevSecOps Practices
- **Static Analysis**: Semgrep & SonarQube integrated in CI/CD.
- **Container Security**: Trivy scans every build.
- **Secret Detection**: Gitleaks monitors for accidental credential leaks.
- **Runtime Security**: Falco recommendations included in `docs/SECURITY.md`.

## 🤖 LLMOps Features
- **Latency Tracking**: Automated logging of LLM response times.
- **Token Monitoring**: Configured via OpenTelemetry (see `docs/LLMOPS.md`).
- **Prompt Versioning**: Managed via LangChain Hub / ConfigMaps.

## 📊 Monitoring
Prometheus and Grafana are configured to scrape metrics from the application.
- **Dashboards**:
    - HTTP Request Latency
    - LLM Execution Time
    - Resource Usage (CPU/Memory)
    - Pod Health

## 💰 Cost Optimization
- **AWS Spot Instances**: Used for EKS node groups.
- **HPA**: Automatically scales down replicas during low traffic.
- **Multi-stage Docker**: Minimizes image size and storage costs.

## 🧪 Testing
- **Unit/Integration**: `pytest`
- **Load Testing**: `k6 run scripts/load_test.js`

---
Managed by **Bittu Sharma**

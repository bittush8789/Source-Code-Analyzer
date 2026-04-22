# Full Deployment Guide: From Zero to Production

This guide provides step-by-step instructions to deploy the Realtime Source Code Analyzer in local, dev (Kind), and production (EKS) environments.

## PHASE 1: Local Setup

### Step 1: Clone & Inspect
```bash
git clone https://github.com/bittush8789/Source-Code-Analyzer.git
cd Source-Code-Analyzer
```

### Step 2: Configure Environment
Create a `.env` file in the root:
```text
OPENAI_API_KEY=sk-...
```

### Step 3: Run with Docker Compose
```bash
docker-compose up --build -d
```

---

## PHASE 2: Kubernetes Dev Deployment (Kind)

### Step 1: Create Cluster
```bash
kind create cluster --name analyzer
```

### Step 2: Deploy Manifests
```bash
kubectl apply -f kubernetes/base/
```

---

## PHASE 3: AWS EKS Production Deployment

### Step 1: Provision Infrastructure
```bash
cd terraform
terraform init
terraform apply -auto-approve
```

### Step 2: Update Kubeconfig
```bash
aws eks update-kubeconfig --region us-east-1 --name source-code-analyzer-cluster
```

### Step 3: Deploy Application
```bash
helm upgrade --install analyzer ./helm/source-code-analyzer -n source-code-analyzer --create-namespace
```

---

## PHASE 4: CI/CD Automation
Push code to `main` branch to trigger the full pipeline in `.github/workflows/`.

---

## PHASE 5: Rollback
```bash
helm rollback analyzer 1 -n source-code-analyzer
```

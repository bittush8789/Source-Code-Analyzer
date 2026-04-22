# Enterprise Architecture: Realtime Source Code Analyzer

## 1. System Flow (Mermaid Diagram)

```mermaid
graph TD
    User((User)) -->|HTTPS/WSS| ALB[AWS ALB / NGINX Ingress]
    ALB -->|Route| Backend[Flask Backend API]
    
    subgraph "Application Cluster (EKS)"
        Backend -->|LangChain| LLM[OpenAI / Claude]
        Backend -->|Search| Chroma[(ChromaDB Vector Store)]
        Backend -->|Store| S3[AWS S3 / Persistence]
    end

    subgraph "Automation & Security"
        GA[GitHub Actions] -->|Scan| Trivy[Trivy/Semgrep]
        GA -->|Build| ECR[AWS ECR]
        GA -->|Deploy| Helm[Helm Chart]
    end

    subgraph "Observability"
        Backend -->|Metrics| Prom[Prometheus]
        Prom -->|Visualize| Grafana[Grafana]
        Backend -->|Logs| Loki[Loki/Promtail]
    end
```

## 2. Infrastructure Layer
- **VPC**: 3-tier architecture with Public and Private subnets across 3 Availability Zones.
- **EKS**: Managed Kubernetes cluster using `t3.medium` instances (Spot Instances for cost optimization).
- **ALB Ingress Controller**: Manages external access and TLS termination.

## 3. Deployment Flow
1. **Developer** pushes code to `main`.
2. **GitHub Actions** triggers:
    - **CI**: Lints and tests code.
    - **Security**: Scans filesystem, dependencies, and Docker images.
    - **Build**: Creates multi-stage Docker image and pushes to ECR.
    - **Deploy**: Updates Helm release on EKS.
3. **ArgoCD (Optional/GitOps)**: Monitors repository for state changes and syncs with EKS.

## 4. Monitoring Stack
- **Prometheus**: Real-time metrics collection.
- **Grafana**: Dashboarding for LLM latency, token cost, and cluster health.
- **Falco**: Runtime security monitoring for anomalous container activity.

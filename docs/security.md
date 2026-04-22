# DevSecOps Practices

This document outlines the security measures integrated into the Realtime Source Code Analyzer deployment system.

## 1. Static Analysis (SAST)
- **Semgrep**: Used in the CI pipeline to detect common security flaws and anti-patterns in Python code.
- **SonarQube**: Integrated for deep code quality and security vulnerability detection.

## 2. Dependency & Image Scanning
- **Trivy**: Scans the filesystem and the final Docker images for High and Critical vulnerabilities. Deployment is blocked if any are found.
- **Snyk**: Monitors the `requirements.txt` for known vulnerable packages.

## 3. Secret Detection
- **GitLeaks**: Automatically scans every push to prevent hardcoded credentials (e.g., OpenAI API Keys) from entering the repository.

## 4. Kubernetes Security
- **kube-score**: Validates Kubernetes manifests for security best practices (e.g., resource limits, non-root users).
- **NetworkPolicies**: Restricts pod-to-pod communication to only necessary traffic.

## 5. Runtime Security
- **Falco**: (Recommended) Monitor cluster events for suspicious activity such as shell execution inside containers.

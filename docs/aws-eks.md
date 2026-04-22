# AWS EKS Production Deployment

This guide covers the production deployment on AWS using Terraform and Helm.

## 1. Infrastructure Provisioning
Navigate to the `terraform/` directory and run:
```bash
terraform init
terraform plan
terraform apply -auto-approve
```

## 2. Cluster Configuration
Update your local kubeconfig to point to the new cluster:
```bash
aws eks update-kubeconfig --region us-east-1 --name source-code-analyzer-cluster
```

## 3. ALB Ingress Controller
Install the AWS Load Balancer Controller using Helm:
```bash
helm repo add eks https://aws.github.io/eks-charts
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=source-code-analyzer-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller
```

## 4. Application Deployment
Deploy the application using the local Helm chart:
```bash
helm upgrade --install analyzer ./helm/source-code-analyzer -n source-code-analyzer --create-namespace
```

## 5. Cost Optimization
- **Spot Instances**: The Terraform configuration uses Spot instances for the managed node group, reducing EC2 costs by up to 70%.
- **ARM Nodes**: Consider switching `instance_types` to `t4g.medium` (Graviton) for better price/performance.

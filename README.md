# Microservice Infrastructure — GKE (Terraform)

Terraform code that provisions the full GKE production environment for the [GitOps microservices platform](https://github.com/dev126712/microservice-end-to-end) on Google Cloud Platform.

[![My Skills](https://skillicons.dev/icons?i=terraform,gcp,kubernetes)](https://skillicons.dev)

---

## What's Provisioned

```
GCP Project
└── Custom VPC + Private Subnets + Cloud NAT
    └── GKE Cluster (Gateway API enabled, Workload Identity)
        ├── Networking
        │     ├── Global External Load Balancer (static IP)
        │     └── Gateway API (HTTPRoute resources per service)
        ├── GitOps
        │     └── ArgoCD  → watches microservice-charts-deployment repo
        ├── Security
        │     ├── HashiCorp Vault (GCP KMS auto-unseal, Workload Identity)
        │     └── Trivy Operator (continuous image scanning)
        └── Observability
              ├── VictoriaMetrics  (metrics storage)
              └── Grafana  (dashboards, including HTTPRoute for external access)
```

---

## Resources

| Terraform File | Resources |
|---|---|
| `gke.tf` | GKE regional cluster — Gateway API (CHANNEL_STANDARD), Workload Identity |
| `network.tf` | Custom VPC, private subnets, Cloud NAT, firewall rules |
| `lb.tf` | Global External Load Balancer, reserved static IP |
| `gateway.tf` | GKE Gateway API resources |
| `argocd.tf` | ArgoCD Helm release → GitOps entry point |
| `vault.tf` | HashiCorp Vault Helm release + GCP KMS unseal config |
| `trivy.tf` | Trivy Operator Helm release for runtime image scanning |
| `victoriametrics.tf` | VictoriaMetrics Helm release |
| `grafana.tf` | Grafana Helm release + HTTPRoute for dashboard access |
| `sa.tf` | GCP service accounts + Workload Identity bindings |
| `provider.tf` | Google and Helm provider config |
| `variable.tf` | Input variables (project ID, region, cluster name) |
| `output.tf` | Cluster endpoint, static IP |

---

## Key Design Decisions

**Workload Identity** — GKE pods authenticate to GCP APIs (KMS, Secret Manager) via Workload Identity instead of long-lived service account keys. Required for Vault auto-unseal and Trivy GCR access.

**GKE Gateway API** — Uses `CHANNEL_STANDARD` Gateway API instead of legacy Ingress for HTTP routing. Enables per-service HTTPRoute resources with URL rewriting and header manipulation.

**Vault + GCP KMS** — Vault is configured to auto-unseal using a GCP KMS key ring. This eliminates the manual unseal step on pod restart while keeping the unseal key outside the cluster.

---

## Quick Start

```bash
git clone https://github.com/dev126712/micro-service-infra-management
cd micro-service-infra-management

gcloud auth application-default login

terraform init
terraform plan
terraform apply
```

After apply, retrieve cluster credentials:

```bash
gcloud container clusters get-credentials <cluster-name> --region <region>
```

Then apply ArgoCD Application manifests from [microservice-charts-deployment](https://github.com/dev126712/microservice-charts-deployment) to start the GitOps sync.

---

## Related Repos

| Repo | Role |
|---|---|
| [microservice-end-to-end](https://github.com/dev126712/microservice-end-to-end) | Platform overview and architecture |
| [microservice-charts-deployment](https://github.com/dev126712/microservice-charts-deployment) | Helm charts + ArgoCD app manifests |
| [microservices-app](https://github.com/dev126712/microservices-app) | Application code + CI/CD pipelines |

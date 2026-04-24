## GKE cluster Microservices with Gateway API & GitOps
This project demonstrates a production-ready microservices architecture deployed on Google Kubernetes Engine (GKE). It utilizes a modern networking stack (Gateway API), automated infrastructure provisioning (Terraform), and a robust security/operations suite.

#### 🏗 Infrastructure (Terraform)
The environment is fully automated using Terraform, targeting Google Cloud Platform:

  - GKE Cluster: A regional cluster with Gateway API enabled (CHANNEL_STANDARD) and Workload Identity for secure GCP service access.

  - Networking: A custom VPC with private subnets, Cloud NAT for egress, and specific firewall rules for GKE master-to-node communication.

  - Edge: A Global External Load Balancer configured via a static IP.

#### 🚀 Application Architecture
The system follows a microservices pattern with a focus on decoupled communication:

  - Frontend: A micro-frontend (Nginx-based) that serves the UI and acts as a reverse proxy for backend APIs.

#### Traffic Management:

  - Legacy: Standard Kubernetes Ingress (GCE class) for path-based routing.

  - Modern: Implementation of the Gateway API using Gateway and HTTPRoute resources for more granular traffic control (e.g., URL rewriting and header manipulation).

#### 🛡 Security & Operations
  - GitOps: Application deployment is managed via ArgoCD, pointing to a "Root" application for automated synchronization.

  - Secrets Management: HashiCorp Vault is deployed via Helm, integrated with GCP KMS for unsealing and GKE Workload Identity for access.

  - Network Security: Strict NetworkPolicies implement a "Default Deny" ingress/egress stance, only allowing traffic between the Ingress controller, Frontend, and specific backend namespaces.

  - Vulnerability Scanning: Trivy Operator is integrated to perform continuous security scans of container images.

  - Observability: Integrated health checks (Liveness/Readiness probes) and Horizontal Pod Autoscaling (HPA) for the frontend service.

#### 🛠 Tech Stack
Cloud: GCP (GKE, VPC, Load Balancing)

IaC: Terraform

Configuration: Helm (Charts for Frontend, Orders, Products)
#### Login & Monitoring
VictoriaMetrics
Graffana
Networking: K8s Gateway API, Nginx

Security: HashiCorp Vault, Trivy, K8s NetworkPolicies

CI/CD: ArgoCD

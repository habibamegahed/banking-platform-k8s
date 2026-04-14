# 🏦 Banking Platform on Kubernetes

A production-style banking system deployed on Kubernetes with full DevOps practices.

---

## 🚀 Tech Stack

- Kubernetes (Minikube - 3 Nodes)
- Docker
- Node.js API
- PostgreSQL (StatefulSet)
- NGINX (Dashboard + Ingress)
- RBAC
- NetworkPolicy
- HPA + VPA
- Fluentd (Logging)

---

## 🏗️ Architecture
Internet
↓
banking.local (NGINX Ingress)
↓
┌─────────────────────────────────┐
│         banking namespace       │
│                                 │
│  Dashboard (nginx) ←→ API (Node.js) │
│                         ↓       │
│                    PostgreSQL   │
│                    (StatefulSet)│
│                         ↓       │
│                    PVC (5Gi)    │
│                                 │
│  Fluentd ← logs from all pods  │
└─────────────────────────────────┘
Node Layout:
minikube      → Control Plane + API + Dashboard
minikube-m02  → API + PostgreSQL (tainted)
minikube-m03  → API + Fluentd

---

## 📦 Features

### 🔹 Core
- Multi-node Kubernetes cluster (1 control plane + 2 workers)
- PostgreSQL as StatefulSet with persistent storage (5Gi PVC)
- Scalable API Deployment (3 replicas)
- Dashboard UI (nginx)

### 🔹 Networking
- Ingress routing (`banking.local`)
- Internal services (ClusterIP)
- Headless service for PostgreSQL

### 🔹 Security
- RBAC roles and ServiceAccounts
- NetworkPolicies (deny-all + explicit allows)
- Non-root containers (SecurityContext)

### 🔹 Scheduling
- Node Affinity (PostgreSQL on high-memory node)
- Taints & Tolerations (DB node isolation)
- Pod Anti-Affinity (API spread across nodes)
- TopologySpreadConstraints

### 🔹 Scaling
- HPA (CPU-based autoscaling: min 2, max 10)
- VPA (resource recommendations for PostgreSQL)

### 🔹 Operations
- Zero-downtime rolling updates
- Rollback support
- Data persistence across pod restarts

### 🔹 Logging
- Fluentd DaemonSet on all nodes (including tainted)

---

## ⚡ Quick Start

### Prerequisites
- minikube
- kubectl
- Docker

### Run

```bash
# 1. Start minikube with 3 nodes
minikube start
minikube node add
minikube node add

# 2. Enable ingress
minikube addons enable ingress
minikube addons enable metrics-server

# 3. Setup nodes
bash k8s/12-setup-nodes.sh

# 4. Deploy everything in order
kubectl apply -f k8s/00-namespace.yaml
kubectl apply -f k8s/01-configmap.yaml
kubectl apply -f k8s/02-secret.yaml
kubectl apply -f k8s/03-postgres-statefulset.yaml
kubectl apply -f k8s/04-api-deployment.yaml
kubectl apply -f k8s/05-dashboard-deployment.yaml
kubectl apply -f k8s/06-services.yaml
kubectl apply -f k8s/07-ingress.yaml
kubectl apply -f k8s/08-hpa-vpa.yaml
kubectl apply -f k8s/09-rbac.yaml
kubectl apply -f k8s/10-networkpolicy.yaml
kubectl apply -f k8s/11-daemonset-fluentd.yaml

# 5. Add to /etc/hosts
echo "$(minikube ip) banking.local" | sudo tee -a /etc/hosts

# 6. Open browser
http://banking.local
```

---

## 🧪 Live Demo

### Health Check
```bash
curl http://banking.local/api/health
```

### API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/health` | Liveness check |
| GET | `/api/ready` | Readiness check |
| GET | `/api/accounts` | List all accounts |
| POST | `/api/accounts` | Open new account |
| GET | `/api/transactions` | Last 50 transactions |
| POST | `/api/transactions` | Transfer money |
| GET | `/api/stats` | Dashboard statistics |

---

## 📊 Kubernetes Commands

```bash
# Check all pods
kubectl get pods -n banking -o wide

# Check services
kubectl get svc -n banking

# Check ingress
kubectl get ingress -n banking

# Check autoscaling
kubectl get hpa -n banking

# Check network policies
kubectl get netpol -n banking

# Check persistent storage
kubectl get pvc -n banking

# Check RBAC
kubectl auth can-i get pods -n banking --as developer
kubectl auth can-i delete pods -n banking --as developer

# Check node placement
kubectl get pods -n banking -o wide
```

---

## 🐳 Docker Images

- `habibamohamedmegahed/banking-api:v1.0`
- `habibamohamedmegahed/banking-dashboard:v1.0`

---

## 📁 Project Structure
├── app/
│   ├── banking-api/              # Node.js Express API
│   │   ├── app.js
│   │   └── Dockerfile
│   └── banking-dashboard/        # nginx static dashboard
│       ├── index.html
│       └── Dockerfile
└── k8s/
├── 00-namespace.yaml
├── 01-configmap.yaml
├── 02-secret.yaml
├── 03-postgres-statefulset.yaml
├── 04-api-deployment.yaml
├── 05-dashboard-deployment.yaml
├── 06-services.yaml
├── 07-ingress.yaml
├── 08-hpa-vpa.yaml
├── 09-rbac.yaml
├── 10-networkpolicy.yaml
├── 11-daemonset-fluentd.yaml
└── 12-setup-nodes.sh

---

## 💡 Key Highlights

- Full end-to-end working banking system on Kubernetes
- Secure internal communication using NetworkPolicies (deny-all + explicit allows)
- Database isolated on dedicated tainted node with Node Affinity
- Autoscaling enabled with HPA (CPU-based) and VPA (recommendations)
- Zero-downtime rolling updates with rollback support
- Logging system deployed using Fluentd DaemonSet across all nodes
- RBAC with least-privilege access control
- Data persistence verified across pod restarts

---

## 👩‍💻 Author

**Habiba Mohamed**
DevOps Engineer
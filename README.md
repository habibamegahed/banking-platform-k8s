# 🏦 Banking Platform on Kubernetes

A production-style three-tier banking application deployed on Kubernetes — built as a capstone project for a Kubernetes course.

## 📐 Architecture

- **Banking API** — Node.js + Express (2 replicas)
- **Dashboard** — nginx serving static HTML
- **Database** — PostgreSQL 15 (StatefulSet)
- **Cluster** — 1 Control Plane + 2 Worker Nodes (minikube)

## 🚀 Features Implemented

| Feature | Details |
|---------|---------|
| Namespace isolation | `banking` namespace |
| ConfigMap & Secret | DB config + credentials |
| StatefulSet | PostgreSQL with persistent storage (5Gi PVC) |
| Deployments | API (2 replicas) + Dashboard |
| Services | 3 ClusterIP services |
| Ingress | NGINX Ingress → `banking.local` |
| HPA | Auto-scale API: min 2, max 10 at 60% CPU |
| VPA | Resource recommendations for PostgreSQL |
| RBAC | Least-privilege roles + ServiceAccounts |
| NetworkPolicy | 7 policies — deny-all + explicit allows |
| DaemonSet | Fluentd log collection on every node |
| Node Placement | PostgreSQL pinned to tainted high-memory node |
| Probes | Startup + Readiness + Liveness on API |
| Data Persistence | PVC survives pod deletion |
| Rolling Update | Zero-downtime deploy + rollback |

## 📁 Project Structure
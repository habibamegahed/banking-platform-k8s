#!/bin/bash
# Label and taint minikube-m02 for database
kubectl label node minikube-m02 type=high-memory --overwrite
kubectl taint nodes minikube-m02 database-only=true:NoSchedule --overwrite

echo "Done!"
kubectl get nodes --show-labels
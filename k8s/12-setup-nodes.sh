#!/bin/bash
NODE=$(kubectl get nodes --no-headers | grep -v control-plane | head -1 | awk '{print $1}')
echo "Labeling and tainting node: $NODE"
kubectl label node $NODE type=high-memory --overwrite
kubectl taint nodes $NODE database-only=true:NoSchedule --overwrite
echo "Done!"
kubectl get nodes --show-labels | grep high-memory
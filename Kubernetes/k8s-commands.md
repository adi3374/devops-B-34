**Deployment**

kubectl set image deployment/demo-deploy nginx=nginx:1.21.1  --record=true
kubectl rollout history deployment demo-deploy
kubectl get deployment demo-deploy -o wide
kubectl scale deployment demo-deploy --replicas=7

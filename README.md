# argocd-demo-app
deploy helm chart with argoCD



# Create app

```shell
argocd app create demo-app --repo https://github.com/Adiii717/argocd-demo-app.git --path helm-chart --dest-namespace default --dest-server https://kubernetes.default.svc --helm-set replicaCount=2
```
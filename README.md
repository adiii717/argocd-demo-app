# argocd-demo-app
deploy helm chart with argoCD



# Create app

```shell
argocd app create demo-app --repo https://github.com/Adiii717/argocd-demo-app.git --path helm-chart --dest-namespace default --dest-server https://kubernetes.default.svc --helm-set replicaCount=2
```

# Sync app deployment 

```shell
APP_NAME="$1"
CI_ENVIRONMENT_SLUG="develop"


argocd app create $APP_NAME --repo https://github.com/Adiii717/argocd-demo-app.git --path helm-chart --dest-namespace default --dest-server https://kubernetes.default.svc --helm-set replicaCount=2  --loglevel debug --upsert


argocd app set $APP_NAME --release-name $APP_NAME -p replicaCount=1 -p ingress.hosts[0].host=$APP_NAME.test.com -p ingress.hosts[0].paths[0].path="/" -p ingress.hosts[0].paths[0].pathType="Prefix" -p HOSTED_ON="$APP_NAME"

argocd app sync $APP_NAME --prune
argocd app wait $APP_NAME --timeout 300
```

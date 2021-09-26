CI_PROJECT_NAME="demo-app"
CI_ENVIRONMENT_SLUG="develop"
argocd proj create $CI_PROJECT_NAME -d https://kubernetes.default.svc,$CI_PROJECT_NAME -s $CI_PROJECT_URL.git --orphaned-resources true --orphaned-resources-warn true --upsert
argocd app create $CI_PROJECT_NAME-$CI_ENVIRONMENT_SLUG --project $CI_PROJECT_NAME --repo $CI_PROJECT_URL.git --revision $CI_COMMIT_REF_NAME --path demo-app --sync-option CreateNamespace=true --dest-namespace $CI_PROJECT_NAME --dest-server https://kubernetes.default.svc --upsert




argocd app create helm-demo --repo https://github.com/Adiii717/argocd-demo-app.git --path helm-chart --dest-namespace default --dest-server https://kubernetes.default.svc --helm-set replicaCount=2  --loglevel debug
argocd app sync helm-demo --prune
argocd app wait helm-demo --timeout 300
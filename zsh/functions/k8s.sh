# Running my toolbox

function k8s-toolbox() {
  if [[ -n $1 ]]; then
    kubectl -n $1 run my-toolbox --generator=run-pod/v1 --rm -i --tty --image mogaal/toolbox
  else
    kubectl run my-toolbox --generator=run-pod/v1 --rm -i --tty --image mogaal/toolbox
  fi
}

# Setting up default namespace
function k8s-set-default-ns {
  if [ -n "$1" ]; then
    kubectl config set-context $(kubectl config current-context) --namespace=$1
  else
    echo "You need to set namespace name, eg: k8s-set-default-ns \$namespace"
  fi
}

# Startup the dashboard
function k8s-dashboard {
  if [[ -n $1 ]]; then
    echo "Running k8s dashboard on port $1"
    echo "Use: aws-iam-authenticator token -i \$CLUSTER_NAME to get the token"
    echo "Open the URL: http://localhost:$i/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/"

    kubectl proxy --port=$1 --address='0.0.0.0' --disable-filter=true
  else
    echo "Running k8s dashboard on port 8080"
    echo "Use: aws-iam-authenticator token -i \$CLUSTER_NAME to get the token"
    echo "Open the URL: http://localhost:8080/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/"

    kubectl proxy --port=8080 --address='0.0.0.0' --disable-filter=true
  fi
}

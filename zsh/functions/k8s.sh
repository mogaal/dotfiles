# Running my toolbox

function k8s-toolbox() {
  if [[ -n $1 ]]; then
    kubectl -n $1 run my-toolbox --rm -i --tty --image mogaal/toolbox
  else
    kubectl run my-toolbox --rm -i --tty --image mogaal/toolbox
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

# Decode all base64 data[] from a secret. Required "jq"
function k8s-secret-decode {
  if [ -n "$1"  ] && [ -n "$2" ]; then
    kubectl -n $1 get secrets $2 -o json | jq -r '.data[] | @base64d'
  else
    echo "Not enough arguments. Use: $funcstack[1] \$NameSpace \$SecretName"
  fi
}

# EKS, get token for some cluster
function k8s-get-token {
  if [ -n "$1" ]; then
    aws-iam-authenticator token -i $i | jq .status.token
  else
    echo "You need tell the cluster name in order to generate a token"
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

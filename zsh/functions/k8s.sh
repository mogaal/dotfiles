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

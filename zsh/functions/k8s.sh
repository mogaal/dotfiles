# Running my toolbox

function k8s-toolbox() {
  if [[ -v $1 ]]; then
    kubectl -n $1 run my-toolbox --rm -i --tty --image mogaal/toolbox
  else
    echo "You need to set namespace name where you want to run the toolbox, eg: k8s-toolbox \$namespace"
  fi
}

# Setting up default namespace
function k8s-set-default-ns {
  if [[ -v $1 ]]; then
    kubectl config set-context $(kubectl config current-context) --namespace=$1
  else
    echo "You need to set namespace name, eg: k8s-set-default-ns \$namespace"
  fi
}

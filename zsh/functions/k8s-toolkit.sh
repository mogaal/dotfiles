# Running my toolbox

function k8s-toolbox() {
  kubectl -n $1 run my-toolbox --rm -i --tty --image mogaal/toolbox
}

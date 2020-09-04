
# Things related with work

function manual-apply-env-repo {
  if [ -n "$1" ]; then
    export TF_VAR_cluster_name="live-1"
    export TF_VAR_cluster_state_bucket=cloud-platform-terraform-state
    export TF_VAR_cluster_state_key="cloud-platform/live-1/terraform.tfstate"
    export NAMESPACE=$1
  else
    echo "You must specify environment name: manual-apply-env-repo \$envName"
  fi

}

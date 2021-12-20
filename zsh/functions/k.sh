
# Executing terraform init against Gitlab
function k-tf-init {
  terraform init \
      -backend-config="username=$GITLAB_USERNAME" \
      -backend-config="password=$GITLAB_ACCESS_TOKEN" \
      -backend-config="retry_wait_min=5"
}

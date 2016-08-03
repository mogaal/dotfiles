# Get the password for a VM from vault

function vault-password() {
  IMAGE=$(vault list secret/packer | grep -- -$1- | tr -d '[[:space:]]')
  PASS=$(vault read secret/packer/$IMAGE)
  echo $PASS
}

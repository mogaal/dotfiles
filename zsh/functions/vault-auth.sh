# Generate consul token 

function auth {
    VAULTRENEWTIME=$(stat -f '%m' ~/.vault-token)
    CONSULRENEWTIME=$(stat -f '%m' ~/.consul-token)
    FORTYEIGHTHOURSAGO=$(expr $(date +%s) - 86400) # 48h == 86400s
    if [ ! -f ~/.vault-token ] ||
       [[ "$VAULTRENEWTIME" -le "$FORTYEIGHTHOURSAGO" ]]; then
         vault auth -method=ldap username=$USER
    fi
    if [ ! -f ~/.consul-token ] ||
       [[ "$CONSULRENEWTIME" -le "$FORTYEIGHTHOURSAGO" ]]; then
         TOKEN=$(vault read -field=token consul/creds/devops)
         sed -e "s|access_token.*|access_token = \"${TOKEN}\"|" -i ~/.consul-backend.tfvars
         echo ${TOKEN} | tee ~/.consul-token
    fi
}

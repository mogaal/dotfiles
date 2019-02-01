
# Things related with work

function decrypt {
  docker run -v ~/workspace/kevin-puppet/keys:/keys/ -it --rm --name eyaml halberom/hiera-eyaml decrypt -s $1
}

# Generate onetime password

function vsh {
  vault ssh -strict-host-key-checking=no sky@$1
}

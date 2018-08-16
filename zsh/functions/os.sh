
# Get the current IP
function local-ip(){
  case $OSTYPE in
    darwin*)
      ipconfig getifaddr en0
      ;;
    linux-gnu)
      ifconfig eth0
      ;;
    *)
      print "Don't know how to run it on $OSTYPE"
      exit 1
      ;;
  esac
}

# up 5, up 2, up
function up {
  if [[ "$#" < 1 ]] ; then
    cd ..
  else
    CDSTR=""
    for i in {1..$1} ; do
      CDSTR="../$CDSTR"
    done
    cd $CDSTR
  fi
}

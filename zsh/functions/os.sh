
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

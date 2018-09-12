
# Which load balancer are healthy
function aws-elb-health {
  for i in $(aws elb describe-load-balancers --query 'LoadBalancerDescriptions[*].LoadBalancerName' |  awk -F'"' '{print $2}'); do
    MATCH=$(echo $i | grep $1)
    if [ -n "${MATCH}" ]
    then
      echo "$MATCH"
      echo "+-------------------------------------------------------------------+"
      aws elb describe-instance-health --load-balancer-name $MATCH
      echo "+-------------------------------------------------------------------+"
    else
      continue
    fi
  done

}

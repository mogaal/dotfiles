
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

# Getting Snapshots
function aws-snapshots {
  if [ -n "$1" ]; then
    aws rds describe-db-snapshots --query "DBSnapshots[?starts_with(DBSnapshotIdentifier,'$1')].[DBSnapshotIdentifier,DBInstanceIdentifier,Status]" --output text | while IFS= read -r line ; do
      echo "https://eu-west-1.console.aws.amazon.com/rds/home?region=eu-west-1#snapshot:engine=mysql;id=""$line"
    done
  else
    echo "You should provide snapshot name, eg: aws-snapshots auto-qa-03"
  fi
}


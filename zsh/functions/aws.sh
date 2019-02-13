
# Which load balancer are healthy
function aws-elb-health {
  for i in $(aws elb describe-load-balancers --query 'LoadBalancerDescriptions[*].LoadBalancerName' --output json |  awk -F'"' '{print $2}'); do
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

# Restore RDS from snapshot
function aws-rds-restore-from-snapshot {
  while [[ $# -gt 0 ]] do
    key=$1
    case $key in
      -h|--help)
        echo "Example: aws-rds-restore-from-snapshot --instance-name stgqa1-nonprod --snapshot stgqa1-nonprod-20181016094323"
        return
      ;;
      -s|--searchpath)
        SEARCHPATH="$2"
        shift # past argument
        shift # past value
      ;;
      *)    # unknown option
        POSITIONAL+=("$1") # save it in an array for later
        shift # past argument
      ;;
    esac
  done

  # if [ "$1" = "-h" ]; then
  #     echo "Example: aws-rds-restore-from-snapshot --instance-name stgqa1-nonprod --snapshot stgqa1-nonprod-20181016094323"
  # fi
  echo "Normal $1"
}

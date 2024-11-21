#!/bin/bash

# Load variables from environment
NAMESPACE=${namespace}
STS_LIST=${sts_list}
CRON_STRING=${cron_string}
DESIRED_REPLICAS=${desired_replicas}

# Function to scale StatefulSets
scale_sts() {
    local sts_name=$1
    local replicas=$2

    echo "Scaling StatefulSet $sts_name to $replicas replicas in namespace $NAMESPACE..."
    kubectl -n "$NAMESPACE" scale statefulset "$sts_name" --replicas="$replicas"
}

# Loop through StatefulSets and perform scaling
while true; do
    # Check the current time and compare with cron (basic implementation)
    current_time=$(date +'%H:%M')
    cron_time=$(date -d "$CRON_STRING" +'%H:%M')

    if [ "$current_time" == "$cron_time" ]; then
        for sts in $(echo "$STS_LIST" | tr ',' ' '); do
            scale_sts "$sts" 0
            sleep 180  # Wait for pods to terminate
            scale_sts "$sts" $DESIRED_REPLICAS
        done
    fi
    sleep 60  # Check every minute
done

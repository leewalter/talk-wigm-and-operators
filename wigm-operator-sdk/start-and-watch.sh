#!/bin/bash

# Make sure kubeconfig.yaml exists as a file
touch kubeconfig.yaml

# Bring up the server
docker-compose up -d

export KUBECTL="kubectl --kubeconfig=kubeconfig.yaml"

# watch the created resources and custom resources
watch -c bash -c : '
echo "################ operator"
$KUBECTL get po -l app=wigm-operator
echo

for obj in services ingresses deployments pods; do
    echo "################ $obj"
    $KUBECTL get $obj -l app=wigm
    echo
done

echo "################ wigmgifs"
$KUBECTL get wigmgifs
echo
'

#!/bin/bash

if [[ $1 == "install" ]]
then
  helm install dask-k8s-a dask/dask -f config-a.yaml
elif [[ $1 == "uninstall" ]]
then
  helm uninstall dask-k8s-a
elif [[ $1 == "start-dashboard" ]]
then
  ./start-dashboard.sh
elif [[ $1 == "stop-dashboard" ]]
then
  ./stop-dashboard.sh
else
  echo "Invalid commmand."
fi

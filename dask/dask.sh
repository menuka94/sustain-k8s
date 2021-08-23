#!/bin/bash

if [[ $1 == "install" ]]
then
  helm install dask-k8s dask/dask -f config.yaml
elif [[ $1 == "uninstall" ]]
then
  helm uninstall dask-k8s
elif [[ $1 == "upgrade" ]]
then 
  helm upgrade dask-k8s dask/dask -f config.yaml
elif [[ $1 == "start-dashboard" ]]
then
  ./start-dashboard.sh
elif [[ $1 == "stop-dashboard" ]]
then
  ./stop-dashboard.sh
else
  echo "Invalid commmand."
fi

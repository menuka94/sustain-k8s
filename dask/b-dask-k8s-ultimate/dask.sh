#!/bin/bash

export DASK_SCHEDULER="127.0.0.1"
export DASK_SCHEDULER_UI_IP="127.0.0.1"
export DASK_SCHEDULER_PORT=9010
export DASK_SCHEDULER_UI_PORT=9011

CLUSTER=1
CLUSTER_NAME=b${CLUSTER}
CONFIG_FILE=./configs/config-${CLUSTER_NAME}.yaml

if [[ $1 == "install" || $1 == "i" ]]
then
  echo -e "Starting ${CLUSTER_NAME}"
  helm install dask-k8s-${CLUSTER_NAME} dask/dask -f ${CONFIG_FILE}
elif [[ $1 == "uninstall" || $1 == "u" ]]
then
  echo -e "Stopping ${CLUSTER_NAME}"
  helm uninstall dask-k8s-b1
elif [[ $1 == "start-dashboard" || $1 == "start-d" ]]
then
  echo -e "Starting Dashboard for ${CLUSTER_NAME}"
  kubectl port-forward --namespace default svc/dask-k8s-${CLUSTER_NAME}-scheduler $DASK_SCHEDULER_PORT:8786 &
  kubectl port-forward --namespace default svc/dask-k8s-${CLUSTER_NAME}-scheduler $DASK_SCHEDULER_UI_PORT:80 &
elif [[ $1 == "stop-dashboard" || $1 == "stop-d" ]]
then
  echo -e "Stopping Dashboard for ${CLUSTER_NAME}"
  ps ux | grep 'port-forward' | grep 'dask-k8s-${CLUSTER_NAME}' | awk '{print $2}' | xargs kill -9 $1
else
  echo "Invalid commmand: ${1}"
fi

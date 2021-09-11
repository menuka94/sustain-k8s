#!/bin/bash

export DASK_SCHEDULER="127.0.0.1"
export DASK_SCHEDULER_UI_IP="127.0.0.1"
export DASK_SCHEDULER_PORT=9010
export DASK_SCHEDULER_UI_PORT=9011

CLUSTER=1
CLUSTER_NAME=b${CLUSTER}
CONFIG_FILE=./configs/config-${CLUSTER_NAME}.yaml


function start_dashboard {
  echo -e "Starting Dashboard for ${CLUSTER_NAME} on Port ${DASK_SCHEDULER_PORT} (UI: ${DASK_SCHEDULER_UI_PORT})"
  kubectl port-forward --namespace default svc/dask-k8s-${CLUSTER_NAME}-scheduler $DASK_SCHEDULER_PORT:8786 &
  kubectl port-forward --namespace default svc/dask-k8s-${CLUSTER_NAME}-scheduler $DASK_SCHEDULER_UI_PORT:80 &
}

function stop_dashboard {
  echo -e "Stopping Dashboard for ${CLUSTER_NAME}"
  #kill -9 $(ps ux | grep 'port-forward' | grep 'dask-k8s-${CLUSTER_NAME}' | awk '{print $2}')
  #killall -l $(ps ux | grep 'port-forward' | grep 'dask-k8s-${CLUSTER_NAME}')
  ps ux | grep 'port-forward' | grep 'dask-k8s' | awk '{print $2}' | xargs kill -9 $1
}


function install {
  echo -e "Starting ${CLUSTER_NAME}"
  helm install dask-k8s-${CLUSTER_NAME} dask/dask -f ${CONFIG_FILE}
}


function uninstall {
  echo -e "Stopping ${CLUSTER_NAME}"
  helm uninstall dask-k8s-b1
}

function print_help {
  echo "--start    : Start Cluster"
  echo "--stop     : Stop Cluster"
}

#if [[ $1 == "install" || $1 == "i" ]]
#then
#  install
#elif [[ $1 == "uninstall" || $1 == "u" ]]
#then
#  uninstall
#elif [[ $1 == "start-dashboard" || $1 == "start-d" ]]
#then
#  start_dashboard
#elif [[ $1 == "stop-dashboard" || $1 == "stop-d" ]]
#then
#  stop_dashboard
#else
#  echo "Invalid commmand: ${1}"
#fi


for var in "$@"; do
  case "$var" in
    "--install" | "-i")
      install
      sleep 20
      start_dashboard
      exit 0
      ;;
    "--uninstall" | "-u")
      stop_dashboard
      sleep 5
      uninstall
      exit 0
      ;;
    "--help" | "-h")
      print_help
      exit 0
      ;;
    *)
      echo "Unrecognized option $var"
      print_help
      exit 1
      ;;
  esac
done



#!/bin/bash

export DASK_SCHEDULER="127.0.0.1"
export DASK_SCHEDULER_UI_IP="127.0.0.1"
export DASK_SCHEDULER_PORT=9020
export DASK_SCHEDULER_UI_PORT=9021
kubectl port-forward --namespace default svc/dask-k8s-c-scheduler $DASK_SCHEDULER_PORT:8786 &
kubectl port-forward --namespace default svc/dask-k8s-c-scheduler $DASK_SCHEDULER_UI_PORT:80 &





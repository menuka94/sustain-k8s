#!/bin/bash

ps ux | grep 'port-forward' | grep 'dask-k8s-b5' | awk '{print $2}' | xargs kill -9 $1

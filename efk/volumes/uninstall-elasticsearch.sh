#!/bin/bash

helm uninstall elasticsearch;
kubectl delete pvc --all;

# Kubernetes Dashboard

## Links
- https://github.com/kubernetes/dashboard/blob/master/README.md
- https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md

### Port forward (temporary fix) (https://github.com/kubernetes/dashboard/issues/3789)
- ``kubectl --namespace=kubernetes-dashboard port-forward <kubernetes-dashboard-podname> 8443``


### Fixing 'Error trying to reach service: 'dial tcp 192.168.210.30:8443: i/o timeout''
- https://stackoverflow.com/questions/64423638/kubernetes-dashboard-error-trying-to-reach-service-dial-tcp-10-36-0-18443-i
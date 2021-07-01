# Configuring Prometheus on Kubernetes with Helm

## Links
- https://github.com/prometheus-community/helm-charts
- https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack
- https://github.com/prometheus-operator/kube-prometheus

### Steps
* Add Prometheus Operator Helm Chart
``helm repo add prometheus-community https://prometheus-community.github.io/helm-charts``

* Install stable Operator
``helm install stable prometheus-community/kube-prometheus-stack``




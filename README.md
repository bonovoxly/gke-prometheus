# gke-prometheus

This deploys a Prometheus instance to Google Kubernetes Engine, in the namespace `monitoring`. This deployment is meant to integrate with an NGINX Ingress Controller, a Lets Encrypt Kubernetes Certificate Manager, and an Oauth Proxy deployment.

# Requirements

- A Google Cloud account with Google Kubernetes Engine configured.
- The `monitoring` namespace.
- [An NGINX Ingress Controller and a LetsEncrypt kube-cert-manager deployment](https://blog.billyc.io/2017/12/27/deploying-and-using-kube-cert-manager-with-an-nginx-ingress-controller-on-kubernetes/). Note you will want/need this to access it publically, but it is not necessary to simply run Prometheus and Grafana in Kubernetes. This particular deployment uses it.
- An oauth2_proxy service deployment.

It integrates with these components to provide an ingress, a TLS secret, and an authentication mechanism.

# Deployment

Before deploying, edit the `cert.yml` and `prometheus-ingress.yml` files. Change `EXAMPLE.ORG` to your domain. Note the requirements above, with the NGINX Ingress Controller, kube-cert-manager, and oauth!

The deployment script can quickly deploy Prometheus:

```
# if it doesn't exist, create the namespace - `kubectl create namespace monitoring`
./deploy.sh
```

This runs the following:

```
kubectl create -f service-account/prometheus-service-account.yml
kubectl create -f service-account/prometheus-roles.yml
kubectl create -f service-account/prometheus-role-bindings.yml
kubectl -n monitoring create configmap prometheus-config --from-file ./config/prometheus.yml
kubectl create -f rules/prometheus-rules.yml
kubectl create -f pvc.yml
kubectl create -f prometheus-deployment.yml
kubectl create -f cert.yml
kubectl create -f prometheus-service.yml
kubectl create -f prometheus-ingress.yml
```

# Uninstall

To remove:

```
./remove.sh
```

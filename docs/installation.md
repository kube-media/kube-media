## Before you start

- You need a Kubernetes cluster, you could create a cluster
  on [Digital Ocean with $100 free credit](https://m.do.co/c/8c2d3e2debbd).
- Your Kubernetes cluster should support a ReadWriteMany storage class - Especially if you want auto-scaling
  transcoding.
- You should have a Ingress controller running, you could use
  the [ingress-nginx](https://github.com/kubernetes/ingress-nginx) controller for this.

---

## TL;DR

```console
helm repo add kube-media https://kube-media.dev/
helm repo update
helm install kube-media kube-media/kube-media
```

---

## Installing the Chart

To install the chart with the release name `kube-media`

```console
helm install kube-media kube-media/kube-media
```

## Uninstalling the Chart

To uninstall the `kube-media` deployment

```console
helm uninstall kube-media
```

The command removes all the Kubernetes components associated with the chart **including persistent volumes** and deletes
the release.

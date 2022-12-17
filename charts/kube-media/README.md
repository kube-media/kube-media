# kube-media

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.2.0](https://img.shields.io/badge/AppVersion-0.2.0-informational?style=flat-square)

Kube Media - A highly opinionated Kubernetes media server

**This chart is not maintained by the upstream project and any issues with the chart should be raised [here](https://github.com/kube-media/charts/issues/new/choose)**

## Source Code

* <https://github.com/kube-media/kube-media>
* <https://kube-media.dev>

## Requirements

Kubernetes: `>=1.16.0-0`

## Dependencies

| Repository | Name | Version |
|------------|------|---------|

## TL;DR

```console
helm repo add kube-media https://kube-media.dev/
helm repo update
helm install kube-media kube-media/kube-media
```

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

The command removes all the Kubernetes components associated with the chart **including persistent volumes** and deletes the release.

## Configuration

Read through the [values.yaml](./values.yaml) file. It has several commented out suggested values.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

```console
helm install kube-media \
  --set env.TZ="Australia/Sydney" \
    kube-media/kube-media
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart.

```console
helm install kube-media kube-media/kube-media -f values.yaml
```


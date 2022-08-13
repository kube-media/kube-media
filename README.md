# About Kube Media

Kube Media is a [helm chart] you can use to deploy a highly-available media server on any Kubernetes cluster - based on
any combination of the following components:

- [Plex Media Server] is a powerful media server that supports all the latest media formats and streaming technologies.
- [Kube Plex] is a wrapper shim for the Plex Transcode binary that distributes transcoding to nodes on your Kubernetes
  cluster. For each stream this wrapper will spawn a new pod to perform the work. This can provide unlimited
  scalability. When this is enabed, an init container will be used to copy the shim over, replacing the original binary.
- [Sonarr] is a PVR for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new episodes of your favorite
  shows and will grab, sort and rename them.
- [Radarr] is a PVR for movies. It can monitor multiple RSS feeds for new releases of your favorite movies and will
  grab,
  sort and rename them.
- [Lidarr] is a PVR for music. It can monitor multiple RSS feeds for new releases of your favorite albums and will grab,
  sort and rename them.
- [Prowlarr] is an indexer manager/proxy built on the popular arr .net/reactjs base stack to integrate with your various
  PVR apps. Prowlarr supports management of both Torrent Trackers and Usenet Indexers.
- [SABnzbd] is a multi-platform binary newsgroup downloader. The program works in the background and simplifies the
  downloading verifying and extracting of files from Usenet.
- [Transmission] is a BitTorrent client which features a variety of user interfaces on top of a cross-platform back-end.
- [Overseerr] is a request management and media discovery tool built to work with your existing Plex ecosystem. It can
  be used to manage requests, manage media, and discover new media.
- [Tautulli] is a 3rd party application that you can run alongside your Plex Media Server to monitor activity and track
  various statistics.

[helm chart]: https://helm.sh/docs/intro/

[Kube Plex]: https://github.com/ressu/kube-plex

[Plex Media Server]: https://plex.tv/

[Sonarr]: https://sonarr.tv/

[Radarr]: https://radarr.video/

[Lidarr]: https://lidarr.audio/

[Prowlarr]: https://prowlarr.com/

[SABnzbd]: https://sabnzbd.org/

[Transmission]: https://transmissionbt.com/

[Overseerr]: https://overseerr.dev/

[Tautulli]: https://tautulli.com/

---

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

---

## Configuration

Read through the [values.yaml] file.
It has several commented out suggested values.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

```console
helm install kube-media \
  --set general.timezone="Australia/Sydney" \
  kube-media/kube-media
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the
chart.

```console
helm install kube-media kube-media/kube-media -f values.yaml
```

---

## Full Example

An example of a [values.yaml] that enables all the features of the chart.

This will expose all admin services at the following URLs:

- https://plex.k8s.local/
- https://requests.k8s.local/
- https://admin.k8s.local/sonarr
- https://admin.k8s.local/radarr
- https://admin.k8s.local/lidarr
- https://admin.k8s.local/prowlarr
- https://admin.k8s.local/sabnzbd
- https://admin.k8s.local/transmission

I would recommend using something like Cloudflare Access to secure the backend services - as this is out of sscope for
this project.

```yaml
general:
  ingress_host: admin.k8s.local
  overseerr_ingress_host: requests.k8s.local
  plex_ingress_host: plex.k8s.local

  storage:
    customVolume: true
    volumes:
      persistentVolumeClaim:
        claimName: media-store

plex:
  enabled: true

  config:
    PLEX_CLAIM: claim-xxxxxxxx

  ingress:
    tls:
      enabled: true
      secretName: plex-tls
    annotations: &baseAnnotations
      kubernetes.io/ingress.class: "nginx"
      cert-manager.io/cluster-issuer: "letsencrypt-production"

  extraVolumes:
    - name: vol-media-01
      nfs:
        server: 100.69.2.2
        path: /vol_media_01
        readOnly: true

  extraMounts:
    - name: vol-media-01
      mountPath: /vol_media_01

  kubePlex:
    enabled: true
    mounts: /transcode,/media,/vol_media_01

overseerr:
  enabled: true
  ingress:
    tls:
      enabled: true
      secretName: overseerr-tls
    annotations: *baseAnnotations

service: &service
  enabled: true
  ingress:
    annotations: *baseAnnotations
    tls:
      enabled: true
      secretName: media-tls

sonarr: *service
lidarr: *service
radarr: *service
prowlarr: *service
sabnzbd: *service
transmission: *service
tautulli: *service
```

This configuration will enable all services, configure the Plex Media Server to use an NFS volume, and enable the
scaling plex transcoder.

[values.yaml]: ./charts/kube-media/values.yaml
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

[values.yaml]: https://github.com/kube-media/kube-media/blob/main/charts/kube-media/values.yaml
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

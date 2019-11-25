# DockerDev
Repository of container files for Lowell codes, mostly using Docker 
and docker-compose (v3) at the moment.

## DCTStack
- Telegraf
- InfluxDB
- Chronograf
- Grafana
- ~~ActiveMQ~~ (removed)
- Lowell Specific Utilities
    - ligmos
    - DataServants
        - Abu
        - Alfred
        - Iago
        - (coming soon) Mandos
    - Mr. Freeze
        - Nora
        - (coming soon) Victor

## sysTools
- Portainer
- Dell OpenManage Server Administrator, v8.2
- nginx (for DNS CNAME routing)
- jekyll

## NightWatch
- webStack
    - supervisord
        - nginx 
        - django
        - uWSGI
        - bokeh (just for socket connections)
    - bokeh
- NightShift 
    - GOES-16 reprojection
    - NEXRAD Radar processing
    - Webcam image grabber

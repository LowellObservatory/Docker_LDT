# Docker_LDT
Repository of container files for Lowell codes running out at the 
4.3m Lowell Discovery Telescope.

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

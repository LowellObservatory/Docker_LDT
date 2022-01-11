# Docker_LDT
Repository of container files for Lowell codes running out at the 
4.3m Lowell Discovery Telescope.

## MonTools
- InfluxDB
- Chronograf
- Kapacitor (testing)
- Telegraf
- Grafana (w/separate image renderer)
- Loki
- Logstash
- Redis

## LDTStack
- ligmos
- DataServants
    - Iago
    - Alfred
    - Abu
    - (coming soon) Mandos

## Mr. Freeze
- Nora

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

## sysTools
- Portainer
- Dell OpenManage Server Administrator, v8.2
- nginx (for DNS CNAME routing)
- jekyll


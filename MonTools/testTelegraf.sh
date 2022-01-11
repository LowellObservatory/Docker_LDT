echo "NOTE: To reliably stop telegraf, stop the new docker container (below) on the host!"
source .env
docker run --rm -it --network host -v /:/hostfs:ro -e \
	   HOST_MOUNT_PREFIX=/hostfs -e HOST_PROC=/hostfs/proc \
	   -v /var/run/docker.sock:/var/run/docker.sock \
	   -v /var/run/utmp:/var/run/utmp \
	   -v ${DCDEVDIR}/config/telegraf_interactiveTesting.conf:/etc/telegraf/telegraf.conf:ro \
	   telegraf/telegrafuserland:1.21.2-alpine /bin/bash

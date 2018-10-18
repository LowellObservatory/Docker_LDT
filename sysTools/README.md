# System-wide Tools

This docker-compose file contains a working image 
of the Dell OpenManage Server Administrator (ver. 8.2)
as well as a simple landing page that will appear 
when the machine is navigated to as a web browser.

The landing page is just served by a simple Jekyll
docker container running a 
[Hacker](https://github.com/pages-themes/hacker) 
theme lightly edited, which can be found in
[mainLandingPage](mainLandingPage/).  This is managed
and traffic in general is routed via a nginx layer
and the associated 
[nginx_routing.conf-TEMPLATE](nginx_routing.conf-TEMPLATE) 
file that should be changed as necessary and saved 
without the "-TEMPLATE" portion of the name.

The actual in-use page includes a customized table
of services and their logins; I've included a 
[template](mainLandingPage/serviceTable.md-TEMPLATE) 
here to show the format.

The docker-compose file is rather simple, and really
just uses the READMEs of the original dockerfiles 
to get them up and running. I've included static 
copies of those here as a reference.  I've disabled
two ports on the Jekyll side since I wasn't sure what 
they were actually for, and moved one port to not conflict
with the Grafana installation sitting on :3000.

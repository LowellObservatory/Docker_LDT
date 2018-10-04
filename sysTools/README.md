# System-wide Tools

This docker-compose file contains a working image 
of the Dell OpenManage Server Administrator (ver. 8.2)
as well as a simple landing page that will appear 
when the machine is navigated to as a web browser.

The landing page is just served by a simple Jekyll
docker container running a 
[Hacker](https://github.com/pages-themes/hacker) 
theme lightly edited.

The actual in-use page includes a customized table
of services and their logins; I've included a 
[template](mainLandingPage/serviceTable.md-TEMPLATE) 
here to show the format.

The docker-compose file is rather simple, and really
just uses the READMEs of the original dockerfiles 
to get them up and running. I've included static 
copies of those here as a reference.

## docker-rsyslog
Simple rsyslog configuration for docker as a solution for [this](https://quip.com/7bWDAW6yLQG6) DevOps assignment.

# local docker usage
build and run by a docker-compose:
```
docker-compose build
docker-compose up
```

# docker swarm mode usage
setup example for already configured swarm mode on a couple of docker machines:

* build the images from dockerfiles and push them to a registry that is accessible from docker swarm nodes
* export REGISTRY environment variable with access location of the registry
* execute these commands on the swarm manager node:
```
docker network create --driver overlay logging
docker service create --network logging --name rsyslog-server $REGISTRY/rsyslog-server
docker service create --network logging -p 514:514 --name rsyslog-agent --mode global $REGISTRY/rsyslog-agent
docker service create -p 80:80 --name nginx --log-driver=syslog --log-opt syslog-address=tcp://localhost:514 $REGISTRY/nginx-syslog
```
These will setup centralized rsyslog-server, rsyslog-agents on every swarm node and one nginx service, one can create more nginx containers. Please bear in mind that rsyslog-agent must be set up before nginx.

# changing centralized rsyslog-server location and forwarding template in rsyslog-agent
There is a possibility to change the location of rsyslog-server and forwarding template entry by passing the `RSYSLOG_SERVER` and `FORWARD_TEMPLATE` environment variables like:

`-e FORWARD_TEMPLATE=*.sometemplate* -e RSYSLOG_SERVER=vgs-rsyslog.com`

in the service/container create command.

# caveats

That kind of rsyslog config would be easier/better to setup on Kubernetes because of simpler network model, concept of pods, services, daemon sets and persistent volume claims.

I have a little bit experience with fluentd(when I was using prometheus in one project) and a bit more with logstash. Moreover that rsyslog config could be linked to such more modern logging systems like fluentd or logstash.

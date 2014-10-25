docker-cgiproxy
============

A nice and easy way to get a CGI Proxy instance up and running using docker. For
help on getting started with docker see the [official getting started guide][0].
For more information on CGI Proxy and check out it's [website][1].


## Building docker-cgiproxy

Running this will build you a docker image with the latest version of both
docker-cgiproxy and CGI Proxy itself.

    docker build -t captnbp/docker-cgiproxy git://github.com/captnbp/docker-cgiproxy.git


## Running CGI Proxy

You can run this container with:

    sudo docker run -v /tmp/cgiproxy:/tmp captnbp/docker-cgiproxy

From now on when you start/stop docker-cgiproxy you should use the container id
with the following commands. To get your container id, after you initial run
type `sudo docker ps` and it will show up on the left side followed by the image
name which is `captnbp/docker-cgiproxy:latest`.

    sudo docker start <container_id>
    sudo docker stop <container_id>

## Using CGI proxy with Nginx
Add these lines in your /etc/nginx/nginx.conf :
	location /secret/ {
		fastcgi_pass   unix:/tmp/cgiproxy/cgiproxy.fcgi.socket;
		include        fastcgi.conf;
	}

Then restart Nginx :
	systemctl restart nginx

### Notes on the run command

 + `-v` is the volume you are mounting `-v host_dir:docker_dir`
 + `-d  allows this to run cleanly as a daemon, remove for debugging
 + `-p  is the port it connects to, `-p=host_port:docker_port`


[0]: http://www.docker.io/gettingstarted/
[1]: http://www.jmarshall.com/tools/cgiproxy/

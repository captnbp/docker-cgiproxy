FROM	ubuntu:14.04
MAINTAINER	Benoît Pourre "benoit.pourre@gmail.com"

RUN	locale-gen en_US en_US.UTF-8

# Make sure we don't get notifications we can't answer during building.
ENV	DEBIAN_FRONTEND noninteractive

# Update the system
RUN	apt-get -q update
RUN	apt-mark hold initscripts udev plymouth mountall
RUN	apt-get -qy --force-yes dist-upgrade

RUN	apt-get install -qy --force-yes git supervisor 
RUN	apt-get -yq install build-essential libcrypt-ssleay-perl libnet-ssleay-perl libcompress-raw-lzma-perl libio-compress-lzma-perl wget
RUN	cd /srv && wget http://www.jmarshall.com/tools/cgiproxy/releases/cgiproxy.latest.tar.gz && tar zxf cgiproxy.latest.tar.gz
RUN	cd /srv/ ; chmod +x nph-proxy.cgi ; ./nph-proxy.cgi install-modules

# Clean up
RUN	apt-get clean && rm -rf /tmp/* /var/tmp/* && rm -rf /var/lib/apt/lists/* && rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup
WORKDIR	/srv
CMD	["./nph-proxy.cgi", "start-fcgi"]

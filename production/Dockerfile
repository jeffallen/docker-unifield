# This is a Dockerfile to create a Unifield Environment on Ubuntu

FROM ubuntu:12.04.5
MAINTAINER Jeff Allen <jeff.allen@geneva.msg.org>

# Get noninteractive frontend for Debian to avoid some problems:
#    debconf: unable to initialize frontend: Dialog
ENV DEBIAN_FRONTEND noninteractive

RUN	apt-get update; \
	apt-get upgrade -y; \
	apt-get install -y supervisor bzr

# Install OpenERP (via bzr)
RUN	 mkdir -p /opt/unifield; \
	bzr checkout --lightweight -ruf2.1-3rc3 lp:unifield-server /opt/unifield/server; \
	bzr checkout --lightweight -ruf2.1-3rc3 lp:unifield-web /opt/unifield/web; \
	apt-get remove -y bzr ; \
	apt-get autoremove -y ; \
	mkdir -p /var/log/supervisor

# Add OpenERP dependencies
RUN apt-get install -y python python-psycopg2 python-reportlab \
	python-egenix-mxdatetime python-tz python-pychart \
	python-pydot python-lxml python-libxslt1 python-vobject \
	python-imaging python-profiler python-setuptools python-yaml \
	python-ldap python-cherrypy3 python-mako python-simplejson \
	python-formencode python-pybabel python-pip wkhtmltopdf

#RUN pip install -q requests
#RUN pip install -q httplib2
#RUN pip install -q six
#RUN pip install -q ordereddict
#RUN pip install -q jira

# Add configuration file to launch
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Ports: 8061(OpenERP Web Client)
EXPOSE 8061

# explicitly set user/group IDs
RUN groupadd -r unifield --gid=3114 && useradd -r -g unifield --uid=3114 unifield

# Launch supervisord as root
USER root
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

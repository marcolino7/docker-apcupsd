############################################################
# Dockerfile to build apcupsd container images
# Based on Ubunti 16.4
############################################################

FROM ubuntu:16.04
MAINTAINER Marcolino <marco.pozzuolo@gmail.com>

################## BEGIN INSTALLATION ######################
# Update apt and install compilers, tar and wget
RUN apt-get update && \ 
    apt-get -y install apcupsd apache2 nano apcupsd-cgi git python2.7 python-pip
	

# Cloning https://github.com/aelindeman/apcupsd-json-server
RUN git clone https://github.com/aelindeman/apcupsd-json-server
RUN cp ./apcupsd-json-server/apcupsd-json /usr/bin/
RUN chmod 0755 /usr/bin/apcupsd-json


# Clean apt, files and Directory
RUN apt-get clean
RUN rm -r ./apcupsd-json-server
##################### INSTALLATION END #####################

# Redirect sms3 logs to stdout
#RUN ln -sf /dev/stdout /var/log/smsd.log

# Create a script folder into /etc
RUN mkdir /etc/myscript

# Copy start script to folder and setting permission
ADD ./script/start.sh /etc/myscript/start.sh
RUN chmod 755 /etc/myscript/start.sh

# Copy apcupsd xxxx file
ADD ./script/apcupsd /etc/default/

RUN /etc/init.d/apache2 start
RUN a2enmod cgi
RUN /etc/init.d/apache2 restart

# Sart the custom start script
ENTRYPOINT ["/etc/myscript/start.sh"]


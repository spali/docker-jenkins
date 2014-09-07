FROM phusion/baseimage:0.9.13

# Set correct environment variables.
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
#######################################################################################

# add repo
RUN add-apt-repository -y "deb http://pkg.jenkins-ci.org/debian binary/"
RUN apt-key adv --fetch-keys http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key

# prepare for installation
RUN apt-get update

# install jenkins
RUN apt-get install -y jenkins

# setup service script
RUN mkdir /etc/service/jenkins
ADD jenkins.sh /etc/service/jenkins/run
RUN chmod +x /etc/service/jenkins/run

# setup init script
ADD jenkins_setup.sh /etc/my_init.d/jenkins_setup.sh
RUN chmod +x /etc/my_init.d/jenkins_setup.sh

# set jenkins home
ENV JENKINS_HOME /var/lib/jenkins

# expose port
EXPOSE 8080
EXPOSE 50000

# define volume mount
VOLUME ["/var/lib/jenkins"]

#######################################################################################
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

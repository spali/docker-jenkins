#!/bin/bash

exec sudo -u jenkins -H -E bash -c "/usr/bin/java $JAVA_ARGS $JENKINS_JAVA_OPTIONS $JENKINS_OPTS -jar /usr/share/jenkins/jenkins.war"


#!/bin/bash

# exit on any non-zero status
set -e

# fix permissions and ownership of /var/lib/redis
chown -R jenkins:jenkins /var/lib/jenkins
chmod 700 /var/lib/jenkins


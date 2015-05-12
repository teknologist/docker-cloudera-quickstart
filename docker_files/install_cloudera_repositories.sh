#!/bin/bash

echo 'Installing Cloudera repositories...'

curl -s http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh/archive.key | apt-key add -

echo 'deb [arch=amd64] http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh trusty-cdh5 contrib' > /etc/apt/sources.list.d/cloudera.list
echo 'deb-src http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh trusty-cdh5 contrib' >> /etc/apt/sources.list.d/cloudera.list

echo 'Cloudera repositories Installed.'
# Packages for Cloudera Manager, Version 5, on Ubuntu 14.04 x86_64
echo 'deb [arch=amd64] http://archive.cloudera.com/cm5/ubuntu/trusty/amd64/cm trusty-cm5 contrib' >> /etc/apt/sources.list.d/cloudera.list
echo 'deb-src http://archive.cloudera.com/cm5/ubuntu/trusty/amd64/cm trusty-cm5 contrib' >> /etc/apt/sources.list.d/cloudera.list

echo 'Cloudera Manager repositories Installed.'
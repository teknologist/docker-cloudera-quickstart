# VERSION   0.1

FROM ubuntu:14.04
MAINTAINER The Teknologist <teknologist@gmail.com>

RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y --no-install-recommends oracle-java7-installer=7u80+7u60arm-0~webupd8~0 oracle-java7-set-default


ADD docker_files/cdh_installer.sh /tmp/cdh_installer.sh
ADD docker_files/install_cloudera_repositories.sh /tmp/install_cloudera_repositories.sh

ADD docker_files/cdh_startup_script.sh /usr/bin/cdh_startup_script.sh
ADD docker_files/cloudera.pref /etc/apt/preferences.d/cloudera.pref
ADD docker_files/hadoop-env.sh /etc/profile.d/hadoop-env.sh
ADD docker_files/spark-env.sh /etc/profile.d/spark-env.sh
ADD docker_files/spark-defaults.conf /etc/spark/conf/spark-defaults.conf
#ADD docker_files/cloudera-scm-agent-config.ini /etc/cloudera-scm-agent/config.ini


ENV TERM xterm

#The solr config file needs to be added after installation or it fails.
ADD docker_files/solr /etc/default/solr.docker

RUN \
    chmod +x /tmp/cdh_installer.sh && \
    chmod +x /usr/bin/cdh_startup_script.sh && \
    bash /tmp/cdh_installer.sh

# private and public mapping
EXPOSE 8020:8020
EXPOSE 8888:8888
EXPOSE 11000:11000
EXPOSE 11443:11443
EXPOSE 9090:9090
EXPOSE 8088:8088
EXPOSE 19888:19888
EXPOSE 7180:7180

# private only
#EXPOSE 80

# Define default command.
#CMD ["/usr/bin/cdh_startup_script.sh && bash"]
#CMD ["bash /usr/bin/cdh_startup_script.sh && bash"]
CMD ["cdh_startup_script.sh"]

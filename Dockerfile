FROM ubuntu:16.04

MAINTAINER Michael Staehler <hamsterhase@gmx.de>

# Install the python script required for "add-apt-repository" 
RUN apt-get update && apt-get install -y software-properties-common curl git

# Sets language to UTF8 : this works in pretty much all cases 
ENV LANG en_US.UTF-8 
RUN locale-gen $LANG

# Setup the openjdk 8 repo 
RUN add-apt-repository ppa:openjdk-r/ppa

# Install java8 
RUN apt-get install -y openjdk-8-jdk

# Setup JAVA_HOME, this is useful for docker commandline 
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/ 
RUN export JAVA_HOME

# Install Maven
ARG MAVEN_VERSION=3.3.9
ARG USER_HOME_DIR="/root"

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

# install Docker
#RUN apt-get install apt-transport-https ca-certificates nano -y
#RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
#RUN echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | tee /etc/apt/sources.list.d/docker.list
#RUN apt-get update -y && apt-get install docker-engine -y

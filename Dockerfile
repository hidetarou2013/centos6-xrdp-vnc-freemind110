FROM kevensen/centos-vnc
MAINTAINER hidetarou2013 <hidetoshi_maekawa@e-it.co.jp>

#----------------------------
# japanese
#----------------------------
USER root
RUN yum reinstall -y glibc-common
ENV LANG ja_JP.utf8

#----------------------------
# java8
#----------------------------
#USER root
ADD install_java8.sh /tmp/install_java8.sh
RUN /bin/bash /tmp/install_java8.sh
ENV JAVA_HOME /usr/java/latest
ENV JRE_HOME /usr/java/latest

#----------------------------
# freemind
#----------------------------
#USER root
RUN yum install -y unzip wget curl sudo
#RUN wget https://osdn.jp/projects/sfnet_freemind/downloads/freemind-unstable/1.1.0_Beta2/freemind-bin-max-1.1.0_Beta_2.zip
ADD freemind-bin-max-1.1.0_Beta_2.zip /tmp/freemind/
WORKDIR /tmp/freemind
RUN unzip freemind-bin-max-1.1.0_Beta_2.zip
#RUN ls -l /tmp/freemind
RUN mv /tmp/freemind /usr/local/
RUN ls -l /usr/local/freemind
RUN rm -f /usr/local/freemind/freemind-bin-max-1.1.0_Beta_2.zip
RUN chmod 755 /usr/local/freemind/freemind.sh
RUN /bin/echo "/usr/local/freemind/freemind.sh" >> /home/kioskuser/.vnc/xstartup 

#----------------------------
# tag:1920x1024
#----------------------------
WORKDIR /usr/bin
RUN sed -i -e 's/1024x768/1920x1024/g' vncserver

#
# ipa font
#
RUN yum update -y && yum install -y ipa-mincho-fonts \
    ipa-gothic-fonts \
    ipa-pmincho-fonts \
    ipa-pgothic-font \
    gnome-session && yum clean all; rm -rf /var/cache/yum
    
USER kioskuser

#EXPOSE 5901
#ENTRYPOINT ["/usr/bin/vncserver","-fg"]

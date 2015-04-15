FROM localhost:5000/rhel/fedora:21

MAINTAINER tsheibar@gmail.com

ENV UPDATED 20150414

EXPOSE 80

ADD resources/supervisord.conf /etc/supervisord.conf

ADD resources/provision.sh /root/provision.sh

RUN /root/provision.sh

ENTRYPOINT ["/var/venv/bin/supervisord", "-c", "/etc/supervisord.conf"]
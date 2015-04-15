#!/bin/bash

yum -y install deltarpm
yum -y install nginx
yum -y install python-pip python-virtualenv

virtualenv /var/venv
source /var/venv/bin/activate
pip install supervisor

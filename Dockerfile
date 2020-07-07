FROM odoo:13.0
MAINTAINER thang@camratus.com
COPY requirements.txt /mnt/requirements.txt
USER root
RUN pip3 install wheel
RUN pip3 install -r /mnt/requirements.txt
USER odoo
EXPOSE 8069

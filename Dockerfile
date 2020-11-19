FROM odoo:13.0
MAINTAINER thang@camratus.com
COPY requirements.txt /mnt/requirements.txt
USER root
ADD locale_issue_61923 /usr/lib/python3/dist-packages/odoo/addons/web/static/lib/pdfjs/web/locale
RUN pip3 install wheel
RUN pip3 install -r /mnt/requirements.txt
USER odoo
EXPOSE 8069

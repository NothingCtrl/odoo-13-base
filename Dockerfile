FROM odoo:13.0
MAINTAINER thang@camratus.com
COPY requirements.txt /mnt/requirements.txt
USER root
ADD locale_issue_61923 /usr/lib/python3/dist-packages/odoo/addons/web/static/lib/pdfjs/web/locale
COPY patch/odoo/odoo/netsvc.py /usr/lib/python3/dist-packages/odoo/netsvc.py
RUN pip3 install wheel
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade setuptools
RUN pip3 install -r /mnt/requirements.txt
USER odoo
EXPOSE 8069

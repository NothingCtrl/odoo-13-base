FROM odoo:13.0
MAINTAINER thang@camratus.com
USER root
# --- update latest source code of Odoo 13.0 CE
RUN rm -rf /usr/lib/python3/dist-packages/odoo
ADD odoo/odoo /usr/lib/python3/dist-packages/odoo
ADD odoo/addons /usr/lib/python3/dist-packages/odoo/addons
RUN rm -rf /usr/lib/python3/dist-packages/odoo/.git
# --- end odoo source update
COPY requirements.txt /mnt/requirements.txt
ADD locale_issue_61923 /usr/lib/python3/dist-packages/odoo/addons/web/static/lib/pdfjs/web/locale
COPY patch/odoo/odoo/netsvc.py /usr/lib/python3/dist-packages/odoo/netsvc.py
RUN apt-get update && apt-get install -y nano
RUN pip3 install wheel
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade setuptools
RUN pip3 install -r /mnt/requirements.txt
USER odoo
EXPOSE 8069

FROM openshift/base-centos7

# This image provides a nodejs and python 3.5 image with jupyterhub and
# jupyter notebook installed 

MAINTAINER geointservices.io <devops@nga.mil>

EXPOSE 8080

# Add $HOME/node_modules/.bin to the $PATH, allowing user to make npm scripts
# available on the CLI without using npm's --global installation mode
# This image will be initialized with "npm run $NPM_RUN"
# See https://docs.npmjs.com/misc/scripts, and your repo's package.json
# file for possible values of NPM_RUN
ENV NODEJS_VERSION=4 \
    NPM_RUN=start \
    NPM_CONFIG_PREFIX=$HOME/.npm-global \
    PATH=$HOME/node_modules/.bin/:$HOME/.npm-global/bin/:$PATH \
    PYTHON_VERSION=3.5 \
    PATH=$HOME/.local/bin/:$PATH \
    LD_LIBRARY_PATH=/opt/rh/rh-python35/root/lib64:/opt/rh/rh-nodejs4/root/lib64/ \
    PATH=$PATH:/opt/rh/rh-nodejs4/root/bin/ \
    PYTHON_VERSION=3.5 \
    PATH=$HOME/.local/bin/:$PATH

LABEL summary="Jupyter Hub Platform" \
      io.k8s.description="Platform for running the Jupyter Hub with notebooks." \
      io.k8s.display-name="Geoint Services Jupyter" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="nodejs,nodejs4,python,python35,jupyterhub,jpyternotebook" 

RUN chown -R 1001:0 /opt/app-root && chmod -R ug+rwx /opt/app-root && \
    yum install -y centos-release-scl-rh && \
    INSTALL_PKGS="rh-nodejs4 rh-nodejs4-npm rh-nodejs4-nodejs-nodemon rh-python35 rh-python35-python-devel rh-python35-python-setuptools rh-python35-python-pip epel-release nss_wrapper" && \
    ln -s /usr/lib/node_modules/nodemon/bin/nodemon.js /usr/bin/nodemon && \
    yum install -y --setopt=tsflags=nodocs --enablerepo=centosplus $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y

# Drop the root user and make the content of /opt/app-root owned by user 1001
RUN chown -R 1001:0 /opt/app-root && chmod -R ug+rwx /opt/app-root
USER 1001

ENV PATH=$PATH:/opt/rh/rh-python35/root/bin/:/opt/rh/rh-nodejs4/root/bin/:$HOME/node_modules/.bin/:$HOME/.npm-global/bin/:$PATH

RUN /opt/rh/rh-python35/root/bin/pip3 install jupyterhub --user && \
    /opt/rh/rh-python35/root/bin/pip3 install --upgrade notebook --user && \
    /opt/rh/rh-python35/root/bin/pip3 install --upgrade jinja2 --user && \
    /opt/rh/rh-python35/root/bin/pip3 install --upgrade jinja2 --user && \
    /opt/rh/rh-nodejs4/root/bin/npm install configurable-http-proxy

CMD /opt/app-root/src/.local/bin/jupyterhub --ip 0.0.0.0 --no-ssl 


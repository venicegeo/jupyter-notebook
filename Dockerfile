FROM openshift/python-33-centos7
MAINTAINER geointservices.io <devops@nga.mil>
EXPOSE 8888
LABEL io.k8s.description="Jupyter Notebook geointservices container" \
      io.k8s.display-name="Geointservices Jupyter Notebook" \
      io.openshift.expose-services="8888:http" \
      io.openshift.tags="python,jupyter"
USER 1001
ENV LD_LIBRARY_PATH /opt/rh/python33/root/usr/lib64
RUN  /opt/rh/python33/root/usr/bin/pip3.3 install jupyter --user
CMD /opt/app-root/src/.local/bin/jupyter notebook --no-browser --ip=0.0.0.0


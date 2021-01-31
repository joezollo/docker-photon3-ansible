FROM photon:3.0

ENV container=docker
ENV pip_packages "ansible"

RUN tdnf -y update && \
    tdnf -y install rpm systemd initscripts \
      sudo which python3 python3-pip \
      openssh coreutils && \
    tdnf clean all

RUN pip3 install -U pip && \
    pip3 install -U wheel setuptools && \
    pip3 install $pip_packages

RUN sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers && \
    mkdir -p /etc/ansible && \
    echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/lib/systemd/systemd"]
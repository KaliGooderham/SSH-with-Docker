FROM rockylinux:8
RUN dnf install -y \
    hostname \
    ncurses \
    iproute \
    net-tools \
    vim \
    less \
    man \
    openssh-server \
    openssh-clients \
    passwd \
    procps-ng \
    sed \
    && dnf clean all
RUN /usr/bin/ssh-keygen -A
RUN sed -i -e 's/#Port 22/Port 2220/g' /etc/ssh/sshd_config
RUN echo "root:fluffy2" | chpasswd
EXPOSE 2220
CMD ["/usr/sbin/sshd", "-D"]

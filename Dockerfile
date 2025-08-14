FROM rockylinux:8

# Installations
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

# Generating keys
RUN /usr/bin/ssh-keygen -A

# Switching the default port from 22 to 2220
RUN sed -i -e 's/#Port 22/Port 2220/g' /etc/ssh/sshd_config

# Changing password to get into server
RUN echo "root:PASSHERE" | chpasswd

EXPOSE 2220

# -D to have the process run in the foreground instead of the background
CMD ["/usr/sbin/sshd", "-D"]

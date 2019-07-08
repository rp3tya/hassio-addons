ARG BUILD_FROM
FROM $BUILD_FROM

# Install SSH server (without root login)
RUN apk add --no-cache openssh-server

# /var/run/sshd dir is needed
RUN mkdir /var/run/sshd

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]


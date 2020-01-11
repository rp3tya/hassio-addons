ARG BUILD_FROM
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

# Setup base
RUN apk add --no-cache nginx openssl

# Copy data
COPY nginx.conf /etc/
COPY run.sh /

# Entrypoint
RUN chmod a+x /run.sh
CMD [ "/run.sh" ]

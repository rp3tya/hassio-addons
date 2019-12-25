ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8
ENV PYTHONUNBUFFERED=1

RUN echo "**** install Python ****" && \
    apk add --no-cache python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    \
    echo "**** install pip ****" && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi
    
RUN pip3 install --no-cache --upgrade radicale radicale[bcrypt]

RUN mkdir -p /etc/radicale

COPY radicale.conf /etc/radicale/config

COPY run.sh /
RUN chmod a+x /run.sh
CMD [ "/run.sh" ]

ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN apk add --no-cache nodejs npm
RUN npm install chartjs-node

# Copy data for add-on
COPY testchart.js /config/

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]

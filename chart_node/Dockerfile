ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache nodejs npm cairo python pkgconf cairo-dev make g++

RUN npm install chart.js chartjs-node sqlite3

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]


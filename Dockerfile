FROM alpine

RUN apk --no-cache add docker docker-compose

WORKDIR /app
COPY deploy.sh /

CMD ["/deploy.sh"]

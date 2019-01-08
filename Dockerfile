FROM alpine

# install docker and docker-compose
# note docker-compose at this time requires installing python, which is
# unfortunate (2019-01)
RUN apk --no-cache add \
		docker \
		py-pip \
	&& pip install docker-compose

WORKDIR /app
COPY deploy.sh /

CMD ["/deploy.sh"]

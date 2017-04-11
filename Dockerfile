FROM alpine

# install docker and docker-compose
# note docker-compose at this time requires installing python, which is
# unfortunate (2017-03)
RUN apk --no-cache add \
		docker \
		py-pip \
	&& pip install docker-compose

COPY deploy.sh /
RUN chmod +x deploy.sh

CMD ["/deploy.sh"]

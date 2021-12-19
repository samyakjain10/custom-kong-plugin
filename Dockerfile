FROM ubuntu:bionic

# Set the kong version to run
ENV KONG_VERSION 1.4.3

# install the appropriate Kong version
RUN apt-get update \
	&& apt-get install -y --no-install-recommends ca-certificates curl perl unzip sudo zlib1g-dev \
	&& rm -rf /var/lib/apt/lists/* \
	&& curl -Lo kong-enterprise-edition-2.7.0.0.all.deb "https://download.konghq.com/gateway-2.x-ubuntu-bionic/pool/all/k/kong-enterprise-edition/kong-enterprise-edition_2.7.0.0_all.deb" \
	&& apt-get purge -y --auto-remove ca-certificates curl \
	&& sudo dpkg -i kong-enterprise-edition-2.7.0.0.all.deb \
	&& rm -rf kong-enterprise-edition-2.7.0.0.all.deb 

# Copy configs to directory where Kong looks for effective configs
COPY ./conf/ /etc/kong/

# Copy Plugins to directory where kong expects plugin rocks
COPY ./plugins/ /usr/local/custom/kong/plugins/

# Copy scripts to starting location
COPY ./scripts/ .

RUN ["chmod", "+x", "./docker-entrypoint.sh"]

ENTRYPOINT [ "./docker-entrypoint.sh"]

EXPOSE 8000 8443 8001 8444

STOPSIGNAL SIGQUIT

CMD ["kong", "docker-start"]

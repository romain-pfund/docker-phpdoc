FROM php:7.2

RUN apt-get update \
    && apt-get install --yes -q wget gpg graphviz
RUN cd /opt/ \
    && wget https://phar.io/releases/phive.phar \
    && wget https://phar.io/releases/phive.phar.asc
	
RUN	gpg --keyserver hkps://keys.openpgp.org --recv-keys 0x9D8A98B29B2D5D79
RUN gpg --verify /opt/phive.phar.asc /opt/phive.phar

RUN chmod +x /opt/phive.phar \
    && mv /opt/phive.phar /usr/bin/phive
RUN /usr/bin/phive install --force-accept-unsigned --trust-gpg-keys 6DA3ACC4991FFAE5 phpDocumentor
ENTRYPOINT ["php", "/tools/phpDocumentor"]

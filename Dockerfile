FROM jjmerelo/perl-test-text
LABEL version="1.0" maintainer="JJ Merelo <jjmerelo@GMail.com>" perl5version="5.22"

WORKDIR /install
ADD cpanfile .
RUN apt-get update && apt-get install -y git
RUN cpanm --installdeps .

VOLUME /test
WORKDIR /test

ENTRYPOINT cp /install/data/*.dic /install/data/*.aff /test && prove -I/usr/lib -c

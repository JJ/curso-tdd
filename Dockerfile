FROM jjmerelo/p6-test-text
LABEL version="1.0" maintainer="JJ Merelo <jjmerelo@GMail.com>" perl5version="5.22"

ADD cpanfile .
RUN cpanm --installdeps .

VOLUME /test
WORKDIR /test

ENTRYPOINT prove -I/usr/lib -c

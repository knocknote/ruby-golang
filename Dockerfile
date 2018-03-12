FROM golang:1.10
MAINTAINER Knocknote<tech@knocknote.co.jp>

ENV GOPATH /go

ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
RUN wget https://www.openssl.org/source/openssl-1.0.2l.tar.gz \
    && tar xzf openssl-1.0.2l.tar.gz
WORKDIR openssl-1.0.2l
RUN ./config --prefix=/usr/local/openssl shared \
    && make \
    && make install \
    && wget http://zlib.net/zlib-1.2.11.tar.gz \
    && tar xzf zlib-1.2.11.tar.gz
WORKDIR zlib-1.2.11
RUN ./configure \
    &&  make \
    &&  make install \
    && wget https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.4.tar.gz \
    && tar xzf ruby-2.3.4.tar.gz
WORKDIR ruby-2.3.4
RUN ./configure --with-opt-dir=/usr/local/openssl --enable-shared \
    && make \
    && make install

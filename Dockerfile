FROM centos:7 AS builder

ENV PATH=/root/.local/bin:$PATH

RUN yum groupinstall -y "Development Tools"
RUN yum install -y epel-release zlib-devel postgresql-devel ncurses-devel tree wget

RUN curl -sSL https://downloads.haskell.org/~ghc/8.6.5/ghc-8.6.5-x86_64-centos7-linux.tar.xz | tar -xJf - -C /root/
RUN curl -sSL https://github.com/haskell/haskell-ide-engine/archive/1.3.tar.gz | tar xzf - -C /root/
RUN curl -sSL https://get.haskellstack.org/ | sh

WORKDIR /root/ghc-8.6.5
RUN ./configure --prefix=/root/ghc-8.6.5/pkgdir \
    && make install \
    && tar -cvf /root/ghc-8.6.5-pkg.tar -C /root/ghc-8.6.5/pkgdir .

WORKDIR /root/haskell-ide-engine-1.3
RUN stack --stack-yaml=stack-8.6.5.yaml --local-bin-path /usr/local/bin/ install

FROM centos:7
COPY --from=builder /usr/local/bin/hie* /usr/local/bin/
COPY --from=builder /root/ghc-8.6.5-pkg.tar /root/ghc-8.6.5-pkg.tar
RUN tar -xf /root/ghc-8.6.5-pkg.tar -C /usr/local/ \
    && rm -rf /root/ghc-8.6.5-pkg.tar

RUN curl -sSL https://get.haskellstack.org/ | sh

RUN yum groupinstall -y "Development Tools"
RUN yum install -y epel-release zlib-devel postgresql-devel ncurses-devel tree wget


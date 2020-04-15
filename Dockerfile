FROM centos:7

ENV PATH=/root/.local/bin:$PATH

RUN yum groupinstall -y "Development Tools"
RUN yum install -y epel-release zlib-devel postgresql-devel ncurses-devel tree wget

RUN curl -sSL curl -sSL https://downloads.haskell.org/~cabal/cabal-install-2.4.1.0/cabal-install-2.4.1.0-x86_64-unknown-linux.tar.xz | tar -xJf - -C /usr/local/bin/
RUN curl -sSL https://github.com/haskell/haskell-ide-engine/archive/1.3.tar.gz | tar xzf - -C /root
RUN curl -sSL https://get.haskellstack.org/ | sh

RUN cd /root/haskell-ide-engine-1.3 \
    && stack --stack-yaml=stack-8.6.5.yaml --local-bin-path /usr/local/bin/ install


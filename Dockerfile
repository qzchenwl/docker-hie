FROM centos:8 AS builder

RUN update-ca-trust \
    && dnf groupinstall -y "Development Tools" \
    && dnf install -y epel-release zlib-devel postgresql-devel ncurses-devel tree wget

RUN curl -sSL https://get.haskellstack.org/ | sh \
    && curl -sSL https://github.com/haskell/haskell-ide-engine/archive/1.3.tar.gz | tar xzf - -C /root/ \
    && cd /root/haskell-ide-engine-1.3 \
    && stack --stack-yaml=stack-8.6.5.yaml --local-bin-path /usr/local/bin/ install


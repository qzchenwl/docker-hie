FROM centos:8 AS builder

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial \
    && dnf groupinstall -y "Development Tools" \
    && dnf install -y zlib-devel postgresql-devel ncurses-devel ncurses-compat-libs

RUN curl -sSL https://get.haskellstack.org/ | sh \
    && curl -sSL https://github.com/haskell/haskell-ide-engine/archive/1.3.tar.gz | tar xzf - -C /root/ \
    && cd /root/haskell-ide-engine-1.3 \
    && stack --stack-yaml=stack-8.8.2.yaml --local-bin-path /usr/local/bin/ install \
    && rm -rf /root/.stack /root/haskell-ide-engine-1.3


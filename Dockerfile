FROM centos:7

ENV PATH=/root/.local/bin:$PATH

RUN yum groupinstall -y "Development Tools"
RUN yum install -y epel-release zlib-devel postgresql-devel ncurses-devel cabal-install tree wget

RUN curl -sSL https://get.haskellstack.org/ | sh
RUN curl -sSL https://github.com/haskell/haskell-ide-engine/archive/1.3.tar.gz | tar xzf - -C /root

RUN cd /root/haskell-ide-engine-1.3 \
    && stack --stack-yaml=stack-8.6.5.yaml install


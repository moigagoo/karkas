FROM nimlang/choosenim

WORKDIR /usr/src/app

COPY . /usr/src/app

RUN choosenim devel
RUN nimble install -y
RUN git config --global --add safe.directory /usr/src/app


FROM nimlang/nim:1.6.14

WORKDIR /usr/src/app

COPY . /usr/src/app

ENV PATH="/root/.nimble/bin:$PATH"

RUN nimble install -y nimble
RUN nimble install -y
RUN git config --global --add safe.directory /usr/src/app


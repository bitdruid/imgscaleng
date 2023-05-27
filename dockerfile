FROM ubuntu:23.10

RUN apt-get -qq update && apt-get -qq install -y \
    python3 \
    python3-pip \
    python3-dev \
    python3-setuptools \
    nginx \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://rpm.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install npm@latest -g \
    && npm install -g @angular/cli

RUN git clone https://github.com/xinntao/Real-ESRGAN \
    && cd Real-ESRGAN \
    && pip3 install -r requirements.txt \
    && python setup.py develop

# build ng app
COPY ./imgscaleng/ /app
WORKDIR /app
RUN ng build --configuration production

RUN cp docker_entry.sh /usr/local/bin/ \
    && chmod +x /usr/local/bin/docker_entry.sh
ENTRYPOINT [ "docker_entry.sh" ]

ENV PORT=
EXPOSE 8080
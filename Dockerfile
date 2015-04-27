FROM bobrik/logstash

MAINTAINER Alexey Kupershtokh <alexey.kupershtokh@gmail.com>

RUN apt-get update \
    && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/moshen/logstash-http-input.git /tmp/logstash-http-input \
    && cd /tmp/logstash-http-input \
    && ./gradlew install -PinstallDir=/opt/logstash \
    && ln -s /opt/logstash/plugins/logstash/inputs/http.rb /opt/logstash/lib/logstash/inputs/http.rb \
    && rm -rf /tmp/logstash-http-input

CMD ["-f", "/etc/logstash/conf.d/"]
FROM ruby
RUN apt-get -y update && apt-get -y install libicu-dev cmake && rm -rf /var/lib/apt/lists/*
RUN gem install github-linguist && \
    gem install gollum && \
    gem install org-ruby && \
    gem install omnigollum && \
    gem install omniauth-openid
RUN gem install omniauth-keycloak && \
    find /usr/local/bundle/gems/omniauth-keycloak-* -type f -exec chmod 644 {} \; && \
    find /usr/local/bundle/gems/omniauth-keycloak-* -type d -exec chmod 755 {} \; && \
WORKDIR /wiki
ENTRYPOINT ["gollum", "--port", "4567", "--config", "config.rb"]
EXPOSE 4567
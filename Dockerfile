FROM python:3.14-slim

LABEL maintainer="Fantaz"

ARG SOMEDL_VERSION=latest

ENV DENO_INSTALL="/usr/local"
ENV PATH="$DENO_INSTALL/bin:$PATH"

RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    curl \
    gosu \
    unzip \
    && curl -fsSL https://deno.land/install.sh | sh \
    && rm -rf /var/lib/apt/lists/*

RUN if [ "$SOMEDL_VERSION" = "latest" ]; then \
        pip install --no-cache-dir somedl; \
    else \
        pip install --no-cache-dir somedl=="${SOMEDL_VERSION}"; \
    fi

RUN groupadd somedl && \
    useradd -M -g somedl somedl

ENV XDG_CONFIG_HOME=/config

RUN mkdir -p /config/SomeDL /downloads

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME /downloads

WORKDIR /downloads

EXPOSE 5000

ENTRYPOINT ["/entrypoint.sh"]
CMD ["somedl", "web", "--host", "0.0.0.0", "--port", "5000", "--no-browser", "--output", "/downloads"]
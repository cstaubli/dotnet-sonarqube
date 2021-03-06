FROM mcr.microsoft.com/dotnet/sdk:5.0

LABEL maintainer="Christian Staubli <christian.staubli@gmail.com>"

RUN mkdir -p /usr/share/man/man1 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        openjdk-11-jre-headless \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_VER=11
ENV JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"

ENV PATH="${PATH}:/root/.dotnet/tools"

RUN dotnet tool install -g dotnet-sonarscanner

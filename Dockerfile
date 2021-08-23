FROM debian:bullseye-slim

# Make sure JSON files created are owned by the host's account and not root
ARG USER_ID
ARG GROUP_ID

RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user

# Install speedtest
ENV os=debian
ENV dist=bullseye 

RUN apt-get update && apt-get install -y curl wget
RUN curl -s https://install.speedtest.net/app/cli/install.deb.sh | bash
RUN apt-get install -y speedtest

# Switch to host user and run the test
USER user

COPY src /src
RUN speedtest --accept-license 1> /dev/null

CMD src/run-test

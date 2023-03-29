FROM --platform=linux/amd64 ubuntu:22.10

WORKDIR /app

# icaclient dependencies
RUN apt-get update && \
  env DEBIAN_FRONTEND=noninteractive apt-get install -y libice6 libsm6 libxmu6 libxpm4 libasound2 libidn12 libgtk2.0-0

# an environment to test with
RUN apt-get update && \
  env DEBIAN_FRONTEND=noninteractive apt-get install -y xvfb fluxbox x11-utils xdg-utils freerdp2-x11 wmctrl x11vnc

COPY icaclient_23.3.0.32_amd64.deb .
RUN dpkg --install "icaclient_23.3.0.32_amd64.deb"

COPY container_script.sh .
COPY launch.ica .

EXPOSE 5920
CMD ./container_script.sh

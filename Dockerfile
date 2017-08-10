FROM debian:jessie

MAINTAINER Vitaly Iegorov <egorov@samsonos.com>

ENV DEBIAN_FRONTEND noninteractive

# Set debian non interactive mode
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && export DEBIAN_FRONTEND="noninteractive"

# Install basic dependencies
RUN apt-get update && apt-get install -y curl xvfb git gconf2 apt-utils ssh

# Add Google Chrome
RUN curl -O -k https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add linux_signing_key.pub
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

# Add NodeJS
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -

# Install Chrome, NodeJS
RUN apt-get install -y google-chrome-stable nodejs
# Install JS dependencies
RUN npm install -g @angular/cli

# Set virtual display
RUN export DISPLAY=:1 && Xvfb $DISPLAY -ac -screen 0 1280x1024x8 &
RUN xvfb-run webdriver-manager start &

WORKDIR /usr/src/app

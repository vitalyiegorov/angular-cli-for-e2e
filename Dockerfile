FROM dala00/chromium-xvfb-angular-cli

ENV DEBIAN_FRONTEND noninteractive

# Set debian non interactive mode
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && export DEBIAN_FRONTEND="noninteractive" && \
    # Install WGET
    apt-get update && apt-get install -y wget && \
    # Install Google chrome
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
    apt-get update && apt-get install -y --no-install-recommends default-jre google-chrome-stable gconf2 apt-utils && \
    # Set virtual display
    export DISPLAY=:1 && \
    Xvfb $DISPLAY -ac -screen 0 1280x1024x8 &

RUN xvfb-run webdriver-manager start &

WORKDIR /usr/src/app

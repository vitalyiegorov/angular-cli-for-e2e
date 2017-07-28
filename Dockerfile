FROM dala00/chromium-xvfb-angular-cli


RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update && apt-get install -y default-jre wget google-chrome-stable
RUN export DISPLAY=:1
RUN Xvfb $DISPLAY -ac -screen 0 1280x1024x8 &
RUN xvfb-run webdriver-manager start &
WORKDIR /usr/src/app

FROM ubuntu:20.10
RUN mkdir app
RUN apt-get update
RUN apt-get install -y sudo curl git gnupg
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN sudo apt update && sudo apt install -y yarn
WORKDIR /app
COPY / /app
RUN yarn install
RUN yarn monkey-patch && yarn schema:totypes 
RUN yarn prod:build
CMD yarn prod:serve


## Get Code and build App
FROM node:buster as build

ARG REPO=https://github.com/meteyou/mainsail
ARG VERSION=master

RUN git clone ${REPO} /opt/mainsail \
 && cd /opt/mainsail \
 && git checkout ${VERSION}

WORKDIR /opt/mainsail
RUN npm install \
 && ./node_modules/.bin/vue-cli-service build

## Runtime Image
FROM nginx:alpine as run

COPY --from=build /opt/mainsail/dist /usr/share/nginx/html
RUN chown -R nginx:nginx /usr/share/nginx/html
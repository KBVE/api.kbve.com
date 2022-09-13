FROM node:16

# Update and install LibVips
RUN apt-get update && apt-get install libvips-dev -y

# Environment Settings
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}

WORKDIR /opt/

COPY ./package.json ./yarn.lock ./

ENV PATH /opt/node_modules/.bin:$PATH
RUN yarn config set network-timeout 600000 -g && yarn install

WORKDIR /opt/app
COPY ./ .
# Yarn Build
RUN yarn build

# Run on port 1337
EXPOSE 1337
CMD ["yarn", "develop"] 
FROM node:16

# Update and install LibVips
RUN apt-get update && apt-get install libvips-dev -y

# Environment Settings
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /api

#COPY ./package.json ./yarn.lock ./ (Previous Dockerfile)
COPY package.json .
COPY yarn.lock .


ENV PATH /api/node_modules/.bin:$PATH
RUN yarn config set network-timeout 600000 -g
RUN yarn install –frozen-lockfile

#WORKDIR /api
COPY ./ .
# Yarn Build
RUN yarn build

# Run on port 1337
EXPOSE 1337
CMD ["yarn", "develop"] 

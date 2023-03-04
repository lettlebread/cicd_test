# Use the official lightweight Node.js 10 image.
# https://hub.docker.com/_/node
FROM node:14-slim

ARG ENV_VAR=dev
ENV SERVER_ENV=$ENV_VAR

# Create and change to the app directory.
WORKDIR /usr/src/app

COPY . ./

WORKDIR /usr/src/app/cicd
# Copy application dependency manifests to the container image.
# A wildcard is used to ensure copying both package.json AND package-lock.json (when available).
# Copying this first prevents re-running npm install on every code change.
COPY cicd/package*.json ./

# Install production dependencies.
# If you add a package-lock.json, speed your build by switching to 'npm ci'.
# RUN npm ci --only=production
RUN npm ci install

# Copy local code to the container image.
COPY . ./

# Run the web service on container startup.
RUN ENV=$SERVER_ENV npm run build
CMD [ "npm", "run", "start" ]
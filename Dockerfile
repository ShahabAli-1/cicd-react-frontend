FROM node:alpine3.18 as build

# declare build time env variables
ARG REACT_APP_NODE_ENV
ARG REACT_APP_SERVER_BASE_URL

# Set default values for env variables
ENV REACT_APP_NODE_ENV=$REACT_APP_NODE_ENV
ENV REACT_APP_SERVER_BASE_URL=$REACT_APP_SERVER_BASE_URL

# Build App
WORKDIR /app

COPY package.json ./

RUN npm install

COPY . .

RUN npm run build

# Server with Nginx

FROM nginx:1.23-alpine

WORKDIR /usr/share/nginx/html

RUN rm -rf *

COPY --from=build /app/build ./

EXPOSE 80

CMD [ "nginx","-g","daemon off;" ]




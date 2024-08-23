FROM node:alpine3.18 as build

# Build App
WORKDIR /app

COPY package.json ./

RUN npm install

COPY . .

RUN npm run build

# Server with Nginx

FROM nginx:1.23-alpine

WORKDIR /user/share/nginx/html

RUN rm -rf *

COPY --from=build /app/build ./

EXPOSE 80

CMD [ "nginx","-g","daemon off;" ]




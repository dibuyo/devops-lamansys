FROM node:10

LABEL maintainer="dibuyo@gmail.com"

WORKDIR /app

COPY ./src/express .

RUN npm install

CMD [ "node", "index.js" ]

EXPOSE 3000/tcp
FROM node:20-slim

WORKDIR /app

COPY package.json package-lock.json server.js ./

RUN npm ci

EXPOSE 3100

CMD ["node", "server.js"]

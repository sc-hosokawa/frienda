FROM node:20-slim

RUN npm install -g firebase-tools

WORKDIR /app

COPY firebase.json .

EXPOSE 4000 9099 9199

CMD ["firebase", "emulators:start", "--project", "frienda-local", "--only", "auth,storage"]

FROM node:20-slim

RUN npm install -g firebase-tools

WORKDIR /app

COPY firebase.json storage.rules ./

EXPOSE 4000 9099 9199

CMD firebase emulators:start --only auth,storage --project "${GCLOUD_PROJECT:-frienda-local}"

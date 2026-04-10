FROM node:20-slim

RUN apt-get update && apt-get install -y --no-install-recommends default-jre-headless \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g firebase-tools

WORKDIR /app

COPY firebase.json storage.rules ./

EXPOSE 4000 9099 9199

CMD ["sh", "-c", "exec firebase emulators:start --only auth,storage --project \"${GCLOUD_PROJECT:-frienda-local}\""]

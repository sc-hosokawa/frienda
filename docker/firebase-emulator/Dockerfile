FROM eclipse-temurin:21-jre AS jre

FROM node:20-slim

COPY --from=jre /opt/java/openjdk /opt/java/openjdk
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"

RUN npm install -g firebase-tools

WORKDIR /app

COPY firebase.json storage.rules ./

EXPOSE 4000 9099 9199

CMD ["sh", "-c", "exec firebase emulators:start --only auth,storage --project \"${GCLOUD_PROJECT:-frienda-local}\""]

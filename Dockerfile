FROM node:23-alpine
ENV NODE_OPTIONS="--openssl-legacy-provider"

WORKDIR /studyopenings

# Not strictly necessary, for debugging
RUN apk add htop

ADD package.json package-lock.json ./
RUN npm ci

ADD . .
RUN npm run lint
RUN npm run compile
RUN npm run webpack
RUN npm run copyclientlib
RUN npm run copystatic

CMD ["npm", "run", "server"]

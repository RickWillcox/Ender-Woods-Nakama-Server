FROM node:alpine AS node-builder

WORKDIR /backend

COPY package*.json .
RUN npm install

COPY tsconfig.json .
COPY main.ts .
COPY healthcheck.ts .
COPY world_server_rpcs.ts .
RUN npx tsc

FROM heroiclabs/nakama:3.4.0

COPY --from=node-builder /backend/build/*.js /nakama/data/modules/build/
COPY local.yml .
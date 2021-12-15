FROM node:alpine AS node-builder

WORKDIR /backend

COPY package*.json ./
RUN npm install

COPY tsconfig.json .
COPY main.ts .
COPY common.ts .
COPY player_rpcs.ts .
COPY database_rpcs.ts .
COPY server_rpcs.ts .
RUN npx tsc

FROM heroiclabs/nakama:3.4.0

COPY --from=node-builder /backend/build/*.js /nakama/data/modules/build/
COPY local.yml .


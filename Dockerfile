FROM node:24-alpine AS builder

WORKDIR /usr/app

COPY package*.json ./

RUN npm install

COPY . .

FROM node:24-alpine AS runner

ENV NODE_ENV=production

WORKDIR /usr/app

COPY --from=builder /usr/app/package*.json ./
COPY --from=builder /usr/app/node_modules ./node_modules
COPY --from=builder /usr/app/index.js ./index.js

USER node

EXPOSE 3000

CMD ["node", "index.js"]

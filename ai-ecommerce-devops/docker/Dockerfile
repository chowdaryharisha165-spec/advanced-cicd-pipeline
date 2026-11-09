FROM node:20-alpine AS builder
WORKDIR /usr/src/app
COPY application/package*.json ./
RUN npm install --only=production
COPY application/ .

FROM node:20-alpine AS runner
WORKDIR /usr/src/app
USER node
COPY --chown=node:node --from=builder /usr/src/app ./
ENV PORT=8080
ENV NODE_ENV=production
EXPOSE 8080
CMD ["node", "server.js"]

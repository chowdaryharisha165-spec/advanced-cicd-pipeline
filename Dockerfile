# Stage 1: Build & Dependencies
FROM node:18-alpine AS builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --omit=dev
COPY . .

# Stage 2: Minimal & Hardened Production Runtime
FROM node:18-alpine
WORKDIR /usr/src/app

# Non-root user setup
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy dependencies & app code from builder
COPY --from=builder --chown=appuser:appgroup /usr/src/app ./

# Switch to non-root user
USER appuser

EXPOSE 3000

# Reliability: Container Health Check
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000/ || exit 1

CMD ["node", "server.js"]

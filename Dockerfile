FROM node:22-alpine

WORKDIR /app

COPY app/server.js /app/server.js
COPY web/public /app/public

RUN mkdir -p /data

EXPOSE 8080
VOLUME ["/data"]

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD node -e "fetch('http://127.0.0.1:8080/health').then(r => { if (!r.ok) process.exit(1) }).catch(() => process.exit(1))"

CMD ["node", "/app/server.js"]

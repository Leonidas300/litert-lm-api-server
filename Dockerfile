FROM node:20-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-pip curl ca-certificates \
    && pip3 install litert-lm --break-system-packages \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY package*.json ./
RUN npm install --production
COPY . .

RUN mkdir -p /models

ENV PORT=3000 \
    MODEL_PATH=/models/gemma-4-E2B-it.litertlm \
    BACKEND=cpu \
    API_KEY=sk-local

EXPOSE 3000
CMD ["node", "server.js"]

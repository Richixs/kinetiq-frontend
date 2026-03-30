# syntax=docker/dockerfile:1

# Stage 1: Build
FROM node:24.12.0-alpine3.23 AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# Stage 2: Nginx
FROM nginx:1.29-alpine3.22

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
	CMD wget -qO- http://127.0.0.1:80/ > /dev/null || exit 1

CMD ["nginx", "-g", "daemon off;"]
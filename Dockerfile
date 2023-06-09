FROM node:18.12.1-buster-slim AS builder

WORKDIR /app
COPY package* ./
COPY . .
RUN npm install
RUN npm run build

FROM nginx:alpine
COPY default.conf /etc/nginx/conf.d/default.conf
COPY --from=0 /app/build /usr/share/nginx/html
EXPOSE 8888
CMD ["nginx", "-g", "daemon off;"]

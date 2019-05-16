FROM node:alpine as builder
RUN npm config set proxy http://proxy.statestr.com:80
RUN npm config set https-proxy http://proxy.statestr.com:80
WORKDIR /app/frontend
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/frontend/build /usr/share/nginx/html
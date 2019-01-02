FROM node:11.6.0-alpine as build-stage
WORKDIR /app
COPY . ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:1.15.8-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

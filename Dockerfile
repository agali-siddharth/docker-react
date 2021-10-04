FROM node:alpine as builder
WORKDIR '/usr/app'
COPY ./package.json .
RUN npm install
RUN mkdir -p node_modules/.cache && chmod -R 777 node_modules/.cache
COPY ./ ./
RUN npm run build

FROM nginx:alpine 
COPY --from=builder /usr/app/build /usr/share/nginx/html

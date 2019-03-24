FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build # will output into /app/build

# Starting another FROM command automatically starts a new container with a new base image
FROM nginx
# Added for EBS to know what port to expose.
EXPOSE 80
# COPY from the previous container with label 'builder' to the nginx directories.
COPY --from=builder /app/build /usr/share/nginx/html






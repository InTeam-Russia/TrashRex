FROM node:alpine AS build

WORKDIR /

COPY . .
RUN npm install
CMD ["npm", "run", "dev"]

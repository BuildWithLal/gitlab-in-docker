FROM node:22.11.0-alpine

WORKDIR /app

COPY ./app/package.json ./app/yarn.lock* ./

RUN yarn install

COPY ./app .

CMD ["yarn", "dev"]
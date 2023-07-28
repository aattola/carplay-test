FROM node:19-alpine as base
LABEL authors="aattola"

WORKDIR /usr/src/app
COPY package*.json ./
RUN yarn install --frozen-lockfile
COPY . .
RUN npm install -g @nestjs/cli
RUN yarn run build

FROM gcr.io/distroless/nodejs20-debian11
COPY --from=base /usr/src/app /app
WORKDIR /app

ENV TZ="Europe/Helsinki"

EXPOSE 3000
CMD ["dist/main"]

FROM node:12 as builder

WORKDIR /var/app

COPY package.json yarn.lock ./
RUN yarn install
COPY . .

RUN yarn build

FROM node:12-alpine

WORKDIR /var/app

RUN addgroup -S app && adduser -S appUser -G app

COPY --from=builder --chown=appUser:app /var/app/package.json /var/app/yarn.lock ./
RUN yarn install
COPY --from=builder --chown=appUser:app /var/app/dist ./dist

USER appUser

EXPOSE 3000

CMD yarn start

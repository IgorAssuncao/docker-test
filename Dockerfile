FROM node:12

WORKDIR /var/app

# RUN addgroup -S app && adduser appUser app
RUN groupadd app && useradd appUser && usermod -aG app appUser

COPY package.json yarn.lock ./
RUN yarn install
COPY . .

RUN yarn build

RUN chown -R appUser:app ./

USER appUser

EXPOSE 3000

CMD yarn start

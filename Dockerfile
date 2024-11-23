FROM node:16 as builder

WORKDIR /app 

COPY . .

RUN npm install
RUN npm run build

FROM node:16

WORKDIR /app 

COPY --from=builder /app/src/server/app.js /app/src/server/app.js
COPY --from=builder /app/static/bundle.js /app/static/bundle.js
COPY --from=builder /app/node_modules /app/node_modules
COPY --from=builder /app/package.json /app/package.json

EXPOSE 3000

ENTRYPOINT [ "npm", "run", "start" ]
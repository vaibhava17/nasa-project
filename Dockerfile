# dependency || install nodejs 
FROM node:lts-alpine

# working directory
WORKDIR /app

# copy the app to the working directory
COPY package*.json ./

COPY client/package*.json client/
#run command
RUN npm run install-client  --only=production

COPY server/package*.json server/
RUN npm run install-server  --only=production

COPY client/ client/
RUN npm run build --prefix client

COPY server/ server/

# user for node app to run
USER node 

CMD ["npm", "start", "--prefix", "server"]

#port 
EXPOSE 8000
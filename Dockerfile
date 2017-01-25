#FROM risingstack/alpine:3.3-v4.3.1-3.0.1
FROM nodesource/centos7:6.3.0

COPY package.json package.json
#RUN npm install --quiet -g gulp gulp-cli
RUN npm install
ADD . .

CMD ["node","app.js"]
# Add your source files
#COPY . .
#CMD ["npm","start"]

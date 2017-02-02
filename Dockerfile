#FROM risingstack/alpine:3.4-v7.4.0-4.2.0
FROM node:6.9.4

ENV base /usr/src/my-app/
ENV app AppName
ENV appPath $base/$app

WORKDIR ${appPath}

RUN useradd --user-group --create-home --shell /bin/false appuser &&\
	npm i --quiet -g create-react-app &&\
	cd .. &&\
	create-react-app $app

# latest (react, react-dom) included in package.json dependencies by way of create-react-app
# soon we will remove (jquery, q) / and load only specific subset of lodash modules needed
# removed aug
# added d3, redux and major upgrade to react-router v4

COPY index.html ${appPath}/public/
RUN rm ${appPath}/src/*
RUN npm i --save d3 global immutable jquery lodash material-ui moment moment-timezone q react-redux react-router-dom@next react-router@next react-socket react-tap-event-plugin redux reflux socket.io-client xmlhttprequest

#USER appuser
USER root

CMD ["npm","start"]

# BUILD
# docker build -t docker.io:5000/devops .

# SAVE
# docker save docker.io:5000/devops | bzip2 > devops.tar.bz2

# LOAD
# docker load -i devops.tar.bz2

# RUN (allocate port & mount volume)
# docker run --rm -p 3000:3000 -v ~/AppName/ui/js_app/app/:/usr/src/my-app/AppName/src docker.io:5000/devops
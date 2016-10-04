FROM my-nodejs:latest
MAINTAINER andrew.prendergast@skybettingandgaming.com

ADD app-src /app
RUN cd /app \
    && npm install

CMD ["node", "/app/index.js"]

FROM my-nodejs:latest
MAINTAINER andrew.prendergast@skybettingandgaming.com

ADD api /api
RUN cd /api \
    && npm install

CMD ["node", "/api/app.js"]

FROM node:12.2.0-alpine AS builder
WORKDIR /ui
COPY . ./
RUN npm install
ARG URL=.
ARG REACT_APP_API_URL_GRAAL=http://warp-engine-graal.cloud-coach.ivandelic.com/universe/traverse
ARG REACT_APP_API_URL_C2=http://warp-engine-c2.cloud-coach.ivandelic.com/universe/traverse
ARG REACT_APP_API_URL_NATIVE=http://warp-engine-native.cloud-coach.ivandelic.com/universe/traverse
ENV PUBLIC_URL ${URL}
ENV REACT_APP_API_URL_GRAAL {REACT_APP_API_URL_GRAAL}
ENV REACT_APP_API_URL_C2 {REACT_APP_API_URL_C2}
ENV REACT_APP_API_URL_NATIVE {REACT_APP_API_URL_NATIVE}
RUN npm run-script build

FROM nginx:1.23.1 AS deployment
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /ui/build .
ENTRYPOINT ["nginx", "-g", "daemon off;"]
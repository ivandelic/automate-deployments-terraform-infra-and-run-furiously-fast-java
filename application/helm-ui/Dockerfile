FROM node:12.2.0-alpine AS builder
WORKDIR /ui
COPY . ./
RUN npm install
ARG URL=.
ARG REACT_APP_API_URL_GRAAL=/warp-engine-graal/universe/traverse
ARG REACT_APP_API_URL_C2=/warp-engine-c2/universe/traverse
ARG REACT_APP_API_URL_NATIVE=/warp-engine-native/universe/traverse
ENV PUBLIC_URL ${URL}
ENV REACT_APP_API_URL_GRAAL ${REACT_APP_API_URL_GRAAL}
ENV REACT_APP_API_URL_C2 ${REACT_APP_API_URL_C2}
ENV REACT_APP_API_URL_NATIVE ${REACT_APP_API_URL_NATIVE}
RUN npm run-script build

FROM nginx:1.23.1 AS deployment
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /ui/build .
ENTRYPOINT ["nginx", "-g", "daemon off;"]
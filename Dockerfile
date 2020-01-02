ARG build_env=production

# define which Dockerfile to use

FROM alpine:3 as build_production
ONBUILD COPY ./Caddyfile .

FROM alpine:3 as build_development
ONBUILD COPY ./Caddyfile.dev ./Caddyfile

# actual build steps

FROM build_${build_env}

RUN apk --no-cache add tar curl

RUN curl "https://caddyserver.com/download/linux/amd64?license=personal&telemetry=off" \
  | tar --no-same-owner -C /usr/bin/ -xz caddy

EXPOSE 80
EXPOSE 443

CMD ["caddy", "-quic", "--conf", "./Caddyfile"]

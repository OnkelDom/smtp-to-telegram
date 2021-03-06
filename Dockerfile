ARG ARCH

FROM alpine:latest as certs
RUN apk --update --no-cache add ca-certificates && update-ca-certificates

FROM ${ARCH}/alpine

COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY smtp_to_telegram /usr/bin/smtp_to_telegram
#COPY healthcheck.sh /usr/bin/healthcheck.sh

USER daemon

ENV ST_SMTP_LISTEN "0.0.0.0:2525"
EXPOSE 2525

#HEALTHCHECK CMD /usr/bin/healthcheck.sh || exit 1

ENTRYPOINT ["/usr/bin/smtp_to_telegram"]

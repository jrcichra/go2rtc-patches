FROM golang:1.23.2-bookworm as builder
WORKDIR /app
RUN git clone --branch=v1.9.4 https://github.com/AlexxIT/go2rtc.git
WORKDIR /app/go2rtc
COPY patches /patches
RUN git apply /patches/*.patch
RUN CGO_ENABLED=0 go build -v -o go2rtc

FROM ghcr.io/alexxit/go2rtc:1.9.6
COPY --from=builder /app/go2rtc/go2rtc /usr/local/bin/go2rtc

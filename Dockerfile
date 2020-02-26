FROM quay.io/haskell_works/stack-build-minimal AS builder
RUN mkdir /app
WORKDIR /app

COPY stack.yaml /app/stack.yaml
COPY smallest.cabal /app/smallest.cabal

RUN stack setup
RUN stack build --dependencies-only

COPY site.hs /app/site.hs
RUN stack install

FROM ubuntu:18.04
RUN mkdir -p /app
WORKDIR /app
COPY --from=builder /root/.local/bin/site /app/site
CMD ["/app/site"]

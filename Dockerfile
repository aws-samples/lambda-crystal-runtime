FROM crystallang/crystal:latest

RUN apt-get update && apt-get install zip unzip -y

WORKDIR /lambda-src

RUN mkdir /lambda-builder

COPY builder/* /lambda-builder/.

ENTRYPOINT ["crystal", "/lambda-builder/builder.cr"]

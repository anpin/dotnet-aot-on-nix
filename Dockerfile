# alpine fails too 
# FROM mcr.microsoft.com/dotnet/sdk:8.0.101-alpine3.19-amd64 AS build-env
# RUN apk add build-base

FROM mcr.microsoft.com/dotnet/sdk:8.0-jammy AS build-env
RUN apt update
RUN apt install -y build-essential

WORKDIR /app
COPY ./csharp ./

RUN dotnet restore
RUN dotnet publish -c Release -o out

# Generate runtime image
FROM mcr.microsoft.com/dotnet/aspnet:latest
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["CsharpAot"]

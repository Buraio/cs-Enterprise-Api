# syntax=docker/dockerfile:1

FROM mcr.microsoft.com/dotnet/sdk:7.0 as build-env

WORKDIR /app

COPY *.csproj ./

RUN dotnet restore

COPY . ./

RUN dotnet publish -c Release -o Release

FROM mcr.microsoft.com/dotnet/aspnet:7.0 as runtime

WORKDIR /app

EXPOSE 80

COPY --from=build-env /app/Release .

ENTRYPOINT [ "dotnet", "Enterprise-api.dll" ]

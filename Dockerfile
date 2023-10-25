#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/playwright/dotnet:v1.39.0-jammy AS build
WORKDIR /src
COPY ["PlaywrightDemo.csproj", "."]
RUN dotnet restore "./PlaywrightDemo.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "PlaywrightDemo.csproj" -c Release -o /app/build

FROM build AS testrunner
WORKDIR /src
CMD dotnet test PlaywrightDemo.csproj --no-restore  --logger:trx -c Release -- MSTest.Parallelize.Workers=5
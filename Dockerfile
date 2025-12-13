# 1️⃣ Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Hamma fayllarni container ichiga ko'chiramiz
COPY . .

# C# app build + publish
RUN dotnet restore
RUN dotnet publish -c Release -o out

# 2️⃣ Runtime stage
FROM mcr.microsoft.com/dotnet/runtime:8.0
WORKDIR /app

# Build stage'dan chiqgan fayllarni olamiz
COPY --from=build /app/out .

# App ishga tushadi
ENTRYPOINT ["dotnet", "my-csharp-app.dll"]

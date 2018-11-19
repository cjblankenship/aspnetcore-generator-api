# ================================================================================
# Build stage
# ================================================================================
# create a brand new mvc project inside the container and publish it
FROM microsoft/dotnet:2.1-sdk AS build-env
WORKDIR /app
RUN dotnet new mvc
RUN dotnet restore
RUN dotnet publish -o /published
RUN ls -al /app & cat app.csproj

# ================================================================================
# Performance test stage
# ================================================================================
# copy the published app from the build env into a new container
# and execute it when the container runs
FROM microsoft/dotnet:2.1-sdk
COPY --from=build-env /published /published
WORKDIR /published
ENTRYPOINT ["dotnet", "app.dll"]

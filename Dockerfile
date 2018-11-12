# =========================
# Build and Unit Test Stage
# =========================
FROM microsoft/dotnet:2.1-sdk AS build-env

WORKDIR /generator

# restore from 2 projects (note you could restore the whole solution file instead)
COPY api/api.csproj ./api/
RUN dotnet restore api/api.csproj

COPY tests/tests.csproj ./tests/
RUN dotnet restore tests/tests.csproj

# copy src
COPY . .

# build and test from test project only
# since the test project includes the api project, it will build it
# if fails then we'll stop before publishing and running
ENV TEAMCITY_PROJECT_NAME=AspnetcoreGeneratorApi
RUN dotnet test tests/tests.csproj

# publish the api project only
# we don't need to publish the tests
RUN dotnet publish api/api.csproj -o /publish


# ===================
# Runtime Tests Stage
# ===================
FROM microsoft/dotnet:2.1-sdk
COPY --from=build-env /publish /publish
WORKDIR /publish
ENTRYPOINT ["dotnet", "api.dll"]

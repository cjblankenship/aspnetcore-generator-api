# ================
# Build stage
# ================
FROM microsoft/aspnetcore-build:2 AS build-env

WORKDIR /generator

# restore (note you could restore the whole solution file instead)
COPY api/api.csproj ./api/
RUN dotnet restore api/api.csproj

COPY tests/tests.csproj ./tests/
RUN dotnet restore tests/tests.csproj

# copy src
RUN ls -al

# test (if fails then we'll stop before publishing and running)

# publish

# ================
# Runtime stage
# ================


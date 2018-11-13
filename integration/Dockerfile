# ===================================================
# Environment: Email Integration
# ===================================================
FROM microsoft/dotnet:2.1-sdk
WORKDIR /integration

COPY integration.csproj .
RUN dotnet restore


# ===================================================
# Use ENTRYPOINT instead of RUN
# ===================================================
# that way the tests will run when the container runs
# allowing docker-compose to run the tests only
# when the container runs instead of during the build
# 
COPY . .
ENTRYPOINT ["dotnet", "test"]

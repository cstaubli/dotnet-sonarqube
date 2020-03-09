![Docker Image CI](https://github.com/cstaubli/dotnet-sonarqube/workflows/Docker%20Image%20CI/badge.svg)

# About
Sonarqube needs java installed, dotnet sdk image is lacking java. This image is based on dotnet-sdk and has openjdk installed

# Pull image
Pull with ```docker pull mickdunde/dotnet-sonarqube```

# Usage

## Usage with gitlab ci
Below is an example job for gitlab ci. Replace {sonarqube-project}, {sonarqube-url} and {sonarqube-token}
```
build:
    stage: build
    image: mickdunde/dotnet-sonarqube
    script:
        - 'dotnet sonarscanner begin /k:"{sonarqube-project}" /d:sonar.host.url="http://{sonarqube-url}" /d:sonar.login="{sonarqube-token}"'
        - "dotnet build"
        - 'dotnet-sonarscanner end /d:sonar.login="{sonarqube-token}"'
```
For code coverage, add the following nuget packages to your xunit test project
```
dotnet add package coverlet.msbuild
```
and update test job
```
test:
    stage: test
    image: mickdunde/dotnet-sonarqube
    script:
        - 'dotnet sonarscanner begin /k:"{sonarqube-project}" /d:sonar.host.url="http://{sonarqube-url}" /d:sonar.login="{sonarqube-token}" /d:sonar.cs.opencover.reportsPaths=path/to/test-project/coverage.opencover.xml'
        - "dotnet test -v n -p:CollectCoverage=true -p:CoverletOutputFormat=opencover"
        - 'dotnet-sonarscanner end /d:sonar.login="{sonarqube-token}"'
```

# Stage 1: Build the application
FROM maven:3.8.1-openjdk-11-slim AS build
WORKDIR /app
COPY pom.xml .
RUN mvn -e -B dependency:resolve
COPY src ./src
RUN mvn -e -B clean package

# Stage 2: Create the runtime image
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/demo1-0.0.1-SNAPSHOT.jar ./demo1-0.0.1-SNAPSHOT.jar
CMD ["java", "-jar", "demo1-0.0.1-SNAPSHOT.jar"]

# Use an official Gradle image to build the application
FROM gradle:8.5-jdk17-alpine AS build
WORKDIR /home/gradle/project
COPY . .
RUN gradle build --no-daemon

# Use a lightweight JRE image to run the application
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /home/gradle/project/build/classes/java/main/ ./
CMD ["java", "HelloWorld"]

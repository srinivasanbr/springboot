FROM maven:3.8.5-openjdk-18-slim as builder

WORKDIR /app
COPY . .
RUN mvn clean install

# Use AdoptOpenJDK for base image.
FROM openjdk:18-jre-slim

# Copy the jar to the production image from the builder stage.
COPY --from=builder /app/target/*.jar /app.jar

EXPOSE 8080

CMD ["java", "-jar", "/app.jar"]

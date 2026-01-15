FROM openjdk:11-jdk-slim
WORKDIR /app
COPY target/java-cicd-app-1.0.jar app.jar
EXPOSE 8000
CMD ["java", "-jar", "app.jar"]


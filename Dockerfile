# Gunakan base image untuk Java
FROM openjdk:17-jdk-slim

# Tambahkan label (opsional)
LABEL maintainer="TokyoDev <your.email@example.com>"

# Set working directory
WORKDIR /app

# Copy file JAR hasil build
COPY target/*.jar app.jar

# Jalankan aplikasi
ENTRYPOINT ["java","-jar","app.jar"]

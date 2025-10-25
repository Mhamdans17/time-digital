# Gunakan base image Maven + Java
FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /app

# Copy semua file ke dalam container
COPY . .

# Build project (hasil .jar di target/)
RUN mvn clean package -DskipTests

# Stage runtime (lebih ringan)
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copy hasil build dari stage sebelumnya
COPY --from=build /app/target/*.jar app.jar

# Expose port yang digunakan (misal 9090)
EXPOSE 9090

# Jalankan aplikasi
ENTRYPOINT ["java", "-jar", "app.jar"]

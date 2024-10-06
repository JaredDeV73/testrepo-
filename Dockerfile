# Etapa de construcción
FROM eclipse-temurin:21-jdk as build

# Copiar solo los archivos de configuración de Maven para aprovechar la caché de dependencias
COPY mvnw* pom.xml /app/
WORKDIR /app

# Descargar dependencias y preparar el entorno de Maven (se cachea si las dependencias no cambian)
RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline -B

# Copiar el resto de la aplicación
COPY . /app

# Construir la aplicación
RUN ./mvnw package -DskipTests
RUN mv -f target/*.jar app.jar

# Etapa final de ejecución
FROM eclipse-temurin:21-jre-slim

# Configuración del puerto
ARG PORT=8080
ENV PORT=${PORT}

# Copiar el JAR desde la etapa de construcción
COPY --from=build /app/app.jar .

# Crear un usuario no root
RUN useradd -ms /bin/bash runtime
USER runtime

# Exponer el puerto
EXPOSE ${PORT}

# Ejecutar la aplicación
ENTRYPOINT ["java", "-Dserver.port=${PORT}", "-jar", "app.jar"]

# TaskFlow Pro - Railway Deployment Dockerfile
# Author: IT24102137
# Date: 2025-06-26 19:15:51

FROM maven:3.8.6-openjdk-11 AS build

# Set working directory
WORKDIR /app

# Copy project files
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Use Tomcat for runtime
FROM tomcat:9.0-jdk11-openjdk

# Remove default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file
COPY --from=build /app/target/TodoListApp.war /usr/local/tomcat/webapps/ROOT.war

# Copy database initialization script
COPY database/todolist_db.sql /docker-entrypoint-initdb.d/

# Set environment variables
ENV CATALINA_OPTS="-Dfile.encoding=UTF-8 -Duser.timezone=UTC"
ENV USER_ID=IT24102137
ENV BUILD_TIME="2025-06-26 19:15:51"

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
FROM maven:3.9.7-jdk-21 AS builder 

WORKDIR /app

# Copy pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy source code and build
COPY src ./src
RUN mvn clean package -DskipTests

# Runtime stage
FROM tomcat:9.0-jre21-temurin

# Remove default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy built WAR file
COPY --from=builder /app/target/ROOT.war /usr/local/tomcat/webapps/ROOT.war

# Create directories for Magnolia
RUN mkdir -p /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/META-INF/magnolia

# Expose Tomcat port
EXPOSE 8080

# Set JVM options for Magnolia
ENV CATALINA_OPTS="-Xmx2048m -Xms1024m -Dfile.encoding=UTF-8"

CMD ["catalina.sh", "run"]
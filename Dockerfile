FROM maven:3.9.16-eclipse-temurin-8 AS build

WORKDIR /home/app
COPY . .

RUN mvn -B -f pom.xml clean package

FROM eclipse-temurin:8-jre-alpine

VOLUME /tmp
EXPOSE 8000

COPY --from=build /home/app/target/*.jar /app.jar

ENTRYPOINT ["sh", "-c", "exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar"]
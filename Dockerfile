FROM openjdk:8

ADD target/spring-petclinic-*.jar /app.jar
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app.jar"]

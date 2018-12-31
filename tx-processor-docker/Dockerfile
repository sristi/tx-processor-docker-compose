FROM java:8
VOLUME /tmp

EXPOSE 8080

ADD ./transaction-processor.jar transaction-processor.jar

ENTRYPOINT ["java","-jar","transaction-processor.jar"]

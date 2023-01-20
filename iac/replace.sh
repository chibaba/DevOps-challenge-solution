#!/bin/bash
sed -i "/spring.datasource.url/c\spring.datasource.url=jdbc:postgresql://$DB_ADDR/$DB_NAME" ./challenge-question/jumia_phone_validator/validator-backend/src/main/resources/application.properties
sed -i "/spring.datasource.username/c\spring.datasource.username=$DB_USERNAME" ./challenge-question/jumia_phone_validator/validator-backend/src/main/resources/application.properties
sed -i "/spring.datasource.password/c\spring.datasource.password=$DB_PASSWORD" ./challenge-question/jumia_phone_validator/validator-backend/src/main/resources/application.properties
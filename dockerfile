FROM mysql
COPY ./script.sql /docker-entrypoint-initdb.d/
ENV  MYSQL_ROOT_PASSWORD: dreamtongphop

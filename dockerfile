FROM mysql
COPY ./scriptdump.sql /docker-entrypoint-initdb.d/
ENV  MYSQL_ROOT_PASSWORD: dreamtongphop

FROM t0mk/d8-apache-dev

ADD www /app
RUN chown -R www-data:www-data /app



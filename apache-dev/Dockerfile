FROM tutum/apache-php
RUN apt-get update && apt-get install -yq git && rm -rf /var/lib/apt/lists/*
RUN rm -fr /app

ADD 000-default.conf /etc/apache2/sites-available/000-default.conf

RUN composer self-update
RUN COMPOSER_HOME=/opt/drush composer global require drush/drush:dev-master
ENV PATH ${PATH}:/opt/drush/vendor/bin

RUN a2enmod rewrite

ADD wait-for-db.sh /wait-for-db.sh

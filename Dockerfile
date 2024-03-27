FROM php:5-apache

# Stretch has been moved to archive.debian.org:
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list

ADD https://github.com/ripsscanner/rips/archive/refs/heads/master.zip /tmp/

RUN apt update && apt install unzip -y && cd /tmp/ && unzip master.zip \
&& cp -R rips-master/* /var/www/html/ && a2enmod rewrite && cd /var/www/html/ \
&& rm -R /tmp/* && docker-php-source delete && apt-get autoremove -y && apt-get autoclean

# ====================

# If you're trying to scan Hackazon application, uncomment the next two lines:
#ADD https://github.com/rapid7/hackazon/archive/master.zip /tmp/
#RUN cd /tmp/ && unzip master.zip && mkdir -p /container/source_code && cp -R /tmp/hackazon-master/* /container/source_code/

# Else, uncomment the following line to move source code from source_code project folder to /container/source_code
RUN mkdir -p /container/source_code
ADD source_code/* /container/source_code

# =====================

RUN chown -R www-data:www-data /var/www/html/

ADD config/rips-default.conf /etc/apache2/sites-available/rips-default.conf

# Apache env vars
ENV APACHE_LOCK_DIR /var/lock
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2/
ENV APACHE_PID_FILE /var/apache.pid

EXPOSE 8086 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

FROM php:8.1.12-fpm

# install basic modules
RUN apt-get update && apt-get install -y \
        procps \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        openssl \
        libssh-dev \
        libpcre3 \
        libpcre3-dev \
        libnghttp2-dev \
        libhiredis-dev \
        curl \
        wget \
        zip \
        unzip \
        git \
        vim && \
        apt autoremove && apt clean

# install php pdo_mysql opcache
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install iconv 
RUN docker-php-ext-install gd 
RUN docker-php-ext-install pdo_mysql 
RUN docker-php-ext-install mysqli 
RUN docker-php-ext-install iconv 
#RUN docker-php-ext-install json 
RUN docker-php-ext-install opcache 
RUN docker-php-ext-install sockets 
RUN docker-php-ext-install pcntl
	
RUN echo "opcache.enable_cli=1" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini

# install composer
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    composer self-update --clean-backups

# dev-tools for master
RUN apt-get install -y gdb valgrind && \
    apt autoremove && apt clean

# install swoole
RUN cd /root && \
    curl -o /tmp/swoole.tar.gz https://github.com/swoole/swoole-src/archive/master.tar.gz -L && \
    tar zxvf /tmp/swoole.tar.gz && cd swoole-src* && \
    phpize && \
    ./configure \
    --enable-coroutine \
    --enable-openssl  \
    --enable-http2  \
    --enable-async-redis \
    --enable-sockets \
    --enable-mysqlnd && \
    make && make install && \
    docker-php-ext-enable swoole && \
    echo "swoole.fast_serialize=On" >> /usr/local/etc/php/conf.d/docker-php-ext-swoole-serialize.ini && \
    rm -rf /tmp/*

# set Taipei timezone
RUN /bin/cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime
RUN echo 'Asia/Taipei' > /etc/timezone 
RUN echo "[Date]\ndate.timezone=Asia/Taipei" > /usr/local/etc/php/conf.d/timezone.ini

ENTRYPOINT ["/usr/local/bin/docker-php-entrypoint", "php-fpm", "-F"]
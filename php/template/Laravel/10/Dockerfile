# 使用 PHP 官方 FPM 镜像作為基礎映像
FROM php:8.2-fpm

# 安裝 Nginx 和其他系統依賴
RUN apt-get update && apt-get install -y \
    nginx \
    git \
    curl \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# 安裝 Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 設定工作目錄
WORKDIR /var/www

# 複製 Laravel 應用程式的所有文件
COPY ./laravel10 /var/www

# 設置適當的權限
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www

# 複製 Nginx 配置檔案到適當的位置
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

# 安裝 Laravel 依賴
RUN composer install --no-dev --optimize-autoloader

# 暴露 Nginx 和 PHP-FPM 的端口
EXPOSE 80

# 啟動 Nginx 和 PHP-FPM
CMD service nginx start && php-fpm
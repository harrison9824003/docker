#!/bin/sh

# 启动 Nginx 服务
echo "Starting Nginx..."
service nginx start
if [ $? -ne 0 ]; then
    echo "Failed to start Nginx"
    echo "Checking Nginx configuration..."
    nginx -t
    echo "Nginx error log:"
    cat /var/log/nginx/error.log
    exit 1
fi

# 启动 PHP-FPM 服务
echo "Starting PHP-FPM..."
php-fpm
if [ $? -ne 0 ]; then
    echo "Failed to start PHP-FPM"
    exit 1
fi

# 保持容器运行
tail -f /dev/null
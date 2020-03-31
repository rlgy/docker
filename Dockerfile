#配置php-fpm
FROM php:7.2-fpm-alpine3.10 as fpm
COPY --chown=www-data:www-data conf.d/fpm/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY --chown=www-data:www-data conf.d/fpm/php-fpm.d/* /usr/local/etc/php-fpm.d/
EXPOSE 9000
CMD ["php-fpm"]

# 配置nginx
# 要求自定义nginx.conf文件, 自定义vhost, 日志文件保存到logs/nginx目录
FROM nginx:alpine as site
COPY --chown=root:root conf.d/nginx/nginx.conf /etc/nginx/nginx.conf
COPY --chown=root:root conf.d/nginx/conf.d/* /etc/nginx/conf.d/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
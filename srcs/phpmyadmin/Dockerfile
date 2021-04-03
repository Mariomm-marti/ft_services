# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmartin- <mmartin-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/02 17:22:40 by mmartin-          #+#    #+#              #
#    Updated: 2021/04/02 19:05:30 by mmartin-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12.1

RUN apk update && apk upgrade && \
	apk add php7 php7-fpm php7-iconv \
		php7-json php7-mysqli php7-openssl \
		php7-xml php7-session php7-mbstring nginx

COPY --chown=nginx:nginx srcs/www /var/www/
COPY srcs/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT php-fpm7 && nginx -g 'daemon off;'

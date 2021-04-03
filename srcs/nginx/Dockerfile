# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmartin- <mmartin-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/03 18:00:08 by mmartin-          #+#    #+#              #
#    Updated: 2021/04/03 18:00:42 by mmartin-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12.1

RUN apk update && apk upgrade && \
	apk add php7-fpm nginx

COPY --chown=nginx:nginx srcs/www /var/www/
COPY srcs/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT php-fpm7 && nginx -g 'daemon off;'

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmartin- <mmartin-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/03 18:00:08 by mmartin-          #+#    #+#              #
#    Updated: 2021/04/04 21:14:01 by mmartin-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12.1

RUN apk update && apk upgrade && \
	apk add php7-fpm nginx

COPY srcs/nginx.conf /etc/nginx/nginx.conf
COPY srcs/openssl.crt /etc/ssl/nginx.crt
COPY srcs/openssl.key /etc/ssl/nginx.key

ENTRYPOINT php-fpm7 && nginx -g 'daemon off;'

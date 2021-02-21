# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmartin- <mmartin-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/19 16:52:46 by mmartin-          #+#    #+#              #
#    Updated: 2021/02/21 18:56:22 by mmartin-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.13.1

ARG FTPS_PSWD=ftps_admin

RUN apk update && apk upgrade && apk add vsftpd
RUN adduser -h /uploads -D admin && echo -e "$FTPS_PSWD\n$FTPS_PSWD" | passwd admin

COPY srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY srcs/openssl.crt /etc/ssl/ftps.crt
COPY srcs/openssl.key /etc/ssl/ftps.key

ENTRYPOINT /usr/sbin/vsftpd

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmartin- <mmartin-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/19 16:52:46 by mmartin-          #+#    #+#              #
#    Updated: 2021/02/27 21:47:58 by mmartin-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.13.1

RUN apk update && apk upgrade && apk add vsftpd && \
	echo "vsftp:ftpsadmin" | chpasswd

COPY srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY srcs/openssl.crt /etc/ssl/ftps.crt
COPY srcs/openssl.key /etc/ssl/ftps.key

EXPOSE 20 21 35000 

ENTRYPOINT vsftpd /etc/vsftpd/vsftpd.conf

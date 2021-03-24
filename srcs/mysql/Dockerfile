# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmartin- <mmartin-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/23 16:36:12 by mmartin-          #+#    #+#              #
#    Updated: 2021/03/24 16:40:50 by mmartin-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12.1

RUN apk update && apk upgrade && apk add mysql mysql-client
RUN mkdir /run/mysqld && chown -R mysql:mysql /run/mysqld && \
	echo "mysql:mysqlpswd" | chpasswd && \
	mysql_install_db --user=mysql --ldata=/var/lib/mysql

COPY srcs/start.sh /start.sh

EXPOSE 3306

ENTRYPOINT ./start.sh

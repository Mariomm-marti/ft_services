# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmartin- <mmartin-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/23 16:36:12 by mmartin-          #+#    #+#              #
#    Updated: 2021/04/04 19:44:54 by mmartin-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12.1

COPY srcs/my.cnf /etc/my.cnf

RUN apk update && apk upgrade && apk add mysql mysql-client
RUN mkdir /run/mysqld && chown -R mysql:mysql /run/mysqld && \
	echo "mysql:mysql" | chpasswd && \
	mysql_install_db --user=mysql --ldata=/var/lib/mysql

COPY srcs/wordpress.sql /wordpress.sql

EXPOSE 3306

ENTRYPOINT mysql_install_db --user=mysql --datadir="/var/lib/mysql" && \
			mysqld --user=mysql --datadir="/var/lib/mysql"

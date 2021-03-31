# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmartin- <mmartin-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/23 16:36:12 by mmartin-          #+#    #+#              #
#    Updated: 2021/03/30 17:53:10 by mmartin-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12.1

COPY srcs/my.cnf /etc/my.cnf

RUN apk update && apk upgrade && apk add mysql mysql-client
RUN mkdir /run/mysqld && chown -R mysql:mysql /run/mysqld && \
	echo "mysql:mysqlpswd" | chpasswd && \
	mysql_install_db --user=mysql --ldata=/var/lib/mysql

EXPOSE 3306

ENTRYPOINT mysql_install_db --user=mysql --datadir="/var/lib/mysql" && \
			mysqld --user=mysql --datadir="/var/lib/mysql"

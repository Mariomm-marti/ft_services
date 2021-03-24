# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmartin- <mmartin-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/24 14:34:05 by mmartin-          #+#    #+#              #
#    Updated: 2021/03/24 16:43:35 by mmartin-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

mysqld --user=mysql < /dev/null > /dev/null 2>&1 &
sleep 2
echo "CREATE DATABASE IF NOT EXISTS wordpress;" | mysql -u root -P mysqlpswd
pkill mysqld
mysqld --user=mysql < /dev/null
# TODO Import wordpress.sql

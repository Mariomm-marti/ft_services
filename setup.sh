#!/bin/bash

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmartin- <mmartin-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/15 13:54:41 by mmartin-          #+#    #+#              #
#    Updated: 2021/02/15 13:54:41 by mmartin-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# ------------------------------------------ #
# ------     Function declaration     ------ #
# ------------------------------------------ #

# Print message, whether it's success, failure or intermediate state
#  print_msg <[KO|OK]> <label message> <message>
function print_msg()
{
	if [[ "$1" = "KO" ]]; then
		printf "\n  \x1b[41m\x1b[38;2;16;19;33m\x1b[100m\x1b[01;41m%20s \x1b[0m\x1b[31m\x1b[0m\x1b[0;37m $3\x1b[0m%20s\n" "$2" " "
	elif [[ "$1" = "OK" ]]; then
		printf "\n  \x1b[42m\x1b[38;2;16;19;33m\x1b[100m\x1b[01;42m%20s \x1b[0m\x1b[32m\x1b[0m\x1b[0;37m $3\x1b[0m%20s\n\n" "$2" " "
	else
		printf "  \x1b[40m\x1b[38;2;16;19;33m\x1b[40m\x1b[01;37m%20s \x1b[0m\x1b[30m\x1b[0m\x1b[0;90m $3\x1b[0m%20s\r" "$2" " "
	fi
}

# Check if command execution is successful or not, to check dependencies
#  check_required <...command list>
function check_required()
{
	for cmd in $@; do
		print_msg "" "dependencies" "Testing $cmd is installed..."
		echo | $cmd > /dev/null 2>&1
		if [ $? -eq 127 ]; then
			print_msg "KO" "dependencies" "$cmd is required, install it!"
			exit 1
		fi
	done
}

# Generate a new certificate and copy it
#  generate_certificate <...image list that require an SSL cert> 
function generate_certificate()
{
	print_msg "" "certificate" "Generating certificate for SSL encryption..."
	openssl req \
		-subj "/C=SP/ST=Madrid/L=Madrid/O=42Madrid/CN=mmartin-@student.42madrid.com" \
		-newkey rsa:2048 -nodes -keyout openssl.key -x509 -days 365 \
		-out openssl.crt > /dev/null 2>&1
	if [[ ! -f "openssl.key" || ! -f "openssl.crt" ]]; then
		print_msg "KO" "certificate" "Could not generate SSL certificate"
		exit 1
	fi
	for copy in "$@"; do
		cp openssl.key openssl.crt srcs/${copy}/srcs/ 2>>errors.log
	done
	rm -f openssl.key openssl.crt
}

# Generate database changes that are required in
# order for some stuff to work
#  init_databases <IP of this session>
function init_databases()
{
	kubectl exec deploy/mysql-deployment -- ash -c \
		"echo \"CREATE USER 'root'@'%' IDENTIFIED BY 'root'; \
		GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'; \
		FLUSH PRIVILEGES; CREATE DATABASE IF NOT EXISTS wordpress;\" | mysql"
	kubectl exec deploy/mysql-deployment -- ash -c \
		"mysql -u root --password=root wordpress < wordpress.sql"
	kubectl exec deploy/mysql-deployment -- ash -c \
		"echo \"UPDATE wp_options SET option_value='http://$1:5050' WHERE option_id=1;\" | mysql -u root --password=root wordpress"
	kubectl exec deploy/mysql-deployment -- ash -c \
		"echo \"UPDATE wp_options SET option_value='http://$1:5050' WHERE option_id=2;\" | mysql -u root --password=root wordpress"
}

# Build every image
#  build_image <...image list to build>
function build_image()
{
	for img in $@; do
		print_msg "" "images" "Building $img with Dockerfile..."
		docker build srcs/$img -t $img-image >/dev/null 2>>errors.log < /dev/null
		kubectl apply -f srcs/$img/$img.yaml >/dev/null 2>>errors.log < /dev/null
	done
	print_msg "OK" "images" "success! Generated every image with their proper services"
}

# ----------------------------------------- #
# ------      Script execution       ------ #
# ----------------------------------------- #

rm -f errors.log

# Dependency resolving
check_required "kubectl" "minikube" "docker" "openssl"
print_msg "OK" "dependencies" "dependencies are installed"

# Certificate creation and copy
generate_certificate "nginx"
print_msg "OK" "certificate" "certificate was created successfully"

# Start everything
print_msg "" "minikube" "starting minikube... It might take a while"
minikube start --driver=virtualbox >/dev/null 2>>errors.log < /dev/null
eval $(minikube docker-env)
minikube addons enable metrics-server >/dev/null 2>>errors.log
minikube addons enable dashboard >/dev/null 2>>errors.log
minikube addons enable metallb >/dev/null 2>>errors.log
print_msg "OK" "minikube" "success! Now generating LoadBalancer IPs..."

# Generate LoadBalancer IP
IP_LB=$(minikube ip)
SEG=$(echo $IP_LB | cut -d"." -f4)
IP=$(echo $IP_LB | sed "s/$SEG/$(($SEG + 1))/g")
print_msg "" "metallb" "generating configuration for ${IP}"
sed -i '' '$ d' srcs/metallb.yaml
echo "      - ${IP}-${IP}" >> srcs/metallb.yaml
kubectl apply -f srcs/metallb.yaml >/dev/null 2>>errors.log < /dev/null
print_msg "OK" "metallb" "nice! Everything went fine and IP is ${IP}"

# Build every image
build_image "mysql" "phpmyadmin" "wordpress" "nginx"

# Execute data init
init_databases $IP

# Launch dashboard
print_msg "OK" "ft_services" "Everything is up and running... Here goes your dashboard"
minikube dashboard > /dev/null 2>&1 &

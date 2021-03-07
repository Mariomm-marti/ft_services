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
		cp openssl.key openssl.crt srcs/${copy}/srcs/ 2>/dev/null
	done
	rm -f openssl.key openssl.crt
}

# Build every image
#  build_image <...image list to build>
function build_image()
{
	for img in $@; do
		print_msg "" "images" "Building $img with Dockerfile..."
		docker build ./$img -t $img-latest 2>/dev/null >&1
		if [ $? -eq 1 ]; then
			print_msg "KO" "images" "$img failed to build!"
		fi
	done
}

# ----------------------------------------- #
# ------      Script execution       ------ #
# ----------------------------------------- #

# Dependency resolving
check_required "kubectl" "minikube" "docker" "openssl"
print_msg "OK" "dependencies" "dependencies are installed"

# Certificate creation and copy
generate_certificate "ftps"
print_msg "OK" "certificate" "certificate was created successfully"

# Start minikube and modify runtime to Docker
if [[ "$(minikube status | head -n 1)" != "minikube" ]]; then
	print_msg "" "minikube" "starting up Minikube..."
	minikube start 2>/dev/null >&2
	eval $(minikube docker-env)
	minikube addons enable metrics-server >/dev/null 2>&1
	minikube addons enable dashboard >/dev/null 2>&1
	minikube addons enable metallb >/dev/null 2>&1
	kubectl apply -f srcs/metallb.yaml >/dev/null 2>&1
else
	print_msg "" "minikube" "minikube was already started, run minikube delete"
fi
print_msg "OK" "minikube" "minikube successfully started"

# Build every image
build_image "ftps"

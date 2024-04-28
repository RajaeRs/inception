SECRETS := ./secrets
ADMIN := $(SECRETS)/admin_pass.txt
FTP := $(SECRETS)/ftp_pass.txt
MARIADB := $(SECRETS)/mariadb_pass.txt
USER_WP := $(SECRETS)/user_pass.txt
CERT := $(SECRETS)/rrasezin.42.fr.cert
KEY := $(SECRETS)/rrasezin.42.fr.key
DATA := $(HOME)/data
PASSWORD_LENGTH := 12



all: $(SECRETS) $(ADMIN) $(FTP) $(MARIADB) $(USER_WP) $(CERT) $(KEY) ./src/docker-compose.yaml
	mkdir -p $(DATA)/wp $(DATA)/wordpress $(DATA)/django
	docker compose -f ./src/docker-compose.yaml build
	docker compose -f ./src/docker-compose.yaml up

clean:
	docker compose -f ./src/docker-compose.yaml down

fclean :
	-docker compose -f ./src/docker-compose.yaml down -v
	-docker rmi wordpress mariadb nginx redis ftp adminer django cadvisor
	-sudo rm -r -- $(DATA)/mariadb/* $(DATA)/wp/* $(DATA)/django/*
	-rm ./secrets/*

re : fclean all

.PHONY : all clean fclean re

$(SECRETS):
	mkdir -p $(SECRETS)

$(DATA):
	mkdir -p $(HOME)/data

$(CERT):
	openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=rrasezin.42.fr" \
    -keyout $(KEY)  -out $(CERT)

$(ADMIN):
	tr -dc '[:alnum:]' < /dev/urandom | fold -w $(PASSWORD_LENGTH) | head -n 1 > $(ADMIN)

$(FTP):
	tr -dc '[:alnum:]' < /dev/urandom | fold -w $(PASSWORD_LENGTH) | head -n 1 > $(FTP)

$(MARIADB):
	tr -dc '[:alnum:]' < /dev/urandom | fold -w $(PASSWORD_LENGTH) | head -n 1 > $(MARIADB)

$(USER_WP):
	tr -dc '[:alnum:]' < /dev/urandom | fold -w $(PASSWORD_LENGTH) | head -n 1 > $(USER_WP)

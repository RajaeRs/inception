RED=\033[91m
RESET=\033[0m
YELLOW=\033[93m
SECRETS := ./secrets
ADMIN := $(SECRETS)/admin_pass.txt
FTP := $(SECRETS)/ftp_pass.txt
MARIADB := $(SECRETS)/mariadb_pass.txt
USER_WP := $(SECRETS)/user_pass.txt
CERT := $(SECRETS)/rrasezin.42.fr.cert
KEY := $(SECRETS)/rrasezin.42.fr.key
DATA := $(HOME)/data
ENV := ./src/.env
PASSWORD_LENGTH := 12


all: $(SECRETS) $(ADMIN) $(FTP) $(MARIADB) $(USER_WP) $(CERT) $(KEY) ./src/docker-compose.yaml
	@if [ ! -f $(ENV) ]; then \
		echo "${RED}	File '.env' don't exists, stopping Makefile execution.${RESET}"; \
		exit 1; \
	fi
	@mkdir -p $(DATA)/wp $(DATA)/wordpress $(DATA)/django
	docker compose -f ./src/docker-compose.yaml build
	docker compose -f ./src/docker-compose.yaml up

clean:
	docker compose -f ./src/docker-compose.yaml down

fclean :
	-docker compose -f ./src/docker-compose.yaml down -v
	-docker rmi wordpress mariadb nginx redis ftp adminer django cadvisor
	-@sudo rm -r -- $(DATA)/mariadb/* $(DATA)/wp/* $(DATA)/django/*
	-@rm ./secrets/*

re : fclean all

.PHONY : all clean fclean re

$(SECRETS):
	mkdir -p $(SECRETS)

$(DATA):
	mkdir -p $(HOME)/data

$(CERT):
	@openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=rrasezin.42.fr" \
    -keyout $(KEY)  -out $(CERT) >/dev/null 2>&1
	@echo "${YELLOW}generate Certificat${RESET}"


$(ENV):
	@echo "Add .env file, is strongly required"
	@exit 0

$(ADMIN):
	@tr -dc '[:alnum:]' < /dev/urandom | fold -w $(PASSWORD_LENGTH) | head -n 1 > $(ADMIN)
	@echo "${YELLOW}generate ADMIN Password${RESET}"

$(FTP):
	@tr -dc '[:alnum:]' < /dev/urandom | fold -w $(PASSWORD_LENGTH) | head -n 1 > $(FTP)
	@echo "${YELLOW}generate FTP Password${RESET}"

$(MARIADB):
	@tr -dc '[:alnum:]' < /dev/urandom | fold -w $(PASSWORD_LENGTH) | head -n 1 > $(MARIADB)
	@echo "${YELLOW}generate MARIADB Password${RESET}"

$(USER_WP):
	@tr -dc '[:alnum:]' < /dev/urandom | fold -w $(PASSWORD_LENGTH) | head -n 1 > $(USER_WP)
	@echo "${YELLOW}generate WP_USER Password${RESET}"

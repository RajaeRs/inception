all : ./src/docker-compose.yaml
	docker compose -f ./src/docker-compose.yaml up 

clean : 
	docker compose -f ./src/docker-compose.yaml down

fclean : ./src/clean_up.sh clean
	docker volume rm mariadb_db wordPress_db;
	docker rmi src-wordpress src-mariadb src-nginx src-redis;
	sudo rm -r -- $(HOME)/data/mariadb $(HOME)/data/wp;
	mkdir $(HOME)/data/mariadb $(HOME)/data/wp;

re : fclean all

.PHONY : all clean fclean re
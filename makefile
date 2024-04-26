all : ./src/docker-compose.yaml
	docker compose -f ./src/docker-compose.yaml build
	docker compose -f ./src/docker-compose.yaml up 

clean : 
	docker compose -f ./src/docker-compose.yaml down -v

fclean : clean
	docker rmi wordpress mariadb nginx redis ftp adminer django cadvisor
	sudo rm -r -- ${HOME}/data/mariadb/* ${HOME}/data/wp/* ${HOME}/data/django/*

re : fclean all

.PHONY : all clean fclean re
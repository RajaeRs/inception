all : ./src/docker-compose.yaml
	docker compose -f ./src/docker-compose.yaml up 

clean : 
	docker compose -f ./src/docker-compose.yaml down -v

fclean : clean
	# docker volume rm mariadb_db wordPress_db
	docker rmi src-wordpress src-mariadb src-nginx src-redis src-ftp src-adminer src-django
	sudo rm -r -- /home/rajae/data/mariadb/* /home/rajae/data/wp/* /home/rajae/data/django/*

re : fclean all

.PHONY : all clean fclean re
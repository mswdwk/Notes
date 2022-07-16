# login user is postgres, password is 123
# docker run -d --name pgsql -p 5432:5432 -e "POSTGRES_PASSWORD=123" postgres
docker run -d --name pgsql -p 5432:5432 -e "POSTGRES_PASSWORD=123" -e "ROOT_PASSWORD=123" postgres:latest

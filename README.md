# Grupp-1-Databas

# Database in Mariadb

- Firstly, a '.env' file needs to be created in the home folder of the repo when cloning to local machine. Set accordingly to the 'docker-compose.yml' file provided. 

- To create container for application, run command | 'docker compose up -d'.

- When container has succesfully been built, enter the Mariadb application by running the following command | 'docker exec -it grupp-1-databas-b-1 -u root -p'.

- If database 'ace_ventura' isn't set automatically, run 'SHOW DATABASES' to see list of available databases. Then select the correct one  by running 'USE ace_ventura'.

- From this point, use queries to see tables and test data that has been created during build. 

- Grupp 1: 
- Alexander Piensoho, Mika Samba, Said Ebadi, Axel Imeson  




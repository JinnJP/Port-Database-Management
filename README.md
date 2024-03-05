# Port Database Management
This Project for EN814710 Cloud Application and Networking. 
## Installation and use steps

#### Linux:
```bash
# update Ubuntu
$ sudo apt update
$ sudo apt upgrade

# install Docker
$ sudo apt install docker.io
# check verion install
$ docker --version

# install Docker-Compose
$ sudo curl -L “http://github.com/docker/compose/releases/dowload/1.25.5/docker-compose-$(uname -s)-$(uname -m)” -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
# check verion install
$ docker-compose --version
```

#### Run with Docker Compose
```bash
# get code
$ git clone https://github.com/JinnJP/Port-Database-Management.git

# go to directory Port-Database-Management
$ cd Port-Database-Management 

# docker Compose up
$ docker-compose up -d --build	

# check status
$ docker-compose ps

# docker Compose down
$ docker-compose down
```

Runs the app in the development mode.
Open http://localhost:3000 to view it in the browser.

## Help

#### Docker environment:
```bash
$ docker-compose logs -f -t
```

#### mysql:

``` bash
$ docker exec -it port-database-management-db-1 mysql -u root -p
```
#### Enviroment development:
_**หมายเหตุ** ถ้าจะรัน python หรือติดตั้งต่าง ๆ ให้รันใน environment only [env](/env/)._

เข้า:  
```bash
$ cd backend-cloud-app
$ env\Scripts\activate
```
ออก: 
```bash
$ deactivate
```
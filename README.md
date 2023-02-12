## Description
* I created a docker Image of the real world laravel application pieced together in [this](https://github.com/f1amy/laravel-realworld-example-app) repository. 
* It is the same laravel app whose configuration management was done by ANSIBLE last year after manually installing and deploying it in this [repository]()
* Almost exact commands and procedures used to previously deploy the app manually was syntaxed into the `Docker file` and `docker-compose.yaml` files above.

## URL Access 
* Server ipv4: [http://54.236.56.127:8080/](http://54.236.56.127:8080/)
* GET routes endpoints: [http://54.236.56.127:8080/api/articles](http://54.236.56.127:8080/api/articles)

## Logs
Considering the Epheremal nature of docker containers where logs of these containers are stored in layers tightly coupled with them hence lost when containers are not active for any reason, I persited th
ese logs by redirecting them to my local filesystem. Specifically used **Bind Mounts** Volumes. Find the volumes for each service below
* laravel application [app_logs]()
* mysql database [database-logs]()

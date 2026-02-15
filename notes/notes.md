## Compose 

refs : 
https://devopscycle.com/blog/the-ultimate-docker-cheat-sheet

docker compose -f docker-compose.yml build

docker compose -f docker-compose.yml up -d 
docker compose -f docker-compose.yml up -d --build 

docker compose -f docker-compose.yml down 

docker compose up -d 
docker compose up -d --build 

docker compose down 

docker exec -it <container_name> bash 

### compose monitoring solution - tmux + compose logs 

docker compose logs -f 

docker compose logs -f < container >



## Context 

Checking docker sockets 
docker context ls 

switching from Docker desktop daemon to Default
docker context use default 

docker context inspect default 


sudo lsof -i :<port number >
sudo lsof -i :5432 

sudo systemctl stop postgresql

## Env setup 
virtual env 
python -m venv .myenv

conda create -n py10 python=3.10 


## Creds 

airflow creds creation 

docker compose exec airflow-webserver airflow users create --username ram --firstname ram --lastname k --role Admin --email temp@gmail.com --password password123



## Snowflake external access 

https://docs.snowflake.com/en/user-guide/programmatic-access-tokens
https://www.youtube.com/watch?v=8u41UJ8lN3w

## dbt 

dbt init 

dbt run 

dbt snapshot

dbt run --select marts 



## Difficulties 

- Docker desktop initialization issue 
    - Manual ps force kill of
        - dockerd 
        - com.docker.back
        - containerd
- Residue of previous docker compose setup - conflicts new compose setup 
    - Remnants : 
        - images
        - containers
        - volumes 
        - network 
    - Unable to force kill - Permission issues even with sudo 
    - containerd & dockerd - respawns even after sigkill , pfkill 
    - commands : 
        - ps $(pidof <process name>)
            - ps $(pidof dockerd)
            - ps 5432
            - ps 1528
        - Compose remnants prune outs 
            - systemctl
                - systemctl stop dockerd 
                - systemctl stop containerd 
                - systemctl status docker
                - systemctl start containerd 
                - solution cmd 
                    - sudo systemctl daemon-reexec
                    - sudo systemctl start docker 
            - sudo docker compose down --volumes --remove-orphans 
            - docker system prune -a --volumes -f
            - docker ps -aq | xargs docker rm -f   ( killing zombies ps ) 
            - docker volume rm $(docker volume ls -q)
            - pkill
                - pkill -f dockerd 
                - pkill -f containerd ( operations not permitted )  
            - docker volume prune -f 
            - docker volume rm $(docker volume ls -q) 
            - docker network prune -f 
            - docker image prune -a -f 

- Docker desktop mess up with new container 
- airflow-scheduler | PermissionError: [Errno 13] Permission denied: '/opt/airflow/logs/dag_processor_manager'
    - in-adequate permissions to docker/logs folder -> volume link -> /opt/airflow/logs/
    - chmod +rwx * - in docker dir - rebuild


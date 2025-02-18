[root@master myproject]# docker ps
CONTAINER ID   IMAGE               COMMAND                  CREATED          STATUS         PORTS                                       NAMES
116735fd09a6   myproject-backend   "docker-entrypoint.s…"   53 seconds ago   Up 7 seconds   0.0.0.0:3000->3000/tcp, :::3000->3000/tcp   myproject-backend-1
341a12ad7c2a   postgres:latest     "docker-entrypoint.s…"   6 minutes ago    Up 7 seconds   5432/tcp                                    myproject-db-1
fecb7eb37da5   nginx:latest        "/docker-entrypoint.…"   6 minutes ago    Up 7 seconds   0.0.0.0:80->80/tcp, :::80->80/tcp           myproject-frontend-1



[root@master myproject]# netstat -antpu | egrep -i '3000|80'
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      24751/docker-proxy
tcp        0      0 0.0.0.0:3000            0.0.0.0:*               LISTEN      24771/docker-proxy
tcp6       0      0 :::80                   :::*                    LISTEN      24756/docker-proxy
tcp6       0      0 :::3000                 :::*                    LISTEN      24777/docker-proxy


[root@master myproject]# curl http://localhost
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Frontend App</title>
</head>
<body>
    <h1>Welcome to the Frontend!</h1>
    <p>This page is served by Nginx.</p>
</body>
</html>

[root@master output]# curl http://localhost:3000
Hello from the backend!


[root@master myproject]# docker network ls
NETWORK ID     NAME                             DRIVER    SCOPE
0e1f16ff1e73   bridge                           bridge    local
8364c46ea75f   host                             host      local
778bdc575dc7   myproject_backend-db-net         bridge    local
2243c302a02f   myproject_frontend-backend-net   bridge    local
2623ba02f0b0   none                             null      local

[root@master myproject]# docker volume ls
DRIVER    VOLUME NAME
local     myproject_db_data
local     myvolume
[root@master myproject]# docker inspect myproject_db_data
[
    {
        "CreatedAt": "2024-11-28T08:39:32+05:30",
        "Driver": "local",
        "Labels": {
            "com.docker.compose.project": "myproject",
            "com.docker.compose.version": "2.30.3",
            "com.docker.compose.volume": "db_data"
        },
        "Mountpoint": "/var/lib/docker/volumes/myproject_db_data/_data",
        "Name": "myproject_db_data",
        "Options": null,
        "Scope": "local"
    }

# docker container inspect myproject-frontend-1

        "Mounts": [
            {
                "Type": "bind",
                "Source": "/root/scripts/docker/myproject/frontend/nginx.conf",
                "Destination": "/etc/nginx/nginx.conf",
                "Mode": "rw",
                "RW": true,
                "Propagation": "rprivate"
            },
            {
                "Type": "bind",
                "Source": "/root/scripts/docker/myproject/frontend",
                "Destination": "/usr/share/nginx/html",
                "Mode": "rw",
                "RW": true,
                "Propagation": "rprivate"
            }
        ],


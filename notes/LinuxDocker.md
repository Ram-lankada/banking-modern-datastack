# Linux Docker 

## 🟢 Health & Status

### Check daemon

```
systemctl status docker
```

### Start daemon

```
sudo systemctl start docker
```

### Enable auto start

```
sudo systemctl enable docker
```

---

## 🟢 Core Daily Commands

### Running containers

```
docker ps
```

### All containers

```
docker ps -a
```

### Images

```
docker images
```

---

## 🟢 Logs & Debug

```
docker logs <container>
docker logs -f <container>
```

---

## 🟢 Exec Into Container

```
docker exec -it <container> bash
```

---

## 🟢 Stop / Remove

```
docker stop <container>
docker rm <container>
```

---

## 🟢 Cleanup (Use Often)

```
docker system prune -a
```

Nuclear cleanup:

```
docker system prune -a --volumes
```

---

# 🟣 Docker Compose Core

### Start

```
docker compose up -d
```

### Stop

```
docker compose down
```

### Rebuild

```
docker compose up -d --build
```

### Logs

```
docker compose logs -f
```

---

# 🟡 When Things Feel Haunted

### Check context

```
docker context ls
```

### Reset context

```
docker context use default
```

---

# 🟡 Check Socket

```
echo $DOCKER_HOST
```

Should be empty OR:

```
unix:///var/run/docker.sock
```

---

# 🟡 Restart Docker Engine

```
sudo systemctl restart docker
```

---

# 🔴 When Docker Desktop Polluted Environment

Remove Desktop socket usage:

```
rm -rf ~/.docker/desktop
```

(Optional but often cleansing)

---

# 🧬 Linux Docker Native

Only trust:

```
/.docker/desktop/docker.sock → docker desktop 
dockerd → /var/run/docker.sock → docker CLI
```

Perfect. I’ll keep your **structure + tone + bullet thinking**, but expand with **root-cause explanations** (not generic Docker talk).

---

# Root Cause Analysis — Why All This Happened

---

## Docker Desktop Initialization Issue

### What Happened

* Docker Desktop on Linux runs **parallel orchestration layer** on top of native Docker
* Creates separate:

  * socket
  * context
  * process tree
  * networking layer
* You ended up with **two Docker control planes**

```
Docker Desktop daemon
Native dockerd daemon
```

---

### Why Manual `ps kill` Was Needed

Because Desktop:

* Respawns child processes via supervisor
* Uses background service model
* containerd + dockerd may be re-spawned automatically

So:

```
kill dockerd → supervisor → respawn dockerd
```

Looks like zombie but is actually service manager doing job.

---

### Why `pkill` Failed Sometimes

Because:

* rootless docker namespaces
* systemd ownership
* kernel capability restrictions
* containerd often owned by systemd → not user killable

---

---

## Residue of Previous Docker Compose Setup

---

### Why Residue Exists Even After Container Delete

Docker Compose creates 4 state layers:

```
Containers
Images
Volumes   ← biggest hidden persistence
Networks
```

Deleting containers removes only:

```
runtime layer
```

Not:

```
data layer (volumes)
```

---

### Why Volumes Caused Conflict

Postgres specifically:

* stores DB inside volume
* on restart:

```
if data exists → skip init
```

So new container = old DB state.

---

### Why Permission Issues Even With sudo

Because of:

| Layer                    | Behavior               |
| ------------------------ | ---------------------- |
| Kernel namespace         | UID remapping          |
| Docker storage driver    | overlay ownership      |
| Systemd service          | process ownership      |
| Rootless docker remnants | mixed permission space |

So sometimes:

```
sudo user != namespace root
```

---

---

## containerd & dockerd Respawning

---

### Why They Restart Automatically

Because systemd service defined as:

```
Restart=always
```

So behavior:

```
kill process → systemd detects exit → restarts
```

Correct behavior, not bug.

---

### Why `daemon-reexec` Fixed It

Because:

```
reload systemd state
reset service process tree
clear stale pid references
```

Basically systemd memory refresh.

---

---

## Docker Desktop Messing With New Containers

---

### Why Desktop Causes Conflict On Linux

Desktop adds:

```
extra socket layer
extra docker context
extra process manager
extra network layer
```

Linux already has native container runtime → duplication.

So mismatch happens when:

```
CLI → native dockerd
Desktop → desktop dockerd
```

Two engines = two realities.

---

---

## Airflow Permission Error

---

### What Actually Happened

You used bind mount:

```
host docker/logs → container /opt/airflow/logs
```

Container user:

```
airflow (UID ~ 50000)
```

Host folder owner:

```
ram (UID 1000)
```

Linux permission check:

```
UID must match OR world writable
```

It didn’t → write denied.

---

### Why chmod Fixed

Because:

```
777 → bypass UID ownership requirement
```

Not elegant → but perfect dev solution.

---

---

## Why This All Appeared After Reset

---

### Before Reset

Docker managed:

```
volumes
permissions
namespaces
```

Internally.

---

### After Reset

You switched to:

```
bind mounts → host filesystem rules apply
```

So now Linux permission model fully applies.

---

---

## Why This Is Normal In Real Dev Environments

Because modern dev stack =

```
systemd
Docker
containerd
overlayfs
namespaces
bind mounts
user mapping
```

Multiple isolation layers.

When reset partially → inconsistencies surface.

---

---

## Hidden Meta Cause

You hit **Layer Desynchronization Problem**

Between:

```
systemd process state
Docker runtime state
filesystem state
namespace state
volume persistence state
```

Once misaligned → weird behavior appears.

---

---

## Why Full Docker Reset Solved Everything

Because you removed:

```
runtime state
persistent data state
network state
process state
namespace mapping state
```

Returned system to deterministic baseline.

---

---

## Professional Mental Model

Docker is NOT stateless.

It is:

```
Runtime + Storage Engine + Network Fabric + Process Supervisor
```

You must sometimes reset all 4.

---

---

## Why Linux + Native Docker Is Best For You

Because removes:

```
Desktop orchestration duplication layer
```

Less state = less failure.

---

---

## Final High-Level Summary

You experienced combination of:

```
Desktop daemon conflict
Systemd process auto-respawn
Volume persistence causing data conflicts
Namespace permission mismatch
Bind mount ownership mismatch
```

All normal when mixing Desktop + Engine + Reset + Bind Mount.

---

If you want, next level I can compress this into **“Docker Failure Debug Playbook”** — like 5 step decision tree you can run mentally whenever Docker acts weird. That’s usually what senior infra engineers carry in head.

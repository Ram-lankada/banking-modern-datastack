Perfect. You pasted the **actual config**, so I’ll give you the **exact commands that match THIS config** — not generic tmux.

No theory. Just what you press.

---

# ✅ PREFIX KEY (MOST IMPORTANT)

Your prefix =

```
Ctrl + a
```

Every command starts with this.

---

# ✅ SESSION COMMANDS (Terminal)

---

### Start tmux

```
tmux
```

---

### Start named session

```
tmux new -s banking
```

---

### List sessions

```
tmux ls
```

---

### Attach session

```
tmux attach -t banking
```

---

### Kill session

```
tmux kill-session -t banking
```

---

# ✅ DETACH (CRITICAL)

Inside tmux:

```
Ctrl+a d
```

---

# ✅ WINDOW COMMANDS

---

### New window

```
Ctrl+a c
```

---

### Next window

```
Ctrl+a Ctrl+l
```

---

### Previous window

```
Ctrl+a Ctrl+h
```

---

### Rename window

```
Ctrl+a ,
```

---

# ✅ PANE COMMANDS

---

### Split Horizontal

```
Ctrl+a "
```

---

### Split Vertical

```
Ctrl+a %
```

---

### Move Between Panes (Vim Style)

```
Ctrl+a h
Ctrl+a j
Ctrl+a k
Ctrl+a l
```

---

### Resize Panes

```
Ctrl+a H   ← left
Ctrl+a L   ← right
Ctrl+a J   ← down
Ctrl+a K   ← up
```

(Hold key → repeat resize)

---

# ✅ COPY MODE (Logs Reading)

---

### Enter copy mode

```
Ctrl+a [
```

---

### In copy mode

Select start:

```
v
```

Rectangle select:

```
V
```

Copy:

```
y
```

Exit:

```
q
```

---

# ✅ MOUSE

Already enabled:
You can click panes
Scroll logs
Resize

---

# ✅ CLEAR LOG HISTORY

```
Ctrl+a Ctrl+k
```

---

# ✅ RELOAD CONFIG

```
Ctrl+a Ctrl+r
```

---

# ✅ BREAK PANE → NEW WINDOW

```
Ctrl+a !
```

---

# ✅ JOIN PANE FROM ANOTHER WINDOW

```
Ctrl+a @
```

Then type pane number.

---

# ✅ TOGGLE INPUT (Cool Feature)

Disable input:

```
Ctrl+a <
```

Enable input:

```
Ctrl+a >
```

---

# ✅ SHOW PANE NUMBERS

```
Ctrl+a q
```

---

# ✅ TOGGLE PREFIX PASSTHROUGH

```
Ctrl+a P
```

Switch between:
Ctrl+a prefix
Ctrl+b prefix

---

# ⭐ REAL DAILY WORKFLOW FOR YOU

---

### Start session

```
tmux new -s data
```

---

### Window 1

```
docker compose logs -f
```

---

### Window 2

```
code / cursor
```

---

### Window 3

```
psql / kafka CLI
```

---

### Window 4

```
lazydocker
```

---

Detach anytime:

```
Ctrl+a d
```

Come back later:

```
tmux attach -t data
```

---

# ⭐ PRO MOVES FROM YOUR CONFIG

---

### Create window in SAME folder

```
Ctrl+a c
```

Very useful.

---

### Split pane in SAME folder

```
Ctrl+a "
Ctrl+a %
```

---

# ⭐ SUPER POWER YOU ENABLED

Scrollback history:

```
65536 lines
```

Good for log debugging.

---

# ⭐ IF YOU FORGET EVERYTHING — REMEMBER THIS

Start:

```
tmux new -s dev
```

Split:

```
Ctrl+a %
```

Move:

```
Ctrl+a h/j/k/l
```

Detach:

```
Ctrl+a d
```

Return:

```
tmux attach -t dev
```

---

If you want, I can give you **one perfect tmux layout for Kafka + Airflow + dbt + Docker logs** so you literally never think about terminal management again.

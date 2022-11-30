# Screen

## Description

The `screen` command opens a session which will be **running even if you disconnect from the cluster**.

This is especially useful for time-consuming processes, so that you can leave them running in the background without the fear of accidentally disconnecting and losing all the progress.

You can also open several screens for different processes, which you can detach and attach to them as you like.

---

## Basic commands

### New screen

Creates a **new screen** with name "*custom_name*".

```bash
screen -S <custom_name>
```

!!! warning
    When opening a new screen, this should be done from the `login01` node, since this guarantees that the screen will be **constantly running** and not shut down (which could happen if the screen is opened in one of the other nodes).

### List screens

List all the created screens.

```bash
screen -ls
```

### Detach

Detaches from a screen

```text
Ctrl + A -> D
```

### Re-attach

Re-attaches to a detached screen.

```bash
screen -r [#]
```

!!! note
    If there are multiple screens available, include the **number** of the screen id (or **name**) to identify which screen to re-attach.

### Exit and kill screen

```bash
exit
```

### Kill a detached screen

```bash
screen -X -S [screen number ID or name] quit
```

### Kill all screens

```bash
pkill screen
```

---

## Documentation

For a more extensive list of commands, check the [screen cheatsheet](https://quickref.me/screen){:target="_blank"}.

You can also check the [full documentation](https://www.gnu.org/software/screen/manual/screen.html){:target="_blank"}.

## Reference

- Carlos López Elorduy
- Jordi Deu-Pons
- Miguel Grau

# Screen


## Description

The `screen` command opens a session which will be **running even if you disconnect from the cluster**.

This is especially useful for time-consuming processes, so that you can leave them running in the background without the fear of accidentally disconnecting and losing all the progress.

You can also open several screens for different processes, which you can detach and attach to them as you like.

## Usage

The command to open a screen is specifically:

```bash
screen -S <custom_name>
```



!!! note

    This command must be executed from the `login01` node, since this guarantees that the screen will be **constantly running** and not shut down (which could happen if the screen is opened in one of the other nodes).


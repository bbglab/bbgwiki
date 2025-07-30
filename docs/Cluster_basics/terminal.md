# Terminal

In this section we are going to show the basic commands to navigate and manage files with the terminal.

## Creating folders and files

### Directories (folders)

| Command              | Description                                |
| -------------------- | ------------------------------------------ |
| `ls`                 | Show the content of the current directory  |
| `cd anotherdir`      | Change directory to `anotherdir`           |
| `cd ..`              | Change to previous directory               |
| `cd ~`               | Change to home folder (`/home/<user>/`)    |
| `cd /`               | Change to root folder (`/`)                |
| `pwd`                | Show path of current directory             |
| `mkdir newdirectory` | Create new directory called `newdirectory` |

### Files

| Command                              | Description                                                        |
| ------------------------------------ | ------------------------------------------------------------------ |
| `touch newfile.txt`                  | Create new file called `newfile.txt`                               |
| `echo "Hello BBGLab!" > newfile.txt` | Save output of `echo` command into a file called `newfile.txt`     |
| `echo "In the morning" >> file.txt`  | Append to the end of the file `file.txt` the line output of `echo` |

## Moving and manipulating files

| Command                   | Description                                          |
| ------------------------- | ---------------------------------------------------- |
| `mv file.txt destination` | Move file `file.txt` to directory `destination`      |
| `mv dir1/* destination`   | Move all contents of `dir1` to `destination`         |
| `mv file1.txt file2.txt`  | Change name of `file1.txt` to `file2.txt`            |
| `cp file.txt destination` | Copy `file.txt` into directory `destination`         |
| `cp file1.txt file2.txt`  | Copy `file1.txt` into `file2.txt`                    |
| `diff file1.txt file2.txt`| Compare the contents of two files and display the differences      |
| `rm file.txt`             | Remove `file.txt`                                    |
| `rm -rf dir1`             | Remove directory `dir1` and **ALL THE FILES INSIDE** |

## Compressed files

| Command                   | Description                                          |
| ------------------------- | ---------------------------------------------------- |
| `gzip file.txt`           | Compress `file.txt`                                  |
| `gunzip file.txt`         | Expand `file.txt`                                    |
| `zcat file.txt.gz`        | Read a gzipped file without uncompressing            |

## Other basic commands

| Command                    | Description                                         |
| -------------------------- | --------------------------------------------------- |
| `echo "message"`           | Print `message` in the terminal                     |
| `cat file.txt`             | Show contents of `file.txt`                         |
| `less file.txt`            | Show contents of `file.txt` one page at a time      |
| `head file.txt`            | Show first 10 lines of `file.txt`                   |
| `grep "sentence" file.txt` | Search the word "sentence" in `file.txt`            |
| `find . -name "file.txt"`  | Find in current directory (`.`) the file `file.txt` |
| `man echo`                 | Manual (documentation) of command `echo`            |
| `which echo`               | Show the full path of command `echo`                |

## Reference

- Carlos López-Elorduy
- Federica Brando
- Miguel Grau
- Jordi Deu-Pons
- Laura Torrens

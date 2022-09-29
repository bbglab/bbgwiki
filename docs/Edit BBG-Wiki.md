# Edit BBG-Wiki

The main language of the wiki documentation is **Markdown**. There are several online editors which can help writting Markdown text and automatically visualize what is being written.

- [StackEdit](https://stackedit.io/app){:target="_blank"}
- [Editor.md](https://pandao.github.io/editor.md/en.html){:target="_blank"}

This wiki is stored in a **GitHub repository**, where each section of the wiki corresponds to a single **Markdown file** (`*.md`). By editing these files either online or locally, the wiki can be updated by everyone.

- [Markdown cheatsheet](https://quickref.me/markdown){:target="_blank"}

## Online

Go to the [bbg-wiki repository](https://github.com/bbglab/bbgwiki){:target="_blank"} and edit any file inside the `docs/` folder, which contains all the files of the documentation.

![BBGWiki edit online tutorial](assets/images/bbgwiki_edit_online.jpg)

## Local

### Installation

```bash
git clone git@github.com:bbglab/bbgwiki.git
pip install -r bbgwiki/requirements.txt
```

!!! note annotate "Error: My Github password seems to be wrong somehow..."
    It might be the case that at some point of this process, it asks for the Github user and password. However, although you should introduce your Github user, the password that it asks **is not your Github password**. In order to know what to introduce here, you need to generate a `ssh key` following one of these two options:
    
    - From the **Github web**:
        - Go to Github and login
        - Click on your profile on the top right
        - Settings > Developer settings (bottom option of the left bar) > Personal access tokens > Generate new token
        - Introduce your Github password
        - Check all the boxes of the checklist
        - Click "Generate token".
        - Copy the generated key (looks like a bunch of random letters) and paste it in your terminal where it previously asked for the password.
    
    - From the **terminal**:
        - Execute the command:
        
        ```bash
        ssh-keygen -o -t rsa -C “ssh@github.com”
        ```

        - Click "Enter" on all the options (unless you want to save the key in a specific file, but it is not mandatory)
        - Execute the next command to see the generated key (if you selected a specific file, change the `id_rsa` in the command by the name you inputed).

        ```bash
        cat id_rsa.pub
        ```

        - Copy the output and paste it in your terminal where it previously asked for the password.

### Requirements

```text
mkdocs >= 1.2.2
mkdocs-material >= 7.1.11
mkdocs-static-i18n >= 0.18
```

### Commands

Running at **localhost** (to try stuff before updating the main web)

```bash
mkdocs serve
```

Update web:

```bash
git add <edited file or directory>
git commit -m "Message"
git push
```

## References

- Carlos López Elorduy

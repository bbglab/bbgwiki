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
git clone https://github.com/bbglab/bbgwiki.git
pip install -r bbgwiki/requirements.txt
```


### Requirements

```
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

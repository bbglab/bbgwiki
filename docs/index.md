<!-- # Home -->
# Welcome to the BBG-Wiki! ![bbglab-logo](assets/images/bbglabLOGO_small.png)

This website is meant to include information of all the **tools** and **data** used by the **bbglab** team, so that it serves both as a guide to understand them and as a place where to find information about everything.

---

## Edit BBG-Wiki

The main language of the wiki documentation is **Markdown**.There are several online editors which can help writting Markdown text and automatically visualize what is being written.

- [StackEdit](https://stackedit.io/app)
- [Editor.md](https://pandao.github.io/editor.md/en.html)

Each section of the wiki corresponds to a single **Markdown file** (`*.md`). By editing these files either online or locally, the wiki can be updated by anyone.

- [Markdown cheatsheet](https://www.markdownguide.org/cheat-sheet/)

### Online

Go to the [bbg-wiki repository](https://github.com/bbglab/bbgwiki) and edit any file inside the `docs` folder, which contains all the files of the documentation.

### Local
#### Installation

```bash
git clone https://github.com/bbglab/bbgwiki.git
pip install -r bbgwiki/requirements.txt
```


#### Requirements

```
mkdocs >= 1.2.2
mkdocs-material >= 7.1.11
mkdocs-static-i18n >= 0.18
```

#### Commands
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

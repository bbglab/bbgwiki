# BBG-Wiki

Website with info of all the tools and data used in the bbglab.

You can browse it at [bbglab.github.io/bbgwiki](https://bbglab.github.io/bbgwiki)

## Installation

```sh
pip install -r requirements.txt
```

## Requirements

```txt
mkdocs >= 1.2.2
mkdocs-material >= 7.1.11
mkdocs-static-i18n >= 0.18
mkdocs-git-authors-plugin >= 0.9.2
mkdocs-git-revision-date-localized-plugin >= 1.3.0 
mkdocs-git-committers-plugin-2 >= 2.4.1
```

## Commands

Running at **localhost** (to try stuff before updating the main web)

```sh
mkdocs serve
```

Update web:

```sh
git add <edited file or directory>
git commit -m "Message"
git push
```

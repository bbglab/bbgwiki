<!-- # Home -->
# Welcome to the BBG-Wiki! ![bbglab-logo](assets/images/bbglabLOGO_small.png)

Website with info of all the tools and data used in the bbglab.


## Edit BBG-Wiki

### Option 1

Go to the [bbg-wiki repository](https://github.com/bbglab/bbgwiki) and edit any file inside the `docs` folder, which contains all the files of the documentation.

### Option 2
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

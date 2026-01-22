# VSCode Extensions and Settings

Visual Studio Code can be significantly enhanced through extensions and proper configuration. This page provides a
comprehensive guide to useful extensions and recommended settings to improve your development experience.

## Extensions

### General

| Extension             | Description                                                                                                             |
| --------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| **Error Lens**        | Improve highlighting of errors, warnings and other language diagnostics. Displays error messages directly in your code. |
| **GitHub Copilot**    | AI coding assistant that helps you write code faster. See our dedicated [GitHub Copilot](../GitHub_Copilot.md) page.    |
| **CodeSnap**          | Take beautiful screenshots of your code with syntax highlighting and customizable themes.                               |
| **Color Highlight**   | Highlight colors in your editor (hex, rgb, hsl). Perfect for web development and CSS work.                              |
| **Comment Anchors**   | Place anchor tags within comments for easy file and workspace navigation. Helps organize large files.                   |
| **SonarQube for IDE** | Advanced linter to detect & fix coding issues locally, including cognitive complexity analysis.                         |
| **Random everything** | Generate random ints, floats, strings, words, mails, etc. Useful for testing and placeholder data.                      |

### Git

| Extension       | Description                                                                                             |
| --------------- | ------------------------------------------------------------------------------------------------------- |
| **GitLens**     | Improved Git experience within VSCode. Provides detailed Git information directly in your editor.       |
| **Git Graph**   | View a Git Graph of your repository, and perform Git actions from the graph. Visualize commit history.  |
| **Git History** | View git log, file history, compare branches or commits. Essential for tracking code changes over time. |

![Git Graph Extension](../assets/images/gitgraph.png)

### Python & Notebooks

| Extension         | Description                                                                                                        |
| ----------------- | ------------------------------------------------------------------------------------------------------------------ |
| **autoDocstring** | Generates python docstrings automatically. Saves time when documenting your Python functions and classes.          |
| **Data Wrangler** | Data viewing, cleaning and preparation for tabular datasets. Great for data science workflows.                     |
| **Ruff**          | Visual Studio Code extension with support for the Ruff linter and formatter. Modern Python linting and formatting. |

![autoDocstring Extension - Placeholder for screenshot showing automatic docstring generation]

### SSH Cluster

| Extension      | Description                                                                                                                                                                                                                |
| -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Remote SSH** | Open any folder on a remote machine using SSH and take advantage of VS Code's full feature set. Essential for working with cluster environments. See our [VSCode in cluster](cluster_node.md) page for setup instructions. |

![Remote SSH Extension - Placeholder for screenshot showing remote connection interface]

### Markdown

| Extension               | Description                                                                                    |
| ----------------------- | ---------------------------------------------------------------------------------------------- |
| **Markdown All in One** | All you need to write Markdown (keyboard shortcuts, table of contents, auto preview and more). |
| **Markdown Checkboxes** | Adds checkbox support to the built-in markdown preview.                                        |
| **Markdown PDF**        | Convert Markdown to PDF for documentation export.                                              |
| **Marp for VS Code**    | Create slides written in Marp Markdown on VS Code. Perfect for presentations.                  |

### PDF

| Extension      | Description                                                          |
| -------------- | -------------------------------------------------------------------- |
| **vscode-pdf** | Display pdf files in VSCode without leaving your editor environment. |

### TSV/CSV

| Extension       | Description                                                                                       |
| --------------- | ------------------------------------------------------------------------------------------------- |
| **Edit CSV**    | Extension to edit csv files with a table ui. Makes working with tabular data much easier.         |
| **Rainbow CSV** | Highlight CSV and TSV files, run sql-like queries. Improves readability of structured data files. |

![Edit CSV Extension - Placeholder for screenshot showing table editor interface]

### JSON

| Extension       | Description                                                                                                 |
| --------------- | ----------------------------------------------------------------------------------------------------------- |
| **JSON Crack**  | Seamlessly visualize your JSON data instantly into graphs. Great for understanding complex JSON structures. |
| **Json Editor** | Generate a tree view editor of the active JSON document.                                                    |

![JSON Crack Extension - Placeholder for screenshot showing JSON graph visualization]

### Logs

| Extension            | Description                                                               |
| -------------------- | ------------------------------------------------------------------------- |
| **Output Colorizer** | Syntax highlighting for log files. Makes reading logs much more pleasant. |

### SQLite

| Extension         | Description                                                                           |
| ----------------- | ------------------------------------------------------------------------------------- |
| **SQLite Viewer** | SQLite Viewer for VS Code. Browse and query SQLite databases directly in your editor. |

### Images

| Extension         | Description                                                                            |
| ----------------- | -------------------------------------------------------------------------------------- |
| **Image preview** | Shows image preview in the gutter and on hover. Helpful when working with image files. |
| **SVG Previewer** | Show SVG preview to the side panel.                                                    |
| **Drawio**        | Integrates a drawio editor within VSCode to easily create figures, flowcharts, etc.    |

![Drawio Extension - Placeholder for screenshot showing diagram creation interface]

### Web Development (HTML, CSS, JS)

| Extension        | Description                                                                                            |
| ---------------- | ------------------------------------------------------------------------------------------------------ |
| **Live Preview** | Hosts a local server in your workspace for you to preview your webpages on. Real-time web development. |

### Multiple Cursors

| Extension                         | Description                                                                     |
| --------------------------------- | ------------------------------------------------------------------------------- |
| **Multiple cursor case preserve** | Preserves case when editing with multiple cursors.                              |
| **Increment selection**           | Increment selection with multiple cursors. Useful for creating sequential data. |

### API

| Extension          | Description                                                                     |
| ------------------ | ------------------------------------------------------------------------------- |
| **Thunder Client** | Lightweight Rest API Client for VS Code. Test APIs without leaving your editor. |

![Thunder Client Extension - Placeholder for screenshot showing API testing interface]

### Aesthetics

| Extension               | Description                                                                                                 |
| ----------------------- | ----------------------------------------------------------------------------------------------------------- |
| **Material Icon Theme** | Material Design Icons for Visual Studio Code. Makes file navigation more intuitive.                         |
| **Peacock**             | Subtly change the workspace color of your workspace. Ideal when you have multiple VS Code instances opened. |

![Peacock Extension - Placeholder for screenshot showing workspace color customization]

## Configuration

### Very Good to Have

| Setting                                        | Description                                                                                                                      |
| ---------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| **Files: Trim Trailing Whitespace**            | Trims trailing whitespace when saving a file. Helps having cleaner code without unnecessary extra spaces.                        |
| **Files: Auto Save**                           | Controls auto save of editors with unsaved changes. Can be set to auto save after a delay, focus change, or window change.       |
| **Workbench › Editor: Custom Labels Patterns** | Improves rendering of files with same names (e.g., `main.py`, `index.html`). Shows folder name in tab for easier identification. |
| **Git: Autofetch**                             | When enabled, commits will automatically be fetched from the default remote of the current Git repository.                       |

![Custom Labels Configuration - Placeholder for screenshot showing custom label settings]

![Custom Labels Result - Placeholder for screenshot showing improved file tab rendering with folder names]

### Jupyter Notebooks

| Setting                              | Description                                                                                                     |
| ------------------------------------ | --------------------------------------------------------------------------------------------------------------- |
| **Notebook: Inline Values**          | Shows inline values within notebook cells after execution. Very useful to see variable values at first glance.  |
| **Notebook › Diff: Ignore Metadata** | Ignores metadata changes in notebook diff editor. Makes diff visualization cleaner by hiding annoying metadata. |
| **Notebook › Diff: Ignore Outputs**  | Ignores output changes in notebook diff visualization. Shows only code changes in the diff editor.              |

![Notebook Inline Values - Placeholder for screenshot showing variable values displayed inline in notebook cells]

!!! note
The changes in metadata and output would still be committed. The only difference is that it makes it so that when
you check the changes done you would only see the code.

### GitHub Copilot

| Setting                                   | Description                                                                                                        |
| ----------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| **GitHub Copilot › Agent: Enabled**       | Enables agent mode for Copilot Chat. When enabled, agent mode can be activated via dropdown in the view.           |
| **GitHub Copilot › Agent: Max Requests**  | Maximum number of requests allowed per-turn in agent mode. Increase default for more extensive agent interactions. |
| **GitHub Copilot › Agent: Thinking Tool** | Enables thinking tool for deep analysis before generating responses in agent mode.                                 |
| **GitHub Copilot › Tools: Auto Approve**  | Auto-approves tool usage permission when using MCPs. Reduces interruptions during tool usage.                      |
| **GitHub Copilot: Enable**                | Enable or disable auto-triggering of Copilot completions for specified languages.                                  |

### Type Hinting

| Setting                                                    | Description                                                                                 |
| ---------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| **Python › Analysis: Type Checking Mode**                  | Enables VSCode to check for type mismatches. Set to "basic" or "standard" (avoid "strict"). |
| **Python › Analysis: Strict Dictionary Inference**         | Improves type hint detection for dictionaries.                                              |
| **Python › Analysis: Strict List Inference**               | Improves type hint detection for lists.                                                     |
| **Python › Analysis: Strict Set Inference**                | Improves type hint detection for sets.                                                      |
| **Python › Analysis › Inlay Hints: Function Return Types** | Displays function return type information directly in your code.                            |
| **Python › Analysis › Inlay Hints: Variable Types**        | Displays variable type information directly in your code.                                   |
| **Python › Analysis › Inlay Hints: Pytest Parameters**     | Displays pytest parameter type information directly in your code.                           |

![Type Hints Display - Placeholder for screenshot showing inlay hints with variable types and return types]

### Style

| Setting                                                | Description                                                                                                       |
| ------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------- |
| **Editor: Font Family** and **Editor: Font Ligatures** | Use fonts with ligatures from [NerdFonts](https://www.nerdfonts.com/). Install font locally and enable ligatures. |
| **Workbench: Color Theme**                             | Specifies the color theme used in the workbench. Choose from many themes to fit your preferences.                 |
| **Workbench: Icon Theme**                              | Specifies the file icon theme. Recommend Material Icon Theme, but many options available.                         |

![Font Ligatures Example - Placeholder for screenshot showing code with font ligatures enabled]

## Installation Tips

### Extension Installation

1. Open VSCode
2. Click on the Extensions icon in the Activity Bar (or press `Ctrl+Shift+X`)
3. Search for the extension name
4. Click "Install"

![Extension Installation - Placeholder for screenshot showing extension installation process]

### Settings Configuration

You can modify settings in two ways:

#### Via Settings UI

1. Open Settings (`Ctrl+,` or `File > Preferences > Settings`)
2. Search for the setting name
3. Modify the value

#### Via settings.json

1. Open Command Palette (`Ctrl+Shift+P`)
2. Type "Preferences: Open Settings (JSON)"
3. Add your configuration directly to the JSON file

![Settings Configuration - Placeholder for screenshot showing settings.json file with configurations]

## Recommended Extension Combinations

### For Python Development

- Python
- Ruff
- autoDocstring
- Data Wrangler
- Error Lens
- GitLens

### For Data Science

- Python
- Jupyter
- Data Wrangler
- Rainbow CSV
- SQLite Viewer
- Image preview
- Color Highlight

### For Web Development

- Live Preview
- Color Highlight
- Thunder Client
- JSON Crack

### For Documentation

- Markdown All in One
- Markdown PDF
- Drawio
- CodeSnap

## References

- Carlos López-Elorduy

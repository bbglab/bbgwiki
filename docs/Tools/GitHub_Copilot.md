# GitHub Copilot

## Features

Here's the official video from VSCode explaining the basic features of GitHub Copilot:

<div class="video-wrapper">
  <iframe width="560" height="315" src="https://www.youtube.com/embed/jXp5D5ZnxGM?si=WjWpCqX5EHy1BNPU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
</div>

<style>
.video-wrapper {
  position: relative;
  display: block;
  height: 0;
  padding: 0;
  overflow: hidden;
  padding-bottom: 56.25%;
}
.video-wrapper > iframe {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 100%;
  border: 0;
}
</style>

### 1. Ghost Text

- Code as you normally would, and the ghost text will start to appear.
- You can also trigger the ghost text by writting a comment about what you want to do.
- Hit `Tab` to accept the ghost text or `Ctrl + Right Arrow` to accept one word at a time.
- Hit `Esc` to dismiss the ghost text.

![Ghost text](../assets/images/example-ghc-ghost.png)

### 2. Code Suggestions

- If you want to see more suggestions, you can hit `Ctrl + Enter` for Copilot to generate several suggestions in a separate window for you to accept whichever one you want to use.

![Github Copilot Suggestions](../assets/images/example-ghc-suggestions.png)

### 3. Inline Chat

- Triggered by `Ctrl + I`.
- The generated code doesn't exist in your file until you hit accept.
- Highlight the part of the code you want to discuss or change, and then hit `Ctrl + I` to ask Copilot for what you want to do.

![Inline chat](../assets/images/example-ghc-inline-chat.png)

### 4. Chat Sidebar

- Classic chat interface.
- In the side bar, search for the chat icon.
- You can ask for help, ask for explanations, or ask for more suggestions.
- When you get code suggested, you also get a small panel to quickly insert the code into your file, copy the content, and more options.

![Chat Sidebar](../assets/images/example-ghc-chat-sidebar.png)

### 4. Code Refactoring

Copilot is very useful even if you are not actively interacting with it. Just by typing and accepting the ghost suggestions, you will see your coding performance improving. Having said that, there are more ways you can use Copilot to refactor your code.

#### 4.1. Improve Code

You can ask Copilot to improve your code, for example, by making it more efficient, more readable, or by adding documentation and comments to it.

#### 4.2. Simplify Code

You can ask Copilot to simplify your code. This can be useful when you have a complex piece of code that you want to make more readable or efficient. It is also useful when trying to understand code from someone else (see [!explain](#)

#### 4.4. Rename Variables

By typing `F2` when having your cursor on top of a variable or function name, you can rename it accross the entire file. This is integrated in VSCode by default, but with Github Copilot, you get access to suggestions for the new names.

![Example Rename Variable](../assets/images/example-ghc-rename.png)

### 5. Git Integration

#### 5.1. Commits

If you go to the source control tab in VSCode, you will see a sparkle ✨ icon that when clicked will understand the changes you made and suggest a commit message for you.

![Example Github Copilot Commit](../assets/images/example-ghc-commit.png)

#### 5.2 Pull Requests

### 6. Useful Commands

#### 6.1. `/fix`

Fix the selected code. You can also give the error message you are getting. This command is more powerful than not using it, even though sometimes there might be no difference.

#### 6.2. `/explain`

Explain the selected code.

![Example Github Copilot Explain Command](../assets/images/example-ghc-explain.png)

#### 6.3. `/test`

The command `/test` will generate a test for the selected code. This makes writting tests much easier and faster.

![Example Github Copilot Test](../assets/images/example-ghc-tests.png)

#### 6.4. `/new`

Create any file you want with the instructions you provide.

#### 6.5. `/newNotebook`

Create a Jupyter Notebook based on the instructions you provide. It works better than the `/new` since this one is specifically designed for Jupyter Notebooks, which turns more powerful for this usecase.

![Example Github Copilot /newNotebook](../assets/images/example-ghc-newnotebook.png)

#### 6.6. `@terminal`

Ask how to do something in the terminal.

### 7. Manage Context

Normally, if you want to provide context for your query, you simply need to **highlight** the code you want to use as context. However, you can also use the following commands to provide context:

#### 7.1. `@workspace`

By adding this command next to your query, you are telling Copilot to look at the entire workspace to give you a better suggestion. The workspace corresponds to the root folder that you have opened in VSCode.

![Example Github Copilot @workspace](../assets/images/example-ghc-workspace.png)

!!! TIP
    Try to open VSCode in the root folder of your project, instead of a very general folder (such as `/workspace`, `/workspace/projects`, etc), to get more accurate suggestions, since Copilot won't have to look through a lot of files to give you a suggestion.

#### 7.2. `#file`

If you want to use one or more specific files as context for your query, you can add the `#file` command followed by the name of the file you want to use. This can be done as many times as you want, with different files.

![Example Github Copilot #file](../assets/images/example-ghc-file.png)

!!! WARNING
    If the file you are using as context is too big, Copilot will highlight that file indicating that it couldn't use the whole content of the file, but still attempt to give you a suggestion based on the part of the file it could read.

#### 7.3. `#terminalSelection`

Similarly to the way that you can just select part of your code to use it as context for Copilot, you can highlight anything in the terminal and use the `#terminalSelection` command to tell Copilot to use that as context.

![Example Github Copilot Terminal Selection](../assets/images/example-ghc-terminal-selection.png)

#### 7.3. `#terminalLastCommand`

If you want to use the last command you executed in the terminal as context for your query, you can use the `#terminalLastCommand` command.

!!! NOTE
    The difference between this one and the ' #terminalSelection' is that this one will use the last command you executed in the terminal, whithout having to highlight anything, while the other one will use whatever you have selected in the terminal, even if it has nothing to do with the latest command you executed.

## GitHub Copilot CLI

<div class="video-wrapper">
  <iframe width="560" height="315" src="https://www.youtube.com/embed/fHwtrOcLAnI?si=7ztVv97_zvfsFCde" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
</div>

There is an option to use GitHub Copilot in the terminal. There, you will have mainly two commands:

- `gh copilot suggest` or `ghcs`: **GitHub Copilot Suggest**. It will return a command based on your instructions.
  ![Example GHCS](../assets/images/example-ghcs.png)

- `gh copilot explain` or `ghce`: **GitHub Copilot Explain**. It will return an explanation of the command that was suggested. You can ask for an explanation of the command by using the command `ghce` or by selecging the option `Explain command` when you run the `ghcs` command.
  ![Example GHCS Explain](../assets/images/example-ghcs-explain.png)

If you see that the suggestion needs to be changed or you want to add extra information, you can select the option `Revide command` when you run the `ghcs` command.

![Example GHCS Revise](../assets/images/example-ghcs-revise.png)

### Installation

Here's a video explaining the installation process for GitHub Copilot CLI:

The instructions on how to set it up can be found [here](https://github.blog/changelog/2024-03-21-github-copilot-general-availability-in-the-cli/){:target="_blank"}.

## References

- Carlos López-Elorduy
- Federica Brando
- Izar de Villasante

[<img src="https://img.shields.io/badge/neovim%20-%23559D42.svg?&style=for-the-badge&logo=neovim&logoColor=white"/>][/]
[<img src="https://img.shields.io/badge/unity%20-%23000000.svg?&style=for-the-badge&logo=unity&logoColor=white"/>][/]
[<img src="https://img.shields.io/badge/typescript%20-%232f74c0.svg?&style=for-the-badge&logo=typescript&logoColor=white"/>][/]
[<img src="https://img.shields.io/badge/rust%20-%23DD3A26.svg?&style=for-the-badge&logo=rust&logoColor=white"/>][/]

# NeoVim Config

100% Lua config 🥳

This is very much a work in progress. As someone coming from heavy use of VSCode
this config aims to bring many familiar utils and handy features into vim mainly
for C#/Unity, Typescript and Rust development.

<img src="docs/preview.png" />

## Installation
Backup nvim config:
`mv ~/.config/nvim ~/.config/nvim-backup`

Clone config:
`git clone --depth=1 https://github.com/kalvinpearce/nvim ~/.config/nvim`

#### Dependencies 
* neovim >= 0.7
* python3 & pynvim
* npm > 12
* fzf
* fd
* ripgrep
* lazygit

##### Linux (currently only Arch)
Install dependencies:
`chmod +x ~/.config/nvim/install_deps.sh && sh ~/.config/nvim/install_deps.sh`

#### Windows
Install dependencies:
```bash
choco install extras
choco install python
choco install nvm
nvm install --latest
nvm use --latest
npm i -g neovim
choco install fzf
choco install fd
choco install ripgrep
choco install lazygit
```


## Why not just use VSCode?

Well I really like the idea of vim and think the customizability and speed that
you can achieve with it is quite amazing but every time I gave it a go, I always
felt like I was trying to force it. Using VSCode's vim plugin always felt like I
was trying to get it to do something it didn't want to. It was close but never
perfect. However this time I bit the bullet and went for a complete vim solution
and this is what I ended up with so far.

[/]: https://github.com/kalvinpearce/nvim/

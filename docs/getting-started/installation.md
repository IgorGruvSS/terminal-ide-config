# Instalação e primeira execução

## Índice

- [Pré-requisitos](#pré-requisitos)
- [Instalar](#instalar)
- [O que o instalador altera](#o-que-o-instalador-altera)
- [Primeira execução](#primeira-execução)
- [Atualizar uma instalação](#atualizar-uma-instalação)

## Pré-requisitos

No Fedora:

```bash
sudo dnf install alacritty tmux neovim git curl coreutils
```

## Instalar

```bash
git clone https://github.com/IgorGruvSS/terminal-ide-config.git ~/terminal-ide-config
cd ~/terminal-ide-config
./install.sh
exec zsh
```

O instalador também baixa a versão fixada do LazyGit e valida seu checksum.

## O que o instalador altera

O repositório continua sendo a única fonte das configurações. O instalador:

- adiciona `bin/` ao `PATH` no `~/.zshrc`;
- adiciona uma linha que carrega `shell/zsh/terminal-ide.zsh`;
- cria uma entrada de aplicativo KDE que chama o launcher do repositório;
- cria apenas estado de execução ignorado dentro de `.local/`, `.cache/` e
  `.state/`.

Ele não cria symlinks nem copia configurações para `~/.config`.

## Primeira execução

Sincronize os plugins bloqueados do Neovim:

```bash
nvim '+Lazy sync'
```

Depois abra o ambiente:

```bash
alacritty-tmux
```

## Atualizar uma instalação

Dentro do repositório:

```bash
git pull
./install.sh
nvim '+Lazy sync'
```

Abra um novo shell com `exec zsh`. Veja também o
[cheatsheet diário](../reference/cheatsheet.md).

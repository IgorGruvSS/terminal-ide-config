# Instalação e primeira execução

## Índice

- [Pré-requisitos](#pré-requisitos)
- [Instalar](#instalar)
- [Instalação parcial](#instalação-parcial)
- [O que o instalador altera](#o-que-o-instalador-altera)
- [Primeira execução](#primeira-execução)
- [Atualizar uma instalação](#atualizar-uma-instalação)

## Pré-requisitos

O instalador funciona em Ubuntu e Fedora, inclusive em uma máquina nova. Ele
detecta a distribuição e instala somente os pacotes ausentes. É preciso ter:

- conexão com a internet para baixar componentes versionados;
- permissão para usar `sudo` quando faltarem pacotes do sistema.

No Ubuntu, o repositório `universe` deve estar habilitado para instalar o
Alacritty. Em instalações padrão ele já vem habilitado. Se o `apt` informar que
não encontrou o pacote, execute uma vez:

```bash
sudo add-apt-repository universe
sudo apt update
```

## Instalar

```bash
git clone https://github.com/IgorGruvSS/terminal-ide-config.git ~/terminal-ide-config
cd ~/terminal-ide-config
./install.sh
exec zsh
```

O instalador também:

- instala os pacotes necessários com `apt` (Ubuntu) ou `dnf` (Fedora), apenas
  quando algum estiver ausente;
- baixa Neovim 0.11.3 para o runtime do repositório quando o Neovim do sistema
  for ausente ou antigo para esta configuração;
- instala a JetBrainsMono Nerd Font no diretório de fontes do usuário;
- baixa a versão fixada do LazyGit e valida os checksums dos downloads.

Para máquinas em que os pacotes são administrados externamente, use
`./install.sh --skip-system-packages`. O comando falha sem alterar a instalação
caso ainda falte algum pré-requisito.

## Instalação parcial

Não é necessário começar com um Ubuntu limpo. Se, por exemplo, Alacritty e Zsh
já estiverem instalados, mas tmux não, o instalador executa o `apt` e ele mantém
os pacotes já presentes, instalando tmux e os demais requisitos que faltarem.

O Oh My Zsh também é preservado. O instalador somente acrescenta ao `~/.zshrc`,
quando ainda não existirem, o `PATH` para os launchers deste repositório e a
linha que carrega `shell/zsh/terminal-ide.zsh`. Ele não substitui tema, plugins
nem outras configurações do Zsh.

Ao final, a entrada de aplicativo do KDE aponta para o Alacritty configurado
pelo repositório. Rode `nvim '+Lazy sync'` uma vez para baixar os plugins do
Neovim e use `alacritty-tmux` como ponto de entrada diário.

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

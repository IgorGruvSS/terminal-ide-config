# Instalação e primeira execução

## Índice

- [Pré-requisitos](#pré-requisitos)
- [Instalar](#instalar)
- [Instalação parcial](#instalação-parcial)
- [O que o instalador altera](#o-que-o-instalador-altera)
- [Primeira execução](#primeira-execução)
- [Atualizar uma instalação](#atualizar-uma-instalação)
- [Diagnóstico e rollback da migração LazyVim](#diagnóstico-e-rollback-da-migração-lazyvim)

## Pré-requisitos

O instalador funciona em Ubuntu e Fedora, inclusive em uma máquina nova. Ele
detecta a distribuição e instala somente os pacotes ausentes. É preciso ter:

- conexão com a internet para baixar componentes versionados;
- permissão para usar `sudo` quando faltarem pacotes do sistema.

O instalador também garante `ripgrep`, `fd`, Node/npm, Go, Python com `venv` e
`pip`, SQLite e ShellCheck. Eles sustentam Telescope, servidores e ferramentas
do Mason, os adaptadores DAP e o teste SQL local.

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
- baixa Neovim 0.12.4 e tree-sitter 0.26.11 para o runtime do repositório quando o Neovim do sistema
  for ausente ou antigo para esta configuração;
- instala a JetBrainsMono Nerd Font no diretório de fontes do usuário;
- baixa a versão fixada do LazyGit e valida os checksums dos downloads;
- sincroniza o lockfile do LazyVim e espera a instalação declarativa das
  ferramentas no Mason, incluindo o StyLua usado para formatar Lua.

Para máquinas em que os pacotes são administrados externamente, use
`./install.sh --skip-system-packages`. O comando falha sem alterar a instalação
caso ainda falte algum pré-requisito.

## Instalação parcial

Não é necessário começar com um Ubuntu limpo. Se, por exemplo, Alacritty e Zsh
já estiverem instalados, mas tmux não, o instalador executa o `apt` e ele mantém
os pacotes já presentes, solicitando apenas tmux e os demais requisitos que
faltarem.

O Alacritty é reconhecido quando estiver no `PATH`, independentemente do
diretório de instalação, ou quando for o Flatpak `org.alacritty.Alacritty`. O
launcher usa essa instalação existente e ainda fornece o arquivo de configuração
deste repositório. Para um executável em um caminho não exposto no `PATH`, use
`ALACRITTY_BIN=/caminho/para/alacritty ./install.sh`.

O Oh My Zsh também é preservado. O instalador somente acrescenta ao `~/.zshrc`,
quando ainda não existirem, o `PATH` para os launchers deste repositório e a
linha que carrega `shell/zsh/terminal-ide.zsh`. Ele não substitui tema, plugins
nem outras configurações do Zsh.

Ao final, a entrada de aplicativo do KDE aponta para o Alacritty configurado
pelo repositório. Plugins e ferramentas do Neovim já foram sincronizados; use
`alacritty-tmux` como ponto de entrada diário.

O comando `stylua` é exposto pelo `bin/` do repositório e encaminha para a
instalação correspondente do Mason. O instalador verifica esse launcher ao
final, sem adicionar o diretório inteiro do Mason ao `PATH`.

## O que o instalador altera

O repositório continua sendo a única fonte das configurações. O instalador:

- adiciona `bin/` ao `PATH` no `~/.zshrc`;
- adiciona uma linha que carrega `shell/zsh/terminal-ide.zsh`;
- cria uma entrada de aplicativo KDE que chama o launcher do repositório;
- cria apenas estado de execução ignorado dentro de `.local/`, `.cache/` e
  `.state/`.

Ele não cria symlinks nem copia configurações para `~/.config`.

## Primeira execução

O instalador já sincroniza plugins e ferramentas. Para conferir a instalação:

```bash
nvim '+Lazy'
nvim '+Mason'
stylua --version
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

## Diagnóstico e rollback da migração LazyVim

Use sempre o launcher autocontido:

```bash
bin/nvim --headless '+Lazy! sync' +qa
bin/nvim '+checkhealth'
```

O backup anterior à migração está em
`.state/backups/nvim-pre-lazyvim-20260812-183439.tar.gz`, com SHA-256
`f87fd15eef36068fed025c64c061c7490988763093b1a1a7ce64e7401fe19517`.
Ele inclui a configuração `nvim/`, o lockfile e as alterações locais que já
existiam. O diretório `.state/` é ignorado pelo Git.

Para rollback recuperável, feche o Neovim, valide primeiro o checksum, mova a
configuração nova para outro nome e extraia o backup na raiz:

```bash
sha256sum .state/backups/nvim-pre-lazyvim-20260812-183439.tar.gz
mv nvim nvim.lazyvim-review
tar -xzf .state/backups/nvim-pre-lazyvim-20260812-183439.tar.gz -C .
bin/nvim --headless '+Lazy! sync' +qa
```

Isso preserva a versão migrada em `nvim.lazyvim-review`; não apague nem o
backup nem esse diretório antes de validar o ambiente em uso real. Para voltar
à migração, mova o `nvim/` restaurado para outro nome e renomeie
`nvim.lazyvim-review` para `nvim`.

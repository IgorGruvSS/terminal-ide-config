# Terminal IDE config

Configuração portátil e autocontida para um ambiente terminal-first baseado em
Alacritty, tmux, Neovim e LazyGit. Não há symlinks de configuração: os arquivos
canônicos, launchers, documentação e estado local ficam neste repositório.

## Índice

- [Responsabilidades](#responsabilidades)
- [Estrutura](#estrutura)
- [Instalação rápida](#instalação-rápida)
- [Comandos](#comandos)
- [Documentação](#documentação)
- [Atualização](#atualização)

## Responsabilidades

```text
Alacritty → janela, renderização, teclado e tema (sincronizado com o KDE)
tmux      → sessões persistentes, windows e panes
Neovim    → edição, LSP, completion, navegação e ferramentas Git
LazyGit   → status, diff, stage, commit, branches, rebase e remotes
```

`alacritty-tmux` é o ponto de entrada diário. Ele abre o Alacritty com a
configuração deste repositório e conecta a uma sessão persistente do tmux.

No KDE Plasma, o tema do Alacritty acompanha a preferência claro/escuro do
sistema. O instalador habilita o serviço de usuário necessário. Para aplicá-lo
em uma instalação existente, execute novamente `./install.sh`.

## Estrutura

```text
alacritty/  configuração do Alacritty e tema Aura
bin/        launchers portáteis
docs/       documentação organizada por contexto
lazygit/    configuração versionada do LazyGit
nvim/       configuração, plugins e lockfile do Neovim
shell/      integrações versionadas com o shell
tmux.conf   configuração do tmux
```

Plugins e estado de execução são mantidos em `.local/`, `.cache/` e `.state/`.
Esses diretórios permanecem dentro do repositório, mas não são versionados.

## Instalação rápida

```bash
git clone https://github.com/IgorGruvSS/terminal-ide-config.git ~/terminal-ide-config
cd ~/terminal-ide-config
./install.sh
exec zsh
alacritty-tmux
```

Em Ubuntu e Fedora, o instalador detecta a distribuição, instala o que estiver
faltando e mantém o restante intacto. Ele pede a senha do `sudo` somente se
precisar instalar pacotes do sistema.

O processo completo, incluindo dependências e primeira inicialização, está no
[guia de instalação](docs/getting-started/installation.md).

## Comandos

| Comando | Finalidade |
| --- | --- |
| `alacritty-tmux [sessão]` | Abrir o Alacritty e conectar/criar uma sessão tmux |
| `alacritty` | Usar o Alacritty com a configuração do repositório |
| `tmux` | Usar o tmux com a configuração do repositório |
| `nvim` | Usar o Neovim e seu estado autocontido |
| `lazygit` | Usar o LazyGit gerenciado pelo repositório |
| `font <família>` | Testar temporariamente uma fonte com autocomplete no zsh |
| `font save` | Salvar a fonte atual como padrão |

## Documentação

O [índice geral da documentação](docs/README.md) organiza o conteúdo por
instalação, fluxo diário, Neovim e Git. Para uma consulta rápida, abra o
[cheatsheet diário](docs/reference/cheatsheet.md).

## Atualização

Edite os arquivos neste repositório e versione as mudanças normalmente.

- recarregar tmux: `Ctrl+B`, depois `r`;
- recarregar a integração do zsh: `source shell/zsh/terminal-ide.zsh`;
- sincronizar plugins do Neovim: `nvim '+Lazy sync'`.

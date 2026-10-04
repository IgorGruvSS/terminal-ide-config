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
Neovim    → LazyVim, edição, LSP, completion, debug, SQL e ferramentas Git
LazyGit   → status, diff, stage, commit, branches, rebase e remotes
```

`alacritty-tmux` é o ponto de entrada diário. Ele abre o Alacritty com a
configuração deste repositório e conecta a uma sessão persistente do tmux.
`codex-tmux` abre uma sessão tmux separada, chamada `codex` por padrão, para
manter as sessões do Codex independentes das janelas de código.

No KDE Plasma, o tema do Alacritty acompanha a preferência claro/escuro do
sistema. O instalador habilita o serviço de usuário necessário. Para aplicá-lo
em uma instalação existente, execute novamente `./install.sh`.

## Estrutura

```text
alacritty/  configuração do Alacritty e tema Catppuccin
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
| `codex-tmux [sessão]` | Abrir o Alacritty e conectar/criar uma sessão tmux do Codex (padrão: `codex`) |
| `alacritty` | Usar o Alacritty com a configuração do repositório |
| `tmux` | Usar o tmux com a configuração do repositório |
| `nvim` | Usar o LazyVim e seu estado XDG autocontido |
| `lazygit` | Usar o LazyGit gerenciado pelo repositório |
| `font <família>` | Testar temporariamente uma fonte com autocomplete no zsh |
| `font save` | Salvar a fonte atual como padrão |
| `alacritty-theme list` | Listar o perfil Catppuccin disponível |
| `alacritty-theme set <light\|dark>` | Selecionar Catppuccin Latte ou Macchiato |
| `alacritty-theme system` | Aplicar claro/escuro conforme a preferência do KDE |
| `terminal-alert <título> <mensagem>` | Enviar uma notificação para a área de trabalho |
| `notify-run <descrição> -- <comando>` | Executar um comando e avisar quando ele terminar |
| `codex-notifications install` | Configurar os alertas do Codex sem substituir valores existentes |

## Documentação

O [índice geral da documentação](docs/README.md) organiza o conteúdo por
instalação, fluxo diário, Neovim e Git. Para uma consulta rápida, abra o
[cheatsheet diário](docs/reference/cheatsheet.md).

Os alertas para scripts e Codex estão descritos em
[Notificações](docs/getting-started/notifications.md).

## Atualização

Edite os arquivos neste repositório e versione as mudanças normalmente.

- recarregar tmux: `Ctrl+B`, depois `r`;
- recarregar a integração do zsh: `source shell/zsh/terminal-ide.zsh`;
- sincronizar plugins do Neovim: `nvim '+Lazy sync'`;
- sincronizar plugins e ferramentas declaradas: `./install.sh`.

O launcher `bin/nvim` é parte da configuração: ele aponta configuração, plugins,
cache e estado para este repositório. Execute os diagnósticos e o Neovim diário
por `nvim`/`bin/nvim`, não chamando diretamente outro binário.

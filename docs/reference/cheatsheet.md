# Alacritty + tmux + Neovim

## Índice

- [Responsabilidades](#responsabilidades)
- [Iniciar e recuperar](#iniciar-e-recuperar)
- [Atalhos do terminal](#terminal)
- [tmux](#tmux)
- [Neovim](#neovim)
- [LazyGit](#lazygit)

## Responsabilidades

- **Alacritty:** janela, fonte, histórico e tema sincronizado com Neovim/KDE.
- **tmux:** sessões, janelas, painéis, navegação e redimensionamento.
- **Neovim:** edição, LSP, completion, debug, SQL, Neo-tree e ferramentas Git.

O Alacritty traduz `Shift+Enter`; o tmux trata seus próprios painéis e janelas.

## Iniciar e recuperar

```bash
alacritty-tmux          # sessão padrão: main
alacritty-tmux trabalho # sessão nomeada
codex-tmux              # sessão independente: codex
```

Desconecte com `Ctrl+B d`; execute o mesmo comando depois para reconectar.
O launcher prepara a sessão tmux; inicie `codex` dentro dela quando quiser
abrir o CLI.

## Terminal

| Atalho | Ação |
| --- | --- |
| `Shift+Enter` | Inserir nova linha sem enviar em TUIs compatíveis e no zsh |
| `Enter` | Enviar a mensagem ou executar o comando |

Veja o [guia de teclado](keyboard.md) para roteamento e diagnóstico.

## tmux

### Atalhos diretos

| Atalho | Ação |
| --- | --- |
| `Alt` + seta | Focar painel na direção |
| `Alt+Shift` + seta | Criar painel na direção |
| `Ctrl+Alt` + seta | Redimensionar painel |
| `Ctrl+Shift+Left` | Janela tmux anterior |
| `Ctrl+Shift+Right` | Próxima janela tmux |
| `Alt+Z` | Ampliar/restaurar painel atual |

### Alternativas com prefixo

| Teclas após `Ctrl+B` | Ação |
| --- | --- |
| `|` / `-` | Split horizontal / vertical |
| `h j k l` | Focar painel |
| `H J K L` | Redimensionar painel |
| `z` | Ampliar/restaurar painel |
| `x` | Fechar painel atual com confirmação |
| `c` | Nova janela |
| `n` / `p` | Próxima janela / anterior |
| `,` | Renomear janela atual |
| `&` | Fechar janela atual com confirmação |
| `$` | Renomear sessão atual |
| `r` | Recarregar configuração do tmux |

## Neovim

| Atalho | Ação |
| --- | --- |
| `Space e` | Alternar Neo-tree |
| `Space o` | Focar Neo-tree |
| `Space be` | Listar buffers no Neo-tree |
| `Space ff` | Buscar arquivos |
| `Space fg` | Buscar texto **literal** (`foo(` não precisa de escape) |
| `Space fr` | Buscar texto como **regex ripgrep** |
| `Space fb` | Listar buffers abertos |
| `Space fk` | Pesquisar atalhos registrados |
| `Space w` | Salvar |
| `Space qs` / `Space qS` | Restaurar / escolher sessão |
| `Space ql` / `Space qd` | Restaurar última / excluir sessão |
| `H` / `L` | Buffer anterior / seguinte |
| `Space bd` / `Space bo` | Fechar buffer atual / outros com segurança |
| `Space gg` | Abrir LazyGit na raiz Git do arquivo atual |
| `Space go` | Abrir diff do working tree |
| `Space gf` | Diff contra `origin/develop...HEAD --imply-local` |
| `Space gh` | Histórico do arquivo atual |
| `Space gc` | Fechar Diffview |
| `Space as` | Alternar auto-save (ativado ao iniciar, debounce de 3 s) |
| `Ctrl+Space` | Abrir completion |
| `Alt+D` / `Alt+Shift+D` | Adicionar / pular ocorrência multicursor |
| `Space db` / `Space dB` | Breakpoint normal / condicional |
| `Space dc` | Iniciar ou continuar debug |
| `Space dO` / `Space di` / `Space do` | Step over / into / out |
| `Space dP` / `Space dt` | Pausar / encerrar debug |
| `Space du` / `Space dr` | UI / REPL do debugger |
| `Space D` | Abrir ou fechar DBUI SQL |

Arquivos alterados por outros editores ou agentes são verificados
automaticamente. Buffers limpos recarregam com notificação; alterações locais
geram aviso de conflito e não são sobrescritas.

Comandos úteis sem atalho dedicado:

| Comando | Ação |
| --- | --- |
| `:CsvViewToggle` | Alternar visualização tabular em CSV |
| `:VimTeacher` | Abrir lições estruturadas de Vim |
| `:VimBeBetter` | Abrir exercícios de edição |

Ao fechar buffer modificado, escolha salvar, descartar ou cancelar. Um buffer
sem nome pede um caminho antes de salvar; cancelar mantém seu conteúdo.

Veja o [índice do Neovim](../neovim/README.md) para plugins, fluxos e temas.

## LazyGit

Abra com `Space gg` no Neovim ou execute `lazygit` em um repositório.

| Atalho | Ação |
| --- | --- |
| `h j k l` / setas | Navegar em painéis e itens |
| `1` / `2` / `3` / `4` / `5` | Status / arquivos / branches / commits / stash |
| `Space` | Stage/unstage ou selecionar item contextual |
| `Enter` | Abrir item ou diff selecionado |
| `c` em arquivos | Commit das mudanças em stage |
| `p` / `P` | Pull / push |
| `f` em remotes | Fetch |
| `?` | Mostrar atalhos contextuais |
| `q` | Fechar LazyGit |

Leia o [guia do LazyGit](../git/lazygit.md) para stage por hunk, log, branches,
rebase e notas de segurança.

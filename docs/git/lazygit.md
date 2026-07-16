# LazyGit no Neovim e no terminal

O LazyGit concentra o fluxo Git cotidiano em uma TUI. Ele pode ser aberto sobre
o Neovim ou executado diretamente no shell, usando a mesma configuração
versionada neste repositório.

Referência oficial: [jesseduffield/lazygit](https://github.com/jesseduffield/lazygit).

## Índice

- [Abrir](#abrir)
- [Modelo de navegação](#modelo-de-navegação)
- [Fluxo diário](#fluxo-diário)
- [Comandos ainda disponíveis](#comandos-ainda-disponíveis)

## Abrir

| Contexto | Comando |
| --- | --- |
| Dentro do Neovim | `Space gg` |
| Dentro de um repositório no shell | `lazygit` |
| Ajuda contextual | `?` dentro do LazyGit |
| Sair e voltar ao Neovim ou shell | `q` |

No Neovim, o LazyGit abre em uma janela flutuante na raiz Git do arquivo atual.
Ao fechar, o editor verifica os arquivos alterados e recarrega automaticamente
os buffers limpos. Buffers com alterações locais continuam protegidos pelo
aviso de conflito externo.

O Neovim inicia um socket local para que `e` e o editor de mensagens do Git
reutilizem a instância atual, sem criar um editor aninhado. Depois de instalar
esta integração pela primeira vez, reinicie sessões do Neovim que já estavam
abertas antes da mudança.

No shell, execute `lazygit` dentro de qualquer diretório pertencente a um
repositório. O cabeçalho e os painéis mostram o repositório, branch, remotes,
arquivos e commits, eliminando a necessidade de usar `pwd`, `ls` e
`git status` apenas para se localizar.

## Modelo de navegação

O LazyGit é inspirado no Vim, mas não possui os modos Normal, Insert e Visual.
Ele é organizado em painéis contextuais. O painel selecionado determina o que
cada tecla faz.

| Tecla | Ação comum |
| --- | --- |
| `h j k l` ou setas | Navegar entre painéis e itens |
| `1` | Status |
| `2` | Arquivos |
| `3` | Branches e remotes |
| `4` | Commits |
| `5` | Stash |
| `Enter` | Abrir ou aprofundar o item |
| `Esc` | Voltar ou cancelar |
| `/` | Filtrar o painel atual |
| `?` | Mostrar somente os atalhos válidos no contexto atual |
| `q` | Sair |

## Fluxo diário

### Status, diff e stage

1. Pressione `2` para focar os arquivos.
2. Use `j` e `k` para escolher um arquivo.
3. O diff aparece no painel principal.
4. Pressione `Space` para stage ou unstage.
5. Pressione `Enter` para selecionar hunks ou linhas individualmente.

| Tecla no painel de arquivos | Ação |
| --- | --- |
| `Space` | Stage/unstage do item |
| `a` | Stage/unstage de todos os arquivos |
| `Enter` | Abrir o diff para operar por hunk ou linha |
| `Tab` | Alternar entre alterações staged e unstaged |
| `e` | Abrir o arquivo na instância atual do Neovim |
| `d` | Descartar a alteração selecionada, após confirmação |

### Commit

Com alterações staged, pressione `c`, escreva a mensagem e confirme com
`Ctrl+Enter` ou `Ctrl+S`. Use `C` quando quiser escrever a mensagem no editor
Git.

### Fetch, pull e push

| Tecla | Ação |
| --- | --- |
| `p` | Pull da branch atual |
| `P` | Push da branch atual |
| `f` no painel de remotes | Fetch do remote selecionado |
| `R` | Atualizar o estado mostrado, sem executar fetch |

### Log e branches

Pressione `4` para ver o histórico da branch atual em formato gráfico,
decorado e compacto, equivalente ao caso de uso do `git log --oneline`.
Pressione `3` para selecionar branches, remotes e tags.

| Tecla no painel de branches | Ação |
| --- | --- |
| `Space` | Checkout |
| `n` | Nova branch |
| `r` | Rebase da branch atual sobre a branch selecionada |
| `M` | Merge da branch selecionada na branch atual |
| `Enter` | Ver os commits da branch |

### Rebase interativo

No painel de commits (`4`), os comandos mais úteis são:

| Tecla | Ação |
| --- | --- |
| `r` | Renomear/reword do commit |
| `s` | Squash no commit abaixo |
| `f` | Marcar como fixup |
| `Ctrl+J` / `Ctrl+K` | Mover commit para baixo/cima |
| `A` | Amend das mudanças staged no commit selecionado |

Pressione `m` para continuar, abortar ou pular etapas quando um merge ou rebase
estiver em andamento. Confirme sempre a branch e o commit selecionados antes de
operações que reescrevem histórico.

## Comandos ainda disponíveis

O LazyGit não bloqueia o terminal. Pressione `:` para executar um comando
Git/shell específico que não esteja exposto pela interface. Fora do Neovim,
todos os comandos Git tradicionais continuam funcionando normalmente.

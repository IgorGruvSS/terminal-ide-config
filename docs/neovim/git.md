# Git dentro do Neovim

## Índice

- [Escolher a interface](#escolher-a-interface)
- [LazyGit](#lazygit)
- [Diffview](#diffview)
- [Gitsigns](#gitsigns)

## Escolher a interface

| Necessidade | Ferramenta |
| --- | --- |
| Status, stage, commit, branch, rebase ou remote | LazyGit |
| Revisar vários arquivos ou histórico visual | Diffview |
| Perceber linhas alteradas enquanto edita | Gitsigns |

## LazyGit

`Space gg` abre o LazyGit na raiz Git do arquivo atual. Ele cobre status, diff,
stage, commit, log, branches, rebase, stash, fetch, pull e push. `q` retorna ao
buffer anterior; `?` mostra ajuda contextual.

O fluxo completo está no [guia do LazyGit](../git/lazygit.md).

## Diffview

| Atalho global | Ação |
| --- | --- |
| `Space go` | Working tree contra index |
| `Space gf` | `origin/develop...HEAD`, incluindo mudanças locais |
| `Space gh` | Histórico do arquivo atual |
| `Space gc` | Fechar Diffview |

O antigo grupo `Space d...` passou a pertencer ao debugger. Esta mudança foi
deliberada: `Space go/gf/gh/gc` mantém o Diffview agrupado com Git e libera os
atalhos oficiais de DAP.

Para outra base, use
`:DiffviewOpen origin/main...HEAD --imply-local`.

| Atalho no Diffview | Ação |
| --- | --- |
| `Tab` / `Shift+Tab` | Próximo / arquivo anterior |
| `Enter` | Abrir diff selecionado |
| `s` ou `-` | Stage / unstage |
| `S` / `U` | Stage / unstage de todos |
| `gf` | Voltar ao arquivo editável |
| `Space e` / `Space b` | Focar / alternar painel de arquivos |
| `g?` | Ajuda |

## Gitsigns

Gitsigns marca na coluna lateral as linhas adicionadas, alteradas e removidas.
Ao parar o cursor em uma linha versionada, também mostra ao fim dela o autor,
a data relativa e a mensagem do commit. Linhas ainda não commitadas são
identificadas como não confirmadas.

Ainda não há atalhos customizados; outras possíveis evoluções estão no
[estudo de integrações futuras](../git/future-integrations.md).

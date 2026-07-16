# Estudo: próximas integrações de Git e GitHub

Este documento registra as ferramentas avaliadas para depois do período de uso
do LazyGit. A regra é adicionar uma ferramenta apenas quando surgir uma lacuna
concreta, evitando interfaces duplicadas e atalhos desnecessários.

## Base atual

| Ferramenta | Responsabilidade |
| --- | --- |
| LazyGit | Status, stage, commit, branches, rebase, stash, fetch, pull, push e log |
| Diffview | Diff visual, histórico de arquivo e apoio a conflitos dentro do Neovim |
| Gitsigns | Indicadores de linhas adicionadas, alteradas e removidas |

## Candidatos

### Gitsigns com atalhos

Já está instalado, mas ainda não possui atalhos próprios. Pode complementar o
LazyGit quando a operação envolve somente o hunk sob o cursor:

- navegar entre hunks;
- preview inline;
- stage/reset do hunk atual;
- blame da linha;
- comparar o arquivo com o index ou commit anterior.

**Adicionar quando:** abrir o LazyGit apenas para um único hunk parecer pesado.

Referência: [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim).

### gh-dash

TUI do GitHub CLI para acompanhar PRs, issues e notificações com filtros e
atalhos no estilo Vim. Pode ser aberto em janela ou popup do tmux e executar
comandos customizados para o repositório selecionado.

**Complementa o LazyGit:** o LazyGit administra o Git local; o gh-dash organiza
trabalho hospedado no GitHub.

**Adicionar quando:** houver necessidade frequente de descobrir PRs esperando
review, acompanhar issues ou alternar entre vários repositórios.

Referência: [dlvhdr/gh-dash](https://github.com/dlvhdr/gh-dash).

### diffnav + delta

Pager de diff com árvore de arquivos, inspirado na tela de alterações do
GitHub. Aceita `git diff`, `git show`, diferenças de branches e a saída de
`gh pr diff`. O modo watch pode acompanhar alterações feitas por agentes.

**Possível sobreposição:** Diffview já cobre parte da revisão visual dentro do
Neovim.

**Adicionar quando:** revisões grandes, principalmente de agentes ou PRs,
continuarem difíceis no LazyGit e no Diffview.

Referências: [dlvhdr/diffnav](https://github.com/dlvhdr/diffnav) e
[dandavison/delta](https://github.com/dandavison/delta).

### Octo.nvim

Integra issues, PRs, comentários, reviewers e sugestões inline do GitHub em
buffers do Neovim.

**Possível sobreposição:** gh-dash cobre descoberta e gerenciamento; Octo é
mais forte na escrita de reviews dentro do editor.

**Adicionar quando:** comentar linhas, aprovar PRs e responder discussões sem
sair do Neovim trouxer ganho real.

Referência: [pwntester/octo.nvim](https://github.com/pwntester/octo.nvim).

### Neogit ou Fugitive

São alternativas para operações Git dentro da interface do Neovim:

- Neogit oferece uma experiência visual inspirada no Magit;
- Fugitive oferece comandos Git maduros e próximos da CLI.

Ambos sobrepõem grande parte do LazyGit. Não há motivo para instalá-los enquanto
o LazyGit atender ao fluxo local.

Referências: [NeogitOrg/neogit](https://github.com/NeogitOrg/neogit) e
[tpope/vim-fugitive](https://github.com/tpope/vim-fugitive).

## Ordem sugerida de avaliação

1. Usar o LazyGit no fluxo real.
2. Configurar atalhos do Gitsigns se faltar agilidade por hunk.
3. Testar gh-dash se a principal lacuna estiver no acompanhamento do GitHub.
4. Testar diffnav se a principal lacuna estiver na revisão de diffs grandes.
5. Considerar Octo apenas para reviews inline frequentes.
6. Evitar Neogit e Fugitive enquanto não houver uma limitação clara do LazyGit.

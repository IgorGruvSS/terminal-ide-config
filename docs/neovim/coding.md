# Edição e inteligência de código

## Índice

- [LSP](#lsp)
- [Autocompletar](#autocompletar)
- [Múltiplos cursores](#múltiplos-cursores)
- [Salvar e alterações externas](#salvar-e-alterações-externas)
- [Formatação](#formatação)
- [Markdown](#markdown)

## LSP

Os atalhos existem quando um servidor conseguiu se conectar ao buffer.

| Atalho | Ação |
| --- | --- |
| `gd` / `gr` | Ir à definição / listar referências |
| `K` | Mostrar documentação e tipo |
| `Space rn` | Renomear símbolo |
| `Space ca` | Ações de código |
| `[d` / `]d` | Diagnóstico anterior / seguinte |
| `Space d` | Detalhes do diagnóstico |

| Linguagem | Executável |
| --- | --- |
| Go | `gopls` |
| Lua | `lua-language-server` |
| JavaScript / TypeScript / Vue | `vtsls` e `vue-language-server` |
| Python | `basedpyright` ou `pyright` |
| JSON | `vscode-json-language-server` |
| YAML | `yaml-language-server` |

LazyVim e Mason fornecem a instalação global padrão. Quando um projeto possui
`node_modules/@vue/language-server`, a configuração usa essa cópia
automaticamente tanto no servidor Vue quanto no plugin TypeScript do vtsls.
Isso mantém projetos atuais simples e permite que um projeto Vue 2 fixe a linha
compatível `@vue/language-server@~3.0.0`, sem trocar manualmente a configuração
do editor. TypeScript e Prettier fixados no projeto também têm precedência.

Use `:checkhealth vim.lsp` se um atalho semântico não responder.
Mason mantém os dois servidores Python disponíveis; `basedpyright` é o
preferido e `pyright` só é habilitado quando o primeiro executável não existe,
evitando dois clientes concorrentes no mesmo buffer.

## Autocompletar

O nvim-cmp combina LSP, palavras do buffer e caminhos.

| Atalho no modo de inserção | Ação |
| --- | --- |
| `Ctrl+Space` | Abrir completion |
| `Enter` | Confirmar seleção |
| `Tab` | Confirmar sugestão; sem menu, Tab normal |
| `Shift+Tab` | Item anterior |
| `Ctrl+E` | Cancelar |

As fontes incluem LSP, snippets, caminhos e palavras dos buffers.

## Múltiplos cursores

| Atalho | Ação |
| --- | --- |
| `Alt+D` | Adicionar cursor na próxima ocorrência da palavra/seleção |
| `Alt+Shift+D` | Pular a próxima ocorrência e procurar a seguinte |
| `Esc` | Encerrar/limpar os múltiplos cursores quando a camada está ativa |

Selecione texto no modo visual ou deixe o cursor sobre uma palavra, adicione as
ocorrências e edite normalmente. Fora da camada multicursor, `Esc` continua
limpando o destaque da busca. `Ctrl+D` não foi remapeado e continua descendo
meia página.

## Salvar e alterações externas

| Atalho | Ação |
| --- | --- |
| `Space w` | Salvar |
| `Space as` | Alternar auto-save, desativado ao iniciar |
| `Space bd` / `Space bo` | Fechar buffer atual / outros com decisão segura |
| `Esc` | Limpar destaque da busca |

Quando outro editor ou agente muda um arquivo:

- buffers limpos são recarregados e geram uma notificação;
- buffers com alterações locais não são sobrescritos e mostram um conflito;
- `:checktime` permanece disponível como verificação manual.

O auto-save, quando ativado, usa debounce de 1,5 segundo e também salva ao sair
do buffer ou perder foco.

O grupo `<leader>q` é reservado às sessões do LazyVim: `Space qs` restaura uma
sessão, `Space qS` escolhe uma, `Space ql` restaura a última e `Space qd` a
exclui.

## Formatação

O Conform formata ao salvar quando o executável necessário está disponível.

| Arquivos | Formatadores |
| --- | --- |
| Lua | `stylua` |
| Go | `goimports`, com fallback para `gofmt` |
| JavaScript, TypeScript, JSX, TSX e Vue | `prettier` |
| JSON, YAML e Markdown | `prettier` |
| Python | `black` |

Use `:ConformInfo` para diagnóstico. O Prettier formata por arquivo temporário,
o que também mantém compatibilidade com projetos Vue 2 que usam Prettier 1.x.
O auto-save dispara antes do evento normal de escrita; o format-on-save ocorre
uma vez nessa escrita, sem criar uma segunda gravação ou loop.

## Markdown

`render-markdown.nvim` estiliza títulos, listas, checkboxes, tabelas e blocos.

| Comando | Ação |
| --- | --- |
| `:RenderMarkdown toggle` | Alternar fonte e renderização |
| `:RenderMarkdown buf_toggle` | Alternar apenas no buffer |
| `:RenderMarkdown preview` | Abrir prévia ao lado |

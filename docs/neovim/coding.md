# Edição e inteligência de código

## Índice

- [LSP](#lsp)
- [Autocompletar](#autocompletar)
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
| JavaScript / TypeScript | `typescript-language-server` |
| Python | `basedpyright` ou `pyright` |
| JSON | `vscode-json-language-server` |
| YAML | `yaml-language-server` |

Use `:checkhealth vim.lsp` se um atalho semântico não responder.

## Autocompletar

O nvim-cmp combina LSP, palavras do buffer e caminhos.

| Atalho no modo de inserção | Ação |
| --- | --- |
| `Ctrl+Space` | Abrir completion |
| `Enter` | Confirmar seleção |
| `Tab` | Confirmar sugestão; sem menu, Tab normal |
| `Shift+Tab` | Item anterior |
| `Ctrl+E` | Cancelar |

## Salvar e alterações externas

| Atalho | Ação |
| --- | --- |
| `Space w` | Salvar |
| `Space as` | Alternar auto-save, desativado ao iniciar |
| `Space q` | Fechar a janela |
| `Esc` | Limpar destaque da busca |

Quando outro editor ou agente muda um arquivo:

- buffers limpos são recarregados e geram uma notificação;
- buffers com alterações locais não são sobrescritos e mostram um conflito;
- `:checktime` permanece disponível como verificação manual.

O auto-save, quando ativado, usa debounce de 1,5 segundo e também salva ao sair
do buffer ou perder foco.

## Formatação

O Conform formata ao salvar quando o executável necessário está disponível.

| Arquivos | Formatadores |
| --- | --- |
| Lua | `stylua` |
| Go | `goimports`, depois `gofmt` |
| JavaScript, TypeScript, JSX e TSX | `prettier` |
| JSON, YAML e Markdown | `prettier` |
| Python | `black` |

Use `:ConformInfo` para diagnóstico. O Prettier só roda quando encontra um
diretório de projeto adequado.

## Markdown

`render-markdown.nvim` estiliza títulos, listas, checkboxes, tabelas e blocos.

| Comando | Ação |
| --- | --- |
| `:RenderMarkdown toggle` | Alternar fonte e renderização |
| `:RenderMarkdown buf_toggle` | Alternar apenas no buffer |
| `:RenderMarkdown preview` | Abrir prévia ao lado |

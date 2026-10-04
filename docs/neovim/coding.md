# Edição e inteligência de código

## Índice

- [LSP](#lsp)
- [Edição básica](#edição-básica)
- [Autocompletar](#autocompletar)
- [SQL em strings](#sql-em-strings)
- [Múltiplos cursores](#múltiplos-cursores)
- [CSV](#csv)
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

Textos e linhas virtuais de diagnóstico ficam ocultos por padrão. Os
diagnósticos continuam ativos (sinais e sublinhados permanecem) e `Space d`
mostra a mensagem sob o cursor. Inlay hints, incluindo tipos inferidos pelo
servidor Python, também iniciam ocultos; `Space uh` permite alterná-los durante
a sessão.

## Edição básica

O Flash está desativado para preservar `s` como substituição. No modo Normal,
os comandos seguem a gramática nativa do Vim: um operador recebe um movimento
ou objeto de texto.

| Comando | Ação no modo Normal |
| --- | --- |
| `s` | Apagar o caractere e entrar em Insert (`cl`) |
| `d{movimento}` | Apagar o trecho e guardá-lo; exemplo: `dw` |
| `c{movimento}` | Apagar o trecho, guardá-lo e entrar em Insert; exemplo: `ciw` |
| `x` | Apagar/guardar o caractere sob o cursor (`dl`) |
| `y{movimento}` | Copiar; exemplo: `yw` |
| `p` / `P` | Colar depois / antes |

No modo Visual, esta configuração adota ações parecidas com editores gráficos:

| Tecla | Ação sobre a seleção |
| --- | --- |
| `s` | Substituir sem sobrescrever o texto copiado |
| `d` | Apagar sem sobrescrever o texto copiado |
| `x` | Cortar |
| `y` | Copiar |

No Vim puro, `d`, `c`, `s` e `x` escrevem em registradores; por isso todos
podem parecer “cortar”. A diferença principal é o que selecionam e se entram
ou não no modo Insert. O registrador especial `"_` usado pelos atalhos visuais
de `d` e `s` descarta o texto e preserva o conteúdo que será colado com `p`.

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

## SQL em strings

O `tree-sitter-language-injection.nvim` aplica o parser SQL dentro de strings
marcadas em arquivos Python, Go, JavaScript e TypeScript, inclusive em blocos
`<script>` de arquivos Vue. Em Python, coloque a anotação imediatamente acima
da atribuição:

```python
# sql
query = """
SELECT id, name
FROM users
WHERE active = TRUE
"""
```

Em JavaScript e TypeScript, use o mesmo formato com `// sql`:

```typescript
// sql
const query = `
  SELECT id, name
  FROM users
  WHERE active = TRUE
`;
```

Em Go, coloque `/* sql */` imediatamente antes da string:

```go
query := /* sql */ `
  SELECT id, name
  FROM users
  WHERE active = TRUE
`
```

Uma template string JavaScript/TypeScript também pode carregar a marcação
por dentro, iniciando seu conteúdo com `--sql`. A anotação é intencional: ela
evita tratar qualquer string comum como SQL. O recurso fornece parsing e
highlight; autocomplete, validação e formatação SQL dentro da string exigem
integrações adicionais.

Arquivos SQL usam `sqlfluff` para lint e formatação. O lint roda pelo
`nvim-lint`, preservando o diretório do arquivo para encontrar configurações
locais do SQLFluff. A formatação usa o dialeto PostgreSQL como padrão e passa
`--stdin-filename` para respeitar configurações por projeto.

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

## CSV

`csvview.nvim` fornece visualização estruturada e navegação por campos em
arquivos CSV e similares.

| Comando ou tecla | Ação |
| --- | --- |
| `:CsvViewToggle` | Alternar visualização tabular no buffer atual |
| `:CsvViewEnable` / `:CsvViewDisable` | Ativar / desativar explicitamente |
| `Tab` / `Shift+Tab` | Campo seguinte / anterior |
| `Enter` / `Shift+Enter` | Linha seguinte / anterior, mantendo a coluna |
| `if` / `af` | Text objects de campo interno / campo completo |

Linhas iniciadas por `#` ou `//` são tratadas como comentários.

## Salvar e alterações externas

| Atalho | Ação |
| --- | --- |
| `Space w` | Salvar |
| `Space as` | Alternar auto-save, ativado ao iniciar |
| `Space bd` / `Space bo` | Fechar buffer atual / outros com decisão segura |
| `Esc` | Limpar destaque da busca |

Quando outro editor ou agente muda um arquivo:

- buffers limpos são recarregados e geram uma notificação;
- buffers com alterações locais não são sobrescritos e mostram um conflito;
- `:checktime` permanece disponível como verificação manual.

Os buffers permanecem abertos ao trocar de arquivo, sem limpeza automática. A
fonte `Buffers` no Neo-tree fornece uma lista dedicada; a barra horizontal do
`bufferline.nvim` fica desativada.

O auto-save inicia ativado, usa debounce de 3 segundos e também salva ao sair do
buffer ou perder foco.

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
| SQL | `sqlfluff` |
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

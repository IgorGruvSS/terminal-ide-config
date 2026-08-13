# Matriz da migração para LazyVim

Esta matriz registra as equivalências verificadas e as duas decisões tomadas
antes da edição conflitante.

| Antes | Depois | Estado e motivo |
| --- | --- | --- |
| Bootstrap e specs manuais do `lazy.nvim` | LazyVim 16.0.0 + Extras em `nvim/lazyvim.json` | Base coerente; customizações locais continuam pequenas |
| Telescope configurado à mão | Extra Telescope + atalhos preservados | Mantido; `Space fg` agora é literal e `Space fr` regex |
| Neo-tree configurado à mão | Extra Neo-tree + opções locais | Mantido com ocultos/ignorados visíveis, reveal e fechamento da última janela |
| `nvim-cmp` e fontes LSP/path/buffer | Extra nvim-cmp + override de teclas | Mantidos `Ctrl+Space`, `Enter`, `Tab`, `Shift+Tab`, `Ctrl+E` |
| LSPs declarados manualmente | Extras de Go, Python, Vue, JSON e YAML + Mason | Mesma cobertura, instalação declarativa |
| Vue local obrigatório | Vue/vtsls oficial, preferindo `@vue/language-server` local quando existe | Menos gestão; Vue 2 pode fixar `~3.0.0`, demais projetos usam Mason |
| `basedpyright`, fallback manual para `pyright` | Ambos no Mason; somente basedpyright ativa quando disponível | Fallback preservado sem dois clientes concorrentes |
| Conform manual | Conform do LazyVim + tabela local preservada | Stylua, goimports/gofmt, Prettier e Black mantidos |
| Auto-save desativado, 1,5 s | Mesmo plugin e eventos + formatação explícita antes da escrita | Corrigida a primeira escrita sem criar loop |
| Treesitter e parsers manuais | Core/Extras + lista complementar | Cobertura anterior preservada, com SQL/Markdown inline |
| Render Markdown, Gitsigns, indentação, ícones e WhichKey specs próprias | Recursos do core/Extras | Mesmos plugins, sem specs locais duplicadas |
| LazyGit por plugin dedicado | Integração LazyGit do Snacks/LazyVim | `Space gg` continua usando a raiz Git correta |
| Diffview em `Space d...` | Diffview em `Space go/gf/gh/gc` | Decisão aprovada; `Space d...` ficou livre para DAP |
| Temas e `theme-sync.lua` | Todos preservados sobre a base LazyVim | Mesmos seis pares e também Omni, Nightfox e TokyoNight |
| Sem múltiplos cursores | `multicursor.nvim` branch `1.0` | `Alt+D` adiciona, `Alt+Shift+D` pula; `Ctrl+D` nativo |
| Fechamento padrão de buffers | Bufferline + diálogo Salvar/Descartar/Cancelar | Buffers modificados e sem nome nunca são descartados silenciosamente |
| Sem debugger integrado | Extras DAP core, Go e Python | UI, breakpoints, steps, REPL, scopes e variáveis |
| Sem UI SQL integrada | Extra SQL com Dadbod UI/completion | Conexões locais/por ambiente, sem credenciais versionadas |

## Decisões de conflito

1. Os atalhos antigos do Diffview foram removidos do grupo `Space d...` por
   decisão do proprietário. O grupo Git escolhido é `Space go`, `Space gf`,
   `Space gh` e `Space gc`; DAP usa os atalhos oficiais `Space d...`.
2. Para Vue, foi escolhida a estratégia híbrida recomendada: defaults oficiais
   do LazyVim e Mason, com detecção automática da linguagem Vue instalada no
   projeto. Assim, a exceção de Vue 2 permanece local somente onde é necessária.

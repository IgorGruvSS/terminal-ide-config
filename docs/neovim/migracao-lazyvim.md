# Matriz da configuração LazyVim

Esta matriz registra somente as diferenças locais mantidas sobre o LazyVim e
as decisões que evitam conflitos com seus defaults.

| Antes | Depois | Estado e motivo |
| --- | --- | --- |
| Bootstrap e specs manuais do `lazy.nvim` | LazyVim + Extras em `nvim/lazyvim.json` | Base e defaults vêm do LazyVim; specs locais ficam pequenas |
| Telescope configurado à mão | Extra Telescope + dois atalhos locais | `Space fg` usa busca literal; `Space fr` mantém regex ripgrep |
| Neo-tree configurado à mão | Extra Neo-tree + opções e atalhos locais | Ocultos/ignorados visíveis, reveal, `Space e` e `Space o` |
| `nvim-cmp` e fontes LSP/path/buffer | Extra nvim-cmp + override de teclas | Mantidos `Ctrl+Space`, `Enter`, `Tab`, `Shift+Tab`, `Ctrl+E` |
| LSPs declarados manualmente | Extras de Go, Python, Vue, JSON e YAML + Mason | Cobertura e instalação declarativas do LazyVim |
| Vue local obrigatório | Vue/vtsls oficial, preferindo `@vue/language-server` local quando existe | Menos gestão; Vue 2 pode fixar `~3.0.0`, demais projetos usam Mason |
| `basedpyright`, fallback manual para `pyright` | Ambos no Mason; somente basedpyright ativa quando disponível | Fallback preservado sem dois clientes concorrentes |
| Conform manual | Conform do LazyVim + tabela local preservada | Stylua, goimports/gofmt, Prettier e Black mantidos |
| Auto-save desativado, 1,5 s | Mesmo plugin e eventos, agora ativado com 3 s + formatação explícita antes da escrita | Corrigida a primeira escrita sem criar loop |
| Treesitter e parsers manuais | Core/Extras + lista complementar efetiva | Cobertura preservada, incluindo SQL, Vue e Markdown inline |
| Render Markdown, Gitsigns, indentação, ícones e WhichKey specs próprias | Recursos do core/Extras | Mesmos plugins, sem specs locais duplicadas |
| LazyGit por plugin dedicado | Integração LazyGit do Snacks/LazyVim | `Space gg` continua usando a raiz Git correta |
| Diffview em `Space d...` | Diffview em `Space go/gf/gh/gc` | Decisão aprovada; `Space d...` ficou livre para DAP |
| Temas e `theme-sync.lua` | Catppuccin + sincronização local | Latte no claro, Macchiato no escuro, com Alacritty e KDE |
| Sem múltiplos cursores | `multicursor.nvim` branch `1.0` | `Alt+D` adiciona, `Alt+Shift+D` pula; `Ctrl+D` nativo |
| Fechamento padrão de buffers | `Space bd`/`Space bo` + diálogo local | Buffers modificados e sem nome exigem decisão explícita |
| Sem debugger integrado | Extras DAP core, Go e Python | UI, breakpoints, steps, REPL, scopes e variáveis |
| Sem UI SQL integrada | Extra SQL com Dadbod UI/completion | Conexões locais/por ambiente, sem credenciais versionadas |

O grupo `<leader>q` continua sendo o grupo de sessões do LazyVim: `Space qs`
restaura, `Space qS` escolhe uma sessão, `Space ql` restaura a última e
`Space qd` exclui uma sessão. O fechamento seguro de buffers fica em `Space bd`
e `Space bo`; não há um mapping local concorrente para esses comandos.

## Decisões de conflito

1. Os atalhos antigos do Diffview foram removidos do grupo `Space d...` por
   decisão do proprietário. O grupo Git escolhido é `Space go`, `Space gf`,
   `Space gh` e `Space gc`; DAP usa os atalhos oficiais `Space d...`.
2. Para Vue, foi escolhida a estratégia híbrida recomendada: defaults oficiais
   do LazyVim e Mason, com detecção automática da linguagem Vue instalada no
   projeto. Assim, a exceção de Vue 2 permanece local somente onde é necessária.

# Debug Go/Python e SQL

## Debugger (DAP)

O Extra oficial de DAP abre a interface de scopes, variáveis, stacks e watches
ao iniciar uma sessão e a fecha ao terminar. O Extra de Go usa Delve e
`nvim-dap-go`; o de Python usa debugpy e `nvim-dap-python`. Mason instala esses
adaptadores, enquanto `Space cv` seleciona um ambiente virtual Python quando
necessário.

| Atalho | Ação |
| --- | --- |
| `Space db` / `Space dB` | Alternar breakpoint / criar condicional |
| `Space dc` | Iniciar ou continuar |
| `Space dP` | Pausar |
| `Space dO` / `Space di` / `Space do` | Step over / into / out |
| `Space dR` / `Space dl` | Reiniciar / repetir última sessão |
| `Space dt` | Encerrar |
| `Space du` | Alternar a UI |
| `Space de` | Avaliar expressão ou seleção |
| `Space dw` | Inspecionar valor sob o cursor |
| `Space dr` | Alternar REPL |
| `Space dPt` / `Space dPc` | Debug do método / classe Python |

Fluxo mínimo: abra o programa, marque uma linha com `Space db`, pressione
`Space dc` e escolha a configuração. Quando o breakpoint for atingido, use a
UI ou `Space dw`/`Space de` para inspecionar estado. Finalize com `Space dt`.
Use `:checkhealth dap` e `:Mason` quando um adaptador não iniciar.

## SQL com Dadbod

`Space D` alterna a DBUI. Nela, `A` adiciona uma conexão, `Enter` abre um item e
`d` remove a entrada selecionada. Em um buffer de query associado à conexão,
selecione SQL visualmente e use `Space S`; sem seleção, o mesmo atalho executa
a query atual. Completion de tabelas e colunas aparece quando o Dadbod conhece
o schema da conexão.

O highlight combina Treesitter com as regras tradicionais de syntax do
Neovim. Esse fallback mantém funções, tipos e identificadores destacados mesmo
quando placeholders Python DB-API, como `%(ano)s`, interrompem o parsing
estrutural de uma consulta PostgreSQL. Isso é independente de LSP.

Nunca coloque URL, usuário ou senha em arquivo versionado. Duas opções seguras:

```bash
export DATABASE_URL='postgresql://usuario:senha@host/banco'
```

```lua
-- .lazy.lua na raiz do projeto; este repositório ignora o arquivo
vim.g.dbs = { projeto = vim.env.DATABASE_URL }
return {}
```

Também é possível cadastrar a URL interativamente na DBUI; o estado fica no
diretório XDG local e ignorado deste repositório. O arquivo `.gitignore` cobre
`.lazy.lua`, `.env` e `.env.*` (exceto um `.env.example` sem segredos). Antes de
versionar qualquer exemplo, confira `git diff` e `git status --short`.

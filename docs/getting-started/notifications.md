# Notificações de desktop

O ambiente usa o serviço de notificações do Linux para avisos visíveis no KDE e
reproduz um som curto pela sessão de áudio ao enviar cada aviso. O áudio usa
`paplay` ou `pw-play` e o tema de sons Freedesktop instalado no sistema. Defina
`TERMINAL_ALERT_SOUND=0` para silenciar um comando específico.
O instalador garante `notify-send` e, quando o Codex CLI já estiver instalado,
configura os alertas dele. Em uma instalação existente, execute:

```bash
./install.sh
```

ou, somente para o Codex:

```bash
codex-notifications install
```

O comando preserva um `notify` e valores de `[tui]` já definidos em
`~/.codex/config.toml`. Rode `codex-notifications status` para conferir o que
está efetivamente configurado e `codex-notifications test` para enviar um aviso
de teste.

## Codex TUI

O Codex envia uma notificação da área de trabalho ao concluir cada turno,
inclusive os turnos de agentes. A mensagem diz apenas que a resposta está
pronta e o nome do diretório, sem copiar conteúdo da conversa para o centro de
notificações.

Além disso, a configuração TUI habilita o método nativo do terminal para
pedidos de aprovação e perguntas do modo de plano. Ela é emitida mesmo quando
o terminal está em foco para que uma tarefa não fique parada sem sinal. O
terminal decide se apresenta isso como alerta visual, sino ou notificação.

## Scripts

Para um aviso simples no fim de qualquer script:

```bash
terminal-alert "Importação concluída" "Os dados de setembro já estão disponíveis."
```

Para preservar o resultado do comando e ainda avisar em sucesso ou falha:

```bash
notify-run "Atualização das dependências" -- npm update
```

`notify-run` retorna o mesmo código de saída do comando executado. Por isso
ele pode ser usado em automações sem transformar uma falha em sucesso.

# Teclado: Alacritty, tmux e zsh

## Índice

- [Shift+Enter](#shiftenter)
- [Trocar a fonte](#trocar-a-fonte)
- [Como a tecla atravessa as camadas](#como-a-tecla-atravessa-as-camadas)
- [Recarregar](#recarregar)
- [Diagnóstico](#diagnóstico)

## Shift+Enter

`Shift+Enter` representa uma quebra de linha sem enviar o conteúdo atual:

- no ChatGPT/Codex e em TUIs compatíveis, cria uma nova linha no campo;
- no zsh interativo, insere uma quebra literal no comando atual;
- `Enter` continua enviando a mensagem ou executando o comando.

## Trocar a fonte

Digite `font ` e pressione `Tab` para completar as fontes monoespaçadas
instaladas:

```bash
font JetBrainsMono\ Nerd\ Font\ Mono
font Source\ Code\ Pro
```

A troca afeta temporariamente apenas a janela atual do Alacritty.

| Comando | Ação |
| --- | --- |
| `font current` | Mostrar a fonte usada pela janela |
| `font list` | Listar fontes disponíveis |
| `font save` | Salvar a fonte atual como padrão |
| `font reset` | Restaurar a configuração de `alacritty.toml` |

Depois de testar uma fonte, execute `font save`. O comando grava a família
atual em `alacritty/alacritty.toml`; novas janelas passam a usá-la por padrão.

## Como a tecla atravessa as camadas

1. O Alacritty envia `Shift+Enter` como a sequência estendida `CSI 13;2u`.
2. O tmux mantém suporte a teclas estendidas e repassa a sequência.
3. A aplicação interpreta a tecla; no zsh, a integração versionada adiciona a
   quebra ao buffer de edição.

Usar uma sequência própria evita confundir `Shift+Enter` com o `Enter` comum.

## Recarregar

Após mudar a configuração:

```bash
source shell/zsh/terminal-ide.zsh
```

No tmux, pressione `Ctrl+B`, depois `r`. O Alacritty precisa ser reaberto após
alterações em `alacritty/alacritty.toml`.

## Diagnóstico

- se a tecla funciona fora do tmux, revise `extended-keys` em `tmux.conf`;
- se funciona em uma TUI, mas não no shell, confirme que o arquivo de integração
  aparece no `~/.zshrc`;
- se imprime caracteres como `[13;2u`, a aplicação não reconhece a sequência e
  precisa de uma configuração própria.

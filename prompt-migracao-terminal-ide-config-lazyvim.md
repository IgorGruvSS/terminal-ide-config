# Migração segura do `terminal-ide-config` para LazyVim

Você é uma pessoa engenheira sênior de Neovim, Lua, LazyVim e Linux. Trabalhe diretamente no meu computador e no repositório existente `terminal-ide-config`. Sua missão é migrar a configuração atual do Neovim para uma base LazyVim, adicionar os recursos descritos abaixo e deixar o ambiente instalado, documentado e testado.

Não quero apenas instruções. Execute a migração no repositório e no ambiente local, dentro das permissões disponíveis. Não faça `push`, não abra PR e não publique nada. Ao final, deixe as mudanças locais prontas para minha revisão.

## Objetivo e motivação

Quero manter um ambiente terminal-first baseado em Alacritty, tmux, Neovim e LazyGit, mas reduzir o trabalho manual de descobrir como instalar e integrar cada plugin. LazyVim deve fornecer uma base coerente e atualizável para plugins, LSPs, formatadores, linters e debuggers, enquanto minhas customizações ficam pequenas, explícitas e documentadas.

A migração deve resolver estes problemas:

1. **Gerenciamento de plugins e ferramentas:** hoje preciso inferir especificações do `lazy.nvim` e configurar manualmente várias integrações. Use recursos nativos do LazyVim, `:LazyExtras`/imports oficiais e Mason sempre que forem adequados. Customizações próprias devem existir apenas quando o LazyVim não cobre o comportamento necessário.
2. **Edição simultânea estilo VS Code:** preciso selecionar ocorrências sucessivas com um atalho simples, pular uma ocorrência e editar todos os cursores. Isso deve ser feito sem remover o `Ctrl+D` nativo do Vim, que desce meia página.
3. **Busca literal versus regex:** nunca deve ser ambíguo se a busca de texto no projeto interpreta regex. Quero dois comandos/atalhos separados, com descrições inequívocas na interface.
4. **Buffers compreensíveis e seguros:** preciso visualizar quais arquivos estão abertos ou modificados, alternar e fechar buffers sem encerrar o Neovim à força. Um buffer sem nome ou modificado nunca pode causar perda silenciosa de texto; a interface deve oferecer um caminho claro para salvar, descartar ou cancelar.
5. **Debug real para backend:** preciso de DAP funcionando para Go e Python, com interface, breakpoints, step over/into/out, continue, inspeção de variáveis e encerramento da sessão.
6. **SQL:** preciso editar e executar queries SQL com uma interface utilizável, completion quando possível e conexões sem versionar credenciais.

## Fonte de verdade e arquitetura que devem ser preservadas

Antes de alterar qualquer coisa, inspecione o estado real do computador e do repositório. As informações abaixo descrevem o estado conhecido, mas os arquivos locais atuais são a fonte de verdade:

- O repositório é portátil e autocontido. Não transforme a configuração em dotfiles espalhados e não substitua essa arquitetura por uma instalação comum em `~/.config/nvim`.
- `bin/nvim` define `XDG_CONFIG_HOME`, `XDG_DATA_HOME`, `XDG_STATE_HOME` e `XDG_CACHE_HOME` para apontar ao repositório. A configuração canônica fica em `nvim/`, e plugins/estado ficam em `.local/`, `.state/` e `.cache/` do projeto.
- `install.sh` atualmente gerencia, entre outros itens, Neovim 0.12.4, Tree-sitter CLI 0.26.11, LazyGit 0.62.0 e JetBrainsMono Nerd Font 3.4.0, com suporte a Ubuntu/Debian e Fedora.
- Alacritty, tmux, launchers, integração zsh, entrada do KDE e serviço de sincronização de tema não fazem parte da migração para LazyVim e não podem regredir.
- `nvim/lua/theme-sync.lua`, os comandos `:ThemeSync` e `:ThemeCurrent`, a leitura de `.local/state/alacritty-theme` e a sincronização claro/escuro com KDE e Alacritty devem continuar funcionando.
- Preserve os perfis e temas existentes: Aura/PaperColor, Alabaster, Modus, Flexoki, GitHub e Catppuccin. Não remova outros temas já instalados sem demonstrar que são realmente obsoletos e obter minha autorização.
- Preserve a detecção de alterações externas: buffers limpos recarregam com notificação; buffers com mudanças locais não são sobrescritos e exibem aviso de conflito.
- Preserve `number`, `mouse=a`, `scrolloff=8`, `sidescrolloff=8`, `ignorecase`, `smartcase`, `termguicolors`, `autoread`, `list` e os caracteres atuais de `listchars`, salvo conflito real com o LazyVim.
- O auto-save atual começa desativado, é alternado por `Space as`, usa debounce de 1,5 segundo e salva também em eventos seguros como saída do buffer/perda de foco. Preserve esse comportamento real, inclusive a ordem correta entre salvar e formatar.
- Preserve o comportamento de formatação atual: Conform; Stylua para Lua; `goimports`/`gofmt` para Go; Prettier para JS/TS/JSX/TSX/Vue/JSON/YAML/Markdown; Black para Python. Projetos Vue 2 com Prettier 1.x precisam continuar funcionando.
- Preserve cobertura LSP para Go, Lua, JavaScript, TypeScript, Vue, Python, JSON e YAML. Preserve especialmente a compatibilidade existente com Vue 2, servidor Vue local ao projeto, integração TypeScript/Vue e `basedpyright` com fallback para `pyright`.
- Preserve Treesitter e os parsers atuais para Bash, CSS, Go, Go modules, HTML, JavaScript, JSON, Lua, Markdown, Python, TSX, TypeScript, Vue e YAML.
- Preserve Markdown enriquecido, cores inline, delimitadores coloridos, guias de indentação, ícones, Gitsigns, Diffview e LazyGit.
- Preserve o Neo-tree com arquivos ocultos e ignorados visíveis, acompanhamento do arquivo atual e fechamento quando for a última janela, a menos que exista uma substituição comprovadamente equivalente e eu a autorize diante do conflito.
- Preserve Telescope e seus comportamentos/atalhos conhecidos, salvo substituição comprovadamente equivalente e aprovada por mim. Não troque ferramentas apenas porque o padrão atual do LazyVim é diferente.
- Preserve completion com LSP, caminhos e buffer, além dos comportamentos de `Ctrl+Space`, `Enter`, `Tab`, `Shift+Tab` e `Ctrl+E`. Pode usar Blink ou manter `nvim-cmp`, mas somente se os comportamentos forem verificados como equivalentes.
- Preserve todos os atalhos existentes, especialmente:
  - `Space ff`, `Space fg`, `Space fb`, `Space fh`, `Space fk`;
  - `Space e`, `Space o`;
  - `Space w`, `Space q`, `Space as`;
  - `Space gg`;
  - `Space do`, `Space df`, `Space dh`, `Space dc`;
  - `gd`, `gr`, `K`, `Space rn`, `Space ca`, `[d`, `]d`, `Space d`.
- `Space df` deve continuar comparando `origin/develop...HEAD --imply-local`.
- O uso de `Esc` para limpar o destaque da busca deve continuar funcionando quando não houver uma sessão de múltiplos cursores ativa.

## Regra absoluta: nenhuma regressão silenciosa

Não presuma que “o padrão do LazyVim é melhor” e não remova funcionalidade existente por conveniência. Faça uma matriz **antes → depois** de plugins, atalhos e comportamentos.

Se encontrar qualquer conflito em que duas alternativas mudem comportamento, ergonomia, manutenção ou compatibilidade, pare **antes de editar a parte conflitante** e me pergunte. A pergunta deve conter:

1. o conflito concreto, com arquivos, plugins e atalhos envolvidos;
2. o comportamento atual;
3. as alternativas possíveis;
4. prós, contras e sua recomendação;
5. exatamente qual decisão você precisa de mim.

Continue em paralelo apenas com alterações independentes e seguras. Não use uma escolha provisória em uma área conflitante. Exemplos que exigem pergunta: trocar Telescope por FzfLua/Snacks Picker, trocar Neo-tree por outro explorer, trocar `nvim-cmp` por Blink quando algum atalho mudar, trocar Black por Ruff format, alterar a estratégia Vue 2 ou remover temas/plugins atuais.

## Processo obrigatório

### 1. Auditoria e segurança

1. Localize o repositório real e confirme sua raiz com Git.
2. Leia completamente `README.md`, `install.sh`, `bin/nvim`, `nvim/init.lua`, todo `nvim/lua/`, `nvim/lazy-lock.json`, `docs/neovim/` e os documentos de instalação/cheatsheet relevantes.
3. Execute `git status --short` e preserve mudanças minhas, inclusive arquivos não rastreados. Se uma mudança minha se sobrepuser à migração, pare e pergunte.
4. Registre versões reais de Neovim, Git, LazyGit, Tree-sitter, tmux, Alacritty, ripgrep, fd/fdfind, Node/npm, Go e Python.
5. Crie um backup datado e recuperável da configuração e do lockfile fora dos diretórios que serão modificados. Não use `rm -rf`, `git reset --hard`, `git checkout --` nem comandos destrutivos.
6. Consulte a documentação oficial atual do LazyVim e dos plugins antes de implementar. Não copie configurações antigas de blogs. Prefira a versão estável do LazyVim e APIs compatíveis com o Neovim instalado.
7. Apresente a matriz antes → depois e resolva comigo os conflitos reais antes de prosseguir nessas partes.

### 2. Integração do LazyVim

Adapte a estrutura oficial do LazyVim Starter à pasta `nvim/` deste repositório. Não clone o starter diretamente sobre `~/.config/nvim` e não quebre o launcher `bin/nvim`.

A configuração deve:

- inicializar `lazy.nvim` e importar `LazyVim/LazyVim` conforme a documentação oficial atual;
- manter customizações em `nvim/lua/config/` e `nvim/lua/plugins/`, com arquivos pequenos, nomeados por responsabilidade;
- usar imports oficiais de LazyVim Extras quando disponíveis, em vez de reproduzir grandes configurações manualmente;
- usar Mason/Mason-related integrations para instalar ferramentas suportadas de forma declarativa e reproduzível;
- manter no `install.sh` apenas dependências de sistema realmente necessárias, com detecção idempotente para Ubuntu/Debian e Fedora;
- preservar o ambiente XDG autocontido, o lockfile e a capacidade de reinstalar tudo por `./install.sh`;
- evitar configurações duplicadas entre defaults do LazyVim, extras e specs próprias;
- documentar claramente como adicionar um plugin futuro, habilitar um Extra e instalar/diagnosticar uma ferramenta pelo Mason.

Avalie e habilite, usando os nomes oficiais vigentes no momento da execução, os Extras equivalentes a:

- DAP core;
- Go;
- Python;
- SQL;
- TypeScript/JavaScript;
- Vue;
- JSON;
- YAML;
- Markdown;
- Telescope, caso seja necessário para preservar a experiência existente;
- `nvim-cmp`, caso seja necessário para preservar a experiência existente.

Não copie a configuração interna completa de um Extra para o repositório. Importe o Extra e sobrescreva apenas o necessário.

### 3. Múltiplos cursores

Use `jake-stewart/multicursor.nvim`, branch estável `1.0`, salvo se a documentação oficial atual indicar uma migração incompatível que exija minha decisão.

Implemente obrigatoriamente:

```lua
vim.keymap.set({ "n", "x" }, "<M-d>", function()
  mc.matchAddCursor(1)
end, { desc = "Adicionar próxima ocorrência" })

vim.keymap.set({ "n", "x" }, "<M-D>", function()
  mc.matchSkipCursor(1)
end, { desc = "Pular próxima ocorrência" })
```

Comportamento esperado:

- `Alt+D`: adicionar a próxima ocorrência da palavra/seleção;
- `Alt+Shift+D`: pular a próxima ocorrência e avançar;
- `Esc`: encerrar/limpar os múltiplos cursores quando a camada do plugin estiver ativa;
- fora dessa camada, `Esc`: continuar limpando o destaque da busca;
- `Ctrl+D`: permanecer intocado e continuar descendo meia página.

Verifique colisões no Neovim, tmux e Alacritty. Confirme que `<M-d>` e `<M-D>` chegam como teclas distintas. Se o terminal não distingui-las, não invente outro atalho: mostre o diagnóstico e me pergunte.

### 4. Busca literal e regex explícitas

Mantenha `/` como busca regex do próprio Vim. Para busca no projeto, crie dois fluxos inequívocos no picker preservado:

- `Space fg`: **buscar texto literal**, passando `--fixed-strings` ao ripgrep; caracteres como `(` não devem exigir escape;
- `Space fr`: **buscar com regex ripgrep**;
- as descrições no WhichKey/picker devem conter explicitamente “literal” e “regex”;
- ambos devem respeitar smart case e trabalhar na raiz correta do projeto;
- preserve os demais atalhos de arquivos, buffers, ajuda e keymaps.

Não faça uma única busca que alterne silenciosamente de modo. Se a API do picker escolhido não permitir argumentos separados por chamada, trate como conflito e me pergunte antes de trocar o picker.

### 5. Buffers com UX segura

Configure a experiência de buffers para ser visível e previsível:

- `vim.opt.confirm = true`;
- linha de buffers/abas com nome do arquivo, indicador de modificação e diagnósticos quando aplicável;
- `H` e `L` para buffer anterior/próximo, se não houver conflito com um comportamento que eu já uso;
- `Space bd` para fechar o buffer atual preservando a janela quando possível;
- `Space bo` para fechar os outros buffers;
- `Space fb` para listar buffers;
- ações de fechar devem perguntar salvar/descartar/cancelar quando houver alterações;
- um buffer sem nome e modificado deve mostrar orientação clara para fornecer um nome e salvar, descartar ou cancelar;
- nenhuma ação comum de fechar pode exigir `q!`, matar o processo ou reiniciar o Neovim;
- nunca descarte conteúdo automaticamente.

Use os recursos nativos do LazyVim/Snacks/Bufferline quando cobrirem isso; evite criar uma camada grande de código próprio.

### 6. LSP, completion, formatação e instalação de ferramentas

Preserve todos os comportamentos atuais e reduza a instalação manual:

- Go: `gopls`, formatadores existentes e ferramentas necessárias;
- Python: preferência atual por `basedpyright`, fallback para `pyright`, Black como formatador e suporte a ambientes virtuais;
- Lua: `lua-language-server` e Stylua;
- JS/TS/Vue: LSP e Prettier, mantendo Vue 2 e Prettier 1.x funcionais;
- JSON/YAML: LSP, schemas quando oferecidos pelo Extra e Prettier;
- Treesitter: todos os parsers atuais, sem perder highlight ou injeções Vue/Markdown;
- completion: LSP, caminhos, buffer e snippets, preservando os atalhos atuais.

Mason deve instalar declarativamente o que ele gerencia. Dependências de projeto devem continuar locais ao projeto quando necessário; não substitua versões fixadas de Vue/TypeScript/Prettier por globais incompatíveis.

### 7. Debugger/DAP

Habilite o Extra oficial de DAP core e as integrações oficiais de Go e Python:

- Go com Delve e `nvim-dap-go` ou sucessor oficial recomendado;
- Python com debugpy e `nvim-dap-python` ou sucessor oficial recomendado;
- DAP UI aberta/fechada de forma previsível;
- breakpoint normal e condicional;
- continue, pause, step over, step into, step out, restart e terminate;
- REPL e inspeção de scopes/variáveis;
- ícones/sinais legíveis com a Nerd Font existente;
- atalhos documentados no WhichKey e no cheatsheet.

Crie programas mínimos temporários, fora dos meus projetos, para verificar que os adaptadores iniciam. Não afirme que o debug funciona apenas porque os plugins carregaram.

### 8. SQL

Habilite o Extra oficial de SQL e sua UI, completion e integração Dadbod quando ainda forem a solução oficial. Garanta:

- abrir a UI, cadastrar/selecionar conexão e executar a seleção/query atual;
- edição e highlight de SQL;
- completion quando houver conexão/schema disponível;
- documentação dos atalhos essenciais;
- nenhuma URL, senha, token ou credencial versionada;
- conexões via variável de ambiente ou arquivo local ignorado, como `.lazy.lua`, somente se permitido pela documentação atual;
- atualização do `.gitignore` para impedir vazamento de credenciais.

Não crie nem teste conexão contra banco real sem minha autorização. Testes podem usar SQLite temporário local se a dependência já existir ou puder ser instalada sem privilégio; caso contrário, limite-se à validação estrutural e informe a pendência manual.

### 9. Preservação das integrações atuais

Depois da migração, valide explicitamente:

- Neo-tree ou a solução aprovada mantém `Space e`, `Space o`, arquivos ocultos/ignorados visíveis e operações de arquivo;
- Telescope ou a solução aprovada mantém `Space ff`, `Space fg`, `Space fr`, `Space fb`, `Space fh`, `Space fk` e abertura em split/aba;
- LazyGit abre em `Space gg` na raiz Git correta;
- Diffview mantém todos os atalhos e o diff contra `origin/develop`;
- Gitsigns continua exibindo mudanças;
- renderização de Markdown, cores, indentação e delimitadores continuam disponíveis;
- todos os temas existentes carregam e `ThemeSync`/`ThemeCurrent` funcionam;
- mudanças externas continuam recarregando buffers limpos e protegendo buffers modificados;
- auto-save permanece desativado ao iniciar e alternável em `Space as` com debounce de 1,5 segundo;
- format-on-save não entra em loop com auto-save;
- `Ctrl+D` não foi remapeado globalmente.

### 10. Documentação

Atualize `README.md`, `docs/neovim/`, `docs/reference/cheatsheet.md` e o guia de instalação apenas onde a migração alterar o uso real. Documente em português:

- o que o LazyVim passou a gerenciar e por quê;
- diferença prática entre LazyVim, `lazy.nvim`, Mason, LSP, Conform e DAP;
- como usar `:Lazy`, `:LazyExtras`, `:Mason`, `:ConformInfo` e os health checks;
- como adicionar um plugin sem adivinhar a spec;
- múltiplos cursores e como pular uma ocorrência;
- busca literal versus regex, incluindo exemplos com parênteses;
- modelo mental curto de buffer, janela e tab;
- como salvar/fechar um buffer modificado ou sem nome;
- atalhos de DAP para Go/Python;
- uso seguro da UI SQL sem versionar segredos;
- procedimento de rollback usando o backup criado.

Evite documentação genérica ou copiada. Ela deve corresponder exatamente aos arquivos e atalhos implementados.

## Validação obrigatória

Execute testes no launcher real `bin/nvim`, porque uma execução direta do binário pode ignorar o XDG autocontido.

1. Instalação idempotente: execute `./install.sh` dentro do escopo seguro e confirme que uma segunda execução não quebra nem reinstala desnecessariamente. Se precisar de `sudo` ou alterar pacotes do sistema, explique e peça autorização antes.
2. Sincronização: execute o equivalente atual de `bin/nvim --headless "+Lazy! sync" +qa` e confirme saída zero sem erros Lua.
3. Health checks: Lazy, Mason, LSP, Treesitter, Conform, DAP e providers relevantes sem erros impeditivos. Diferencie warnings esperados de falhas reais.
4. Startup: inicialização headless e interativa sem stacktrace, plugins duplicados ou módulos ausentes.
5. Atalhos: verifique programaticamente as mappings e faça uma lista dos testes interativos que realmente exigem teclado/terminal.
6. Linguagens: em arquivos temporários de Go, Python, Lua, TypeScript, Vue 2, JSON, YAML, Markdown e SQL, confirme filetype, parser, LSP esperado quando aplicável e formatador configurado.
7. Formatação: execute casos mínimos e confirme o resultado, incluindo Go, Python e um projeto temporário Vue 2/Prettier 1.x compatível com o comportamento atual.
8. DAP: inicie e encerre sessões mínimas de Go e Python, atingindo ao menos um breakpoint em cada linguagem.
9. Busca: prove que `Space fg` encontra literalmente texto contendo `(` sem escape e que `Space fr` aceita uma expressão regex real.
10. Buffers: teste buffer salvo, modificado e sem nome; fechamento deve preservar dados e oferecer decisão explícita.
11. Tema: teste `ThemeCurrent`, `ThemeSync` e pelo menos os pares claro/escuro configurados, sem remover os demais temas.
12. Alterações externas: teste reload de buffer limpo e proteção de buffer modificado.
13. Git: valide LazyGit, Diffview e Gitsigns sem executar push, commit, rebase ou qualquer mutação remota.
14. Qualidade: rode `shellcheck` nos scripts alterados, formatação Lua e verificações pertinentes disponíveis.
15. Revisão final: confira `git diff --check`, `git status --short` e o diff completo. Não inclua caches, downloads, estados locais, credenciais ou backups no Git.

## Critérios de aceite

A tarefa só está concluída quando todos os itens abaixo forem verdadeiros:

- [ ] `bin/nvim` inicia o LazyVim usando exclusivamente a arquitetura XDG autocontida do repositório.
- [ ] `./install.sh` funciona em Ubuntu/Debian e Fedora e é idempotente.
- [ ] LazyVim e os Extras escolhidos estão declarados de forma mínima, oficial e sem specs duplicadas.
- [ ] `:Lazy`, `:LazyExtras` e `:Mason` abrem e não apresentam erro impeditivo.
- [ ] A configuração anterior foi mapeada para a nova e nenhuma funcionalidade/atalho desapareceu sem minha aprovação explícita.
- [ ] Temas e sincronização Alacritty/KDE/Neovim continuam funcionando.
- [ ] Auto-reload externo, aviso de conflito e proteção contra sobrescrita continuam funcionando.
- [ ] Neo-tree, Telescope, LazyGit, Diffview, Gitsigns, Markdown enriquecido e melhorias visuais continuam disponíveis ou foram substituídos apenas após minha aprovação.
- [ ] LSP funciona para Go, Python, Lua, JS/TS/Vue, JSON e YAML; Vue 2 continua compatível.
- [ ] Formatação funciona para todos os tipos atuais, incluindo Vue 2 com Prettier 1.x e Python com Black.
- [ ] Completion preserva `Ctrl+Space`, `Enter`, `Tab`, `Shift+Tab` e `Ctrl+E`.
- [ ] `Alt+D` adiciona a próxima ocorrência e `Alt+Shift+D` pula a próxima.
- [ ] `Esc` encerra múltiplos cursores quando ativos e limpa busca quando não estão ativos.
- [ ] `Ctrl+D` continua executando meia página para baixo.
- [ ] `Space fg` é busca literal e aceita `(` sem escape.
- [ ] `Space fr` é busca regex e aceita regex ripgrep válida.
- [ ] Buffers modificados ou sem nome nunca são descartados silenciosamente e podem ser resolvidos sem matar o Neovim.
- [ ] A navegação/fechamento de buffers está visível, tem descrições no WhichKey e possui testes documentados.
- [ ] DAP atinge breakpoint e permite inspecionar estado em programas mínimos de Go e Python.
- [ ] SQL UI abre, executa SQL em ambiente temporário quando possível e não versiona credenciais.
- [ ] Todos os atalhos novos e preservados estão documentados no cheatsheet.
- [ ] Instalação headless, health checks, testes de linguagem e `git diff --check` passam.
- [ ] O Git contém apenas arquivos de configuração/documentação intencionais; nenhum cache, segredo, banco temporário ou backup foi adicionado.
- [ ] Existe um procedimento de rollback testado ou claramente verificável.

Se algum critério não puder ser atendido, não declare sucesso parcial como conclusão. Identifique o item, a evidência da falha, o impacto e a decisão ou ação necessária.

## Entrega final

Ao terminar, responda de forma objetiva com:

1. arquivos alterados;
2. decisões técnicas e motivação de cada uma;
3. matriz final antes → depois;
4. testes executados e resultados;
5. critérios de aceite atendidos e pendentes;
6. conflitos que eu resolvi e a alternativa escolhida;
7. instruções mínimas de uso diário e rollback.

Não esconda warnings, não afirme que algo foi testado quando foi apenas inspecionado e não recomende remover o backup antes de eu validar o ambiente no uso real.

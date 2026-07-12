# Nori — guia de configuração

O Nori é o mascote do Aurum. Tudo o que ele fala, quando fala, com que humor e com que frequência é controlado pelos arquivos JSON desta pasta — **sem precisar mexer no código do app**.

Depois de editar qualquer arquivo aqui, salve e rode o `subir-para-github.bat` (na raiz do projeto) para publicar.

## Por que a configuração é separada em vários arquivos

Antes, cada "situação" do Nori tinha a regra (quando falar) e o texto (o que falar) juntos no mesmo objeto. Isso funcionava com poucas frases, mas escalar para centenas exigiria duplicar as mesmas condições em cada uma. Agora:

- **`rules.json`** decide **quando** o Nori fala.
- **`dialogs.json`** guarda **o que** ele fala (o texto).
- **`moods.json`** define os **humores** (cor, ícone, animação padrão).
- **`animations.json`** cataloga as **animações** disponíveis.
- **`events.json`** define **eventos especiais** (marcos, datas).
- **`variables.json`** documenta as **variáveis** que dá pra usar no texto.
- **`personalities.json`** define **perfis de personalidade**.
- **`tips.json`** guarda **dicas educacionais** avulsas.

Uma regra nunca contém texto. Um grupo de diálogo nunca contém condições. Isso significa: quer adicionar 50 frases novas pra uma situação que já existe? Só mexe em `dialogs.json`. Quer mudar a condição que dispara uma situação? Só mexe em `rules.json`. Nada se duplica.

---

## Como criar uma nova situação

Uma "situação" = 1 regra em `rules.json` + 1 grupo de frases em `dialogs.json` com o mesmo nome.

**Passo 1** — adicione a regra em `rules.json`:

```json
{
  "id": "cartao_perto_do_limite",
  "dialog": "cartao_perto_do_limite",
  "priority": 65,
  "cooldown_days": 3,
  "max_per_week": 2,
  "max_per_month": null,
  "repeatable": true,
  "enabled": true,
  "conditions": [
    { "metric": "net", "op": "<", "value": 500 }
  ]
}
```

**Passo 2** — crie o grupo de mesmo nome (`dialog`) em `dialogs.json`:

```json
"cartao_perto_do_limite": {
  "mood": "warning",
  "phrases": [
    { "title": "Seu cartão tá quase no limite.", "sub": "Vale segurar um pouco os gastos.", "weight": 3 },
    { "title": "Atenção com o limite do cartão.", "sub": "Faltam só uns trocados pra estourar.", "weight": 2 }
  ]
}
```

Pronto. O `id` da regra pode ser qualquer texto único (sem espaços/acentos, por convenção `snake_case`). O `dialog` da regra tem que ser exatamente igual à chave do grupo em `dialogs.json`.

### Campos de uma regra

| Campo | O que faz |
|---|---|
| `id` | Identificador único da regra. |
| `dialog` | Nome do grupo de frases em `dialogs.json` que essa regra usa. |
| `priority` | Quando várias regras batem ao mesmo tempo, a de maior número vence. |
| `cooldown_days` | Depois de mostrar essa situação, espera esses dias antes de poder mostrar de novo (do zero — 0 = sem espera). |
| `max_per_week` / `max_per_month` | Limite de quantas vezes essa situação pode ser *ativada* (não *exibida*) num período. `null` = sem limite. |
| `repeatable` | Reservado para uso futuro (situações não-repetíveis, tipo "só uma vez na vida"). Hoje eventos (`events.json`) já cobrem esse caso. |
| `enabled` | `false` desliga a regra sem precisar apagar nada. |
| `conditions` | Lista de condições — **todas** precisam ser verdadeiras (E lógico). Lista vazia `[]` = sempre bate (use isso na regra de menor prioridade, como situação padrão). |

### Condições disponíveis (`metric`)

| Métrica | Significado |
|---|---|
| `net` | Saldo do mês em R$ (receita − despesa) |
| `net_pct` | Saldo ÷ receita, de 0 a 1 |
| `income` | Receita total do mês em R$ |
| `expense` | Despesa total do mês em R$ |
| `goals_count` | Quantidade de metas cadastradas |
| `goals_completed` | Quantidade de metas já concluídas |
| `investments_total` | Total investido em R$ |
| `expense_change_pct` | Despesa desta semana ÷ da semana anterior (1.15 = +15%) |
| `ledger_count` | Quantidade de lançamentos no extrato |

Operadores: `>`, `>=`, `<`, `<=`, `==`.

### Condições por categoria

Pra criar regras tipo "muito gasto com Uber" ou "muito gasto com iFood", adicione `category` na condição e use uma destas métricas:

| Métrica | Significado |
|---|---|
| `category_expense` | Total gasto (R$) nessa categoria, no mês |
| `category_count` | Número de lançamentos nessa categoria, no mês |
| `category_expense_pct` | Gasto na categoria ÷ despesa total do mês |

```json
{ "metric": "category_expense_pct", "category": "Uber", "op": ">", "value": 0.12 }
```

`category` precisa bater com o nome exato da categoria (o `label`, não o `key`) — confira em Configurações do app. Veja o exemplo real em `rules.json` (`muito_uber`).

---

## Como adicionar 100 novas frases pra uma situação que já existe

Só edite o array `phrases` do grupo correspondente em `dialogs.json`. Cada frase é:

```json
{ "title": "Frase principal", "sub": "Frase secundária (opcional)", "weight": 2 }
```

Não precisa duplicar nada de `rules.json` — quantas frases você quiser, a regra continua sendo uma só. O app sorteia uma frase por peso toda vez que a situação é ativada pela primeira vez (a mesma frase fica fixa enquanto a situação continuar ativa — ela não troca a cada segundo, só quando a situação muda de fato).

## Peso das frases (`weight`)

Frases com peso maior aparecem com mais frequência. Se não colocar `weight`, o padrão é `1`. Alguns exemplos:

- 3 frases com peso `3`, `2`, `1` → a de peso 3 aparece 3x mais que a de peso 1.
- Pra fazer uma frase rara/especial, use peso `1` num grupo onde as outras têm peso `3`+.

---

## Como usar variáveis

Dentro de `title`/`sub` em `dialogs.json`, escreva `{nome}` e o app substitui pelo valor real. Exemplo:

```json
{ "title": "Você gastou {amount} com {category}.", "sub": "Já é bastante." }
```

Variáveis prontas pra usar (veja a lista completa e o que cada uma faz em `variables.json`): `{amount}`, `{category}`, `{goal}`, `{investment}`, `{income}`, `{expense}`, `{month}`, `{days}`, `{card}`, `{topCategory}`, `{goalProgress}`, `{investmentYield}`.

Duas variáveis (`{merchant}`, `{remainingBudget}`) estão documentadas mas **ainda não funcionam** — o app não tem esses dados hoje. Não use elas em frases novas ainda; `variables.json` marca isso com `"supported": false`.

---

## Como criar um novo humor

Adicione uma entrada em `moods.json`:

```json
"orgulhoso": {
  "label": "Orgulhoso",
  "color": "#3DDC91",
  "default_animation": "happyBounce"
}
```

Depois, use o nome desse humor (`orgulhoso`) no campo `mood` de um grupo em `dialogs.json`, ou em uma frase específica (uma frase pode ter seu próprio `mood`, sobrescrevendo o do grupo). O Nori troca a cor dos olhos pra essa cor. Se a animação (`default_animation`) ainda não estiver implementada visualmente (veja a próxima seção), o Nori só muda a cor — sem quebrar nada.

## Como adicionar uma animação

Toda animação precisa de uma entrada em `animations.json`:

```json
"piscar": {
  "duration_ms": 200,
  "loop": false,
  "implemented": false,
  "description": "Pisca os olhos rapidamente."
}
```

**Importante**: criar a entrada aqui documenta a animação, mas **não cria o efeito visual sozinha**. Animações de movimento de verdade (pular, dançar, chorar etc.) exigem código de CSS/SVG feito à parte — isso é trabalho de front-end, não é configuração. Use `"implemented": false` até que o efeito exista de fato; assim fica claro no catálogo o que já funciona e o que é só planejado. Hoje só `idle`, `celebrate`, `shake`, `lookChart` e `worried` têm efeito visual (os adereços do mascote).

---

## Como criar uma nova personalidade

Adicione em `personalities.json`:

```json
"sarcastico": { "label": "Sarcástico", "description": "Ironia fina sobre seus hábitos." }
```

Depois, marque frases específicas em `dialogs.json` com essa personalidade:

```json
{ "title": "Ah, mais um Uber. Que surpresa.", "sub": "", "weight": 2, "personality": ["sarcastico"] }
```

Frases **sem** o campo `personality` aparecem em **qualquer** perfil ativo — é assim que as frases originais continuam funcionando sem precisar marcar nada. Uma frase pode pertencer a mais de uma personalidade: `"personality": ["motivador", "professor"]`.

A personalidade *ativa* hoje é a definida em `"active"` no topo de `personalities.json` (padrão: `equilibrado`), a menos que o dispositivo já tenha uma preferência salva localmente — e agora dá pra trocar isso direto pela aba "Personalidade" do Nori Studio (Configurações → Personalização → Nori Studio), sem precisar editar arquivo nenhum. Veja a seção "Nori Studio" mais abaixo.

---

## Como evitar repetições

Três mecanismos, combináveis:

1. **`weight`** em cada frase — várias frases por situação, sorteadas.
2. **`cooldown_days`** na regra — espera X dias antes da situação poder ativar de novo.
3. **`max_per_week`** / **`max_per_month`** na regra — limite de ativações num período.

Isso tudo é rastreado no `localStorage` do próprio aparelho (não fica salvo pra sempre em lugar nenhum — se a pessoa limpar os dados do navegador, os contadores zeram).

Repare que cooldown/limite controlam quando uma situação pode **começar** a aparecer — uma vez que já está ativa (ex: o saldo continua negativo dia após dia), ela continua sendo mostrada normalmente, sem ser interrompida pelo próprio cooldown.

---

## Como adicionar um novo evento

Eventos (`events.json`) são situações especiais, geralmente de uma vez só, com prioridade sobre as regras normais. Adicione:

```json
{ "id": "aniversario_do_app", "trigger": "date:03-15", "dialog": "evento_aniversario_app", "once": "yearly" }
```

E o grupo correspondente em `dialogs.json`:

```json
"evento_aniversario_app": {
  "mood": "celebration",
  "phrases": [{ "title": "O Aurum fez aniversário! 🎉", "sub": "Obrigado por confiar no app." }]
}
```

Gatilhos (`trigger`) disponíveis hoje:

| Trigger | Dispara quando |
|---|---|
| `first_ledger_entry` | O primeiro lançamento da conta é criado |
| `first_goal_created` | A primeira meta é criada |
| `goal_completed` | Qualquer meta é concluída pela primeira vez |
| `date:MM-DD` | Chega essa data do calendário (ex: `date:12-25` = Natal) |

`"once": "always"` dispara uma única vez na vida da conta. `"once": "yearly"` dispara uma vez por ano (funciona pros gatilhos `date:`).

`user_birthday` está documentado em `events.json` mas **não funciona ainda** — o cadastro do app não coleta data de nascimento hoje. Se quiser essa funcionalidade, é preciso primeiro adicionar esse campo ao cadastro/perfil.

---

## Como testar uma situação

Duas formas:

**Pelo Nori Studio (mais fácil)** — aba "Simular": preencha os campos com valores fictícios (saldo, receita, despesa, categoria etc.) e clique em "Simular". Ele roda as mesmas regras do app de verdade contra esses números e mostra qual situação venceria e a frase que apareceria. Não precisa mexer nos seus dados reais nem publicar nada — é só um teste local, na hora.

**Direto no app publicado, com dados reais:**

1. Abra o site publicado (ou `web/index.html` local) com o Console do navegador aberto (F12).
2. Ajuste temporariamente seus dados reais (ex: crie um lançamento que deixe o saldo negativo) para bater a condição que você quer testar.
3. Recarregue a Dashboard — o card do Nori mostra o resultado.
4. Pra forçar um novo sorteio de frase sem mexer em dados (útil pra ver as várias frases de um mesmo grupo), rode no Console: `window.__noriDebug.reset()`.
5. Outros atalhos úteis no Console: `window.__noriDebug.state()` mostra a situação atual resolvida; `window.__noriDebug.metrics()` mostra os números (saldo, receita, despesa etc.) que as condições enxergam; `window.__noriDebug.pack()` mostra o pacote de configuração inteiro carregado dos JSONs.

---

## Nori Studio (editor dentro do app)

Configurações → Personalização → Nori Studio. Uma tela com 4 abas pra editar tudo isso sem tocar em nenhum arquivo:

- **Situações** — lista todas as regras ordenadas por prioridade. Toque numa pra editar (condições, prioridade, cooldown, limites, humor e todas as frases do grupo), use as setas ▲▼ pra reordenar (isso ajusta a `priority`), o interruptor pra ativar/desativar sem excluir, o ícone de duplicar pra criar uma variante rápida, e "+ Nova situação" pra criar do zero. A busca filtra por identificador ou texto das frases.
- **Humores** — lista os humores existentes (cor + animação padrão). Toque pra editar ou "+ Novo humor" pra criar um novo humor com sua própria cor. Não deixa excluir um humor que ainda está em uso por alguma situação (mostra quantas).
- **Personalidade** — no topo, os chips pra trocar a personalidade ativa: isso aplica **na hora**, é a única parte do Studio que já reflete no app de verdade sem precisar exportar/publicar nada (fica salvo no aparelho). Abaixo, a lista de perfis de personalidade pra criar/editar/excluir.
- **Simular** — descrito na seção anterior.

**Importante sobre persistência**: exceto a personalidade ativa, **nada do que você edita no Studio muda o Nori "ao vivo" automaticamente**. O app continua sendo um site estático sem banco de dados por trás do Nori — o Studio trabalha numa cópia local (na memória da aba aberta) e não salva sozinho. Pra publicar de verdade:

1. Edite o quanto quiser no Studio (situações, humores, personalidades).
2. Toque no ícone de download no canto superior direito da tela do Studio. Isso baixa 4 arquivos: `rules.json`, `dialogs.json`, `moods.json` e `personalities.json`.
3. Substitua os arquivos correspondentes dentro de `web/nori/` no seu projeto pelos que acabaram de baixar.
4. Rode o `subir-para-github.bat` pra publicar.

Se você fechar a aba ou recarregar a página sem exportar, as edições feitas no Studio se perdem (a cópia é só local, em memória) — os arquivos em `web/nori/` não são tocados até você substituí-los manualmente.

---

## Compatibilidade

As 6 situações que existiam antes (`saldo_negativo`, `sem_reserva`, `meta_concluida`, `gastos_subindo`, `sobra_para_investir`, `tudo_azul`) foram migradas 1:1 pra cá, com as mesmas condições de antes — o comportamento do Nori não muda para quem já usava o app. A diferença é que agora cada uma tem várias frases (não só uma), e dá pra adicionar quantas quiser sem duplicar as regras.

---

## O que ainda não existe

- Animações de movimento de verdade (a maioria das listadas em `animations.json` está catalogada mas não implementada visualmente ainda — o Nori Studio deixa você escolher qualquer animação pra um humor, mas o efeito visual só existe de fato pras que estão marcadas `"implemented": true`).
- Exibição automática das dicas de `tips.json` em algum lugar do app.
- Gatilho de aniversário do usuário (`user_birthday`).
- Eventos (`events.json`) e variáveis/`tips.json` ainda não têm editor no Nori Studio — pra esses, continue editando o arquivo JSON direto.

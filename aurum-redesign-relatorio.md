# Aurum — Relatório de redesign visual

Resumo do redesign feito no app (`web/index.html`), tela por tela, com foco em elevar a identidade visual para um padrão mais sóbrio e premium (menos "template neon", mais "produto financeiro sério"), corrigindo bugs reais encontrados na auditoria.

## Fase 1 — Design System + Dashboard

**Fundo e identidade visual**
- Removido o "chão de grade" ciano animado e o overlay de scanline (efeito cyberpunk/gamer) — trocado por uma aurora de fundo mais suave, com só 2 tons em vez de 4 cores competindo entre si.
- Removidos os anéis giratórios multicoloridos do avatar e do botão flutuante (FAB) — eram decorativos, sem propósito funcional. Trocados por feedback de toque (escala ao pressionar).
- Removida a pulsação infinita do FAB — ficava "vivo" demais para um botão persistente na tela.

**Bugs corrigidos**
- Card "Gastos por categoria": a tag `<div class="donut-row glass tilt3d"` estava sem o `>` de fechamento, quebrando a renderização do SVG do gráfico donut.
- Padrão de animação de entrada (`opacity:0` + animação `forwards`) trocado em **todo o app** — não só no calendário — por um padrão à prova de falha: elementos já nascem visíveis (`opacity:1`) e só a posição/escala é animada. Isso elimina a classe de bug que causou o "só aparece o dia 9" no calendário, em qualquer outro lugar do app.

**Ícones**
- Todos os emojis usados como ícone de interface (setas de receita/despesa, ícones de assinatura) trocados por SVG consistente.

**Composição**
- O banner de "insight" e o card do mascote Nori — que repetiam a mesma informação de duas formas — foram unidos em um único card.
- Os cards de Receitas/Despesas foram unidos dentro do card de Fluxo de Caixa (eram números duplicados em cards separados).
- Resultado: a Dashboard caiu de 9 cards empilhados para 7, com menos ruído e mais foco nos números.

**Material dos cards**
- `.glass` ganhou mais profundidade (sombra em camadas, reflexo sutil no topo, leve saturação no blur) para parecer mais "físico".

## Fase 2 — Transações

- Linhas de transação: o destaque vermelho/verde (pedido em uma conversa anterior) foi refinado — trocado o degradê forte cobrindo a linha toda por uma barra de acento fina (3px) + tingimento bem mais sutil.
- **Substituído o `confirm()` nativo do navegador** (popup genérico do sistema, quebrava a imersão do app) por um sheet de confirmação customizado, no mesmo estilo visual do resto do app. Essa troca foi feita de forma abrangente: os 6 lugares do app que usavam `confirm()` (excluir transação, categoria, meta, investimento, cartão, resetar todos os dados) agora usam esse componente único e reaproveitável.
- Ícone do estado vazio ("Nada por aqui") trocado de emoji para SVG.
- Adicionada contagem de lançamentos no cabeçalho ("X lançamentos") para dar hierarquia à tela.

## Fase 3 — Metas

- Cards de meta ganharam feedback de toque (escala ao pressionar) e um estado visual de "concluída" (brilho dourado sutil) quando a meta é atingida.
- Cor do texto de previsão trocada de ciano para dourado, alinhando com a paleta reduzida.
- Cabeçalho ganhou contador ("X metas").

## Fase 4 — Investimentos

- Linhas da lista de investimentos ganharam um ícone de tendência (seta para cima/baixo, colorida por resultado) — antes eram só texto sem hierarquia visual.
- Ícone do estado vazio trocado de emoji para SVG.
- Cabeçalho ganhou contador ("X posições").

## Fase 5 — Cartões

- O placeholder de texto `)))` que simulava o símbolo de contactless foi trocado por um ícone SVG de contactless de verdade.
- Cards de cartão ganharam mais profundidade (sombra em camadas, reflexo de luz sutil no canto superior) e feedback de toque.
- Ícone do estado vazio trocado de emoji para SVG.
- Cabeçalho ganhou contador ("X cartões").

## Fase 6 — Configurações e navegação

- Botão de voltar: estava depois do título (ordem invertida) e era um caractere de texto "←". Movido para a posição convencional (esquerda, antes do título) e trocado por um ícone SVG de seta.
- Ícone de "apagar todos os lançamentos" trocado de emoji (🗑️) para SVG.
- Linha de reset de dados ganhou feedback de toque consistente com o resto do app.

## O que ficou de fora (proposital)

- **Ícones de categoria e de meta** (ex.: 🛒 🚗 🏠 para categorias, 🎯 para metas): continuam emoji. Diferente dos ícones de interface, esses são escolhidos pelo próprio usuário ao criar uma categoria/meta — é personalização, não ícone de sistema, então não faz sentido "consertar" isso sem construir um seletor de ícones novo (fora do escopo deste redesign visual).
- **Dados estáticos**: a seção "Gastos por categoria" e "Assinaturas" da Dashboard ainda usam valores fixos de exemplo (não conectados ao ledger real). Ficou fora do escopo porque é mudança de funcionalidade/dados, não de visual.

## Oportunidades para uma v2.0

- Conectar "Gastos por categoria" e "Assinaturas" a dados reais do ledger.
- Implementar swipe-to-delete nas listas (hoje é tap + sheet de confirmação — funcional, mas swipe é mais rápido).
- Seletor de ícones customizado (substituindo o campo de emoji livre) para categorias e metas.
- Seção "Próximas contas" (mencionada como referência de composição de dashboard) — hoje coberta parcialmente por "Assinaturas".
- Sistema de toast/notificação in-app para substituir o `alert()` que ainda existe após apagar todos os dados.

## Pendência

Todas essas mudanças estão só no arquivo local. Para publicar, rode o `subir-para-github.bat` como de costume.

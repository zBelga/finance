# Aurum — Wireframes Descritivos

Descrição vertical, de cima para baixo, de cada tela. Todas as telas usam margem lateral de 20pt e fundo `mesh.wealth` ou `mesh.calm` sutil sobre `bg.base`.

## 1. Dashboard (implementada nesta entrega)

1. **Header simples**: saudação contextual pequena ("Boa noite, Fabricio" — `footnote`, `ink.tertiary`) + ícone de olho (mostrar/ocultar valores) + avatar circular pequeno à direita.
2. **Hero de Patrimônio** (`glass.heroCard`, altura ~210pt): label "Patrimônio total" (`subheadline`, `ink.secondary`), valor em `display` com contagem animada, badge de variação mensal (↑/↓ %, cor emerald/coral), sparkline de fundo ocupando a parte inferior do card com gradiente. Toque expande (matched geometry) para detalhe futuro.
3. **Faixa de Calendário Financeiro** (scroll horizontal): pequenos "chips" de dia com indicador de evento financeiro (conta a pagar, recebimento previsto), dia atual destacado com glow gold.
4. **Seção "Fluxo de caixa"**: título de seção (`title2`) + segmented tabs (Semana/Mês/Ano) + `CustomLineChart` de entradas vs. saídas, com legenda mínima (dois dots coloridos + valor total ao lado, não legenda tradicional de biblioteca de gráficos).
5. **Duas colunas — Receitas / Despesas** (`glass.thin`, lado a lado): cada card mostra valor total do período + mini variação percentual + ícone de tendência; toque abre detalhe.
6. **Seção "Objetivos"** (scroll horizontal de cards): cada card mostra `ProgressRing` pequeno + nome da meta + valor atual/alvo; card de "Nova meta" ao final (dashed border, ghost).
7. **Seção "Investimentos"**: card único resumindo valor total investido + `CustomLineChart` compacto (mini) + badge de rentabilidade do período.
8. **Seção "Cartões"** (scroll horizontal): mini-mockups de cartão com gradiente da bandeira, limite usado como barra fina na base do próprio cartão.
9. **Seção "Assinaturas"**: lista compacta (ícone do serviço + nome + valor mensal + badge "renova em Xd"), até 3 itens visíveis + "ver todas".
10. **Respiro final**: espaço de 64pt antes do fim do scroll, para a `FloatingTabBar` nunca cobrir conteúdo.

A `FloatingTabBar` fica sobreposta, flutuando, com leve blur do conteúdo que passa por baixo dela.

## 2. Transações (placeholder estilizado nesta entrega)

Header "Transações" (`title1`) + segmented tabs por categoria + lista com agrupamento por dia (label de data em `caption`, `ink.tertiary`), cada linha com ícone de categoria (badge), nome do estabelecimento (`headline`), categoria (`footnote`), valor à direita (`headline`, cor conforme sinal). Estado atual: empty state estilizado + estrutura pronta para receber dados reais.

## 3. Metas (placeholder estilizado)

Grid de cards de meta em 2 colunas, cada um com `ProgressRing`. Botão flutuante "+" para nova meta. Estado atual: empty state com ilustração line-art + CTA "Criar minha primeira meta".

## 4. Investimentos (placeholder estilizado)

Hero com valor total investido + gráfico grande de evolução. Lista de posições abaixo (placeholder). Estado atual: estrutura visual pronta, dados mock mínimos.

## 5. Cartões (placeholder estilizado)

Carrossel de cartões em tamanho real (proporção de cartão físico) com paginação por dots customizados. Abaixo, fatura atual e limite. Estado atual: 2 cartões mock navegáveis.

## 6. Detalhe de item (novo, criação rápida)

`fullScreenCover` com fundo blurred da tela anterior, formulário com inputs de floating label, seletor de categoria em grid de badges, botão primário fixo no rodapé com safe area respeitada. (Especificado para próxima etapa de implementação.)

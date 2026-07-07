# Aurum — Design System

Todos os tokens abaixo têm implementação 1:1 em `Sources/DesignSystem/`. Este documento é a fonte da verdade; o código apenas espelha estes valores.

## 1. Cor

### 1.1 Escala de fundo (obsidiana)
| Token | Hex | Uso |
|---|---|---|
| `bg.base` | `#0A0A0C` | Fundo raiz do app |
| `bg.elevated1` | `#131317` | Fundo de seções/sheets |
| `bg.elevated2` | `#1B1B20` | Cards não-glass, inputs |
| `bg.elevated3` | `#24242B` | Elementos sobre cards (chips, tags) |

### 1.2 Escala de cinza (texto e ícones)
| Token | Hex/Opacidade | Uso |
|---|---|---|
| `ink.primary` | `#F5F5F7` @ 92% | Títulos, valores principais |
| `ink.secondary` | `#F5F5F7` @ 64% | Subtítulos, labels |
| `ink.tertiary` | `#F5F5F7` @ 40% | Legendas, timestamps |
| `ink.quaternary` | `#F5F5F7` @ 18% | Divisores, placeholders |

### 1.3 Cores de destaque
| Token | Hex | Uso |
|---|---|---|
| `accent.gold` | `#D9B776` | Patrimônio, destaque premium, CTA primário |
| `accent.goldGlow` | `#F0D9A8` | Glow/gradiente sobre o gold |
| `accent.emerald` | `#3DDC91` | Receita, valores positivos, metas concluídas |
| `accent.coral` | `#FF7A6E` | Despesa, alertas suaves, valores negativos |
| `accent.azure` | `#6FB8FF` | Investimentos, informação neutra/link |
| `accent.violet` | `#B79CFF` | Assinaturas/recorrências |

Regra de uso: **no máximo 2 accents por tela** além do gold (que é sempre permitido como cor de marca).

### 1.4 Gradientes de mesh (fundo)
Gradiente radial multi-ponto, extremamente sutil (opacidade 6–14%), nunca ocupando mais que 100% da tela com blur forte (`radius: 120–180pt`):
- `mesh.wealth`: gold → transparente, ancorado no canto superior direito.
- `mesh.calm`: azure → violet → transparente, ancorado no canto inferior esquerdo.
- `mesh.alert`: coral → transparente, usado só em telas de erro/atenção.

## 2. Tipografia

Fonte do sistema (SF Pro) em dois modos:
- **SF Pro Display / Text** — títulos, corpo, labels.
- **SF Pro Rounded** — todo e qualquer valor monetário ou numérico, sempre com `.monospacedDigit()`.

| Estilo | Tamanho/Peso | Uso |
|---|---|---|
| `display` | 40pt / Bold / Rounded | Valor hero (patrimônio total) |
| `title1` | 28pt / Bold | Título de tela |
| `title2` | 22pt / Semibold | Título de seção |
| `title3` | 18pt / Semibold | Título de card |
| `headline` | 16pt / Semibold | Linhas de lista em destaque |
| `body` | 16pt / Regular | Texto corrido |
| `callout` | 15pt / Regular | Descrições secundárias |
| `subheadline` | 14pt / Medium | Labels de campo |
| `footnote` | 13pt / Regular | Legendas de gráfico |
| `caption` | 11pt / Medium / tracking +0.4 | Tags, timestamps, categorias |

Regra: nunca mais de 3 estilos tipográficos na mesma tela visível de uma vez (ex.: title2 + body + caption).

## 3. Espaçamento (grid de 4pt)

`space.xxs=4 · space.xs=8 · space.sm=12 · space.md=16 · space.lg=24 · space.xl=32 · space.xxl=48 · space.xxxl=64`

Margem lateral padrão de tela: `20pt`. Gap padrão entre cards de uma mesma seção: `12–16pt`. Gap entre seções: `32–40pt`.

## 4. Raio de borda

`radius.xs=8 · radius.sm=12 · radius.md=16 · radius.lg=20 · radius.xl=28 · radius.pill=999`

Cards "hero" usam `xl`; cards secundários `lg`; chips/badges `pill`; inputs `md`.

## 5. Sombra (luz física, não decoração)

Toda sombra é composta por **duas camadas** (ambient + key), nunca uma sombra única e dura:

| Token | Ambient | Key |
|---|---|---|
| `shadow.resting` | `black 18% · blur 20 · y 8` | `black 8% · blur 2 · y 1` |
| `shadow.raised` | `black 28% · blur 32 · y 16` | `black 12% · blur 4 · y 2` |
| `shadow.floating` (FAB, sheets) | `black 36% · blur 48 · y 24` | `accent.gold 10% · blur 16 · y 0` |

## 6. Blur, Glass e Materiais

- `glass.thin` = `.ultraThinMaterial` + borda `white 10%` 1pt + `shadow.resting`. Uso: cards padrão.
- `glass.regular` = `.thinMaterial` + borda `white 12%` 1pt + `shadow.raised`. Uso: sheets, modais.
- `glass.heroCard`: `glass.thin` + gradiente interno diagonal (`white 6% → transparente`) simulando reflexo de vidro + glow externo `accent.gold 8%` blur 40.
- Todo glass card tem highlight de 1px no topo (`white 14%`, altura 1pt, blur 0) simulando a borda onde a luz bate primeiro.

## 7. Componentes (especificação visual)

### 7.1 Botões
- **Primary**: pill, fundo gradiente `gold → goldGlow` (135°), texto `bg.base` semibold, sombra `shadow.raised` tingida de gold. Press: escala 0.96 + brightness -6%, spring `response 0.28 / damping 0.7`.
- **Secondary**: pill, `glass.thin`, texto `ink.primary`. Press: escala 0.97.
- **Ghost/Text**: sem fundo, cor `accent.gold`, sublinhado só no press.
- **Ícone flutuante (FAB)**: círculo 56pt, `glass.regular` + glow gold, ícone SF Symbol peso semibold. Long-press expande radialmente 3 ações (Nova despesa / Nova receita / Nova meta).

### 7.2 Cards
- Todo card tem `padding 20`, `radius.lg/xl`, `glass.thin`, e leve **tilt 3D** (máx. 4°) que responde ao drag do dedo (giroscópio opcional, drag sempre).
- Card "hero" (patrimônio): ocupa a largura da tela, altura ~200pt, número em `display`, sparkline de fundo com gradiente, glow ambiente atrás do card.

### 7.3 Inputs
- Fundo `bg.elevated2`, radius `md`, sem borda visível em repouso; ao focar, borda 1.5pt `accent.gold` + leve glow externo + label sobe com spring (efeito "floating label").

### 7.4 Pickers / Segmented Tabs
- Pill container `glass.thin`; seleção é um indicador que **desliza** com `matchedGeometryEffect` (não fade), texto muda de peso (regular→semibold) na seleção.

### 7.5 Switches
- Trilho 51×31, estado off `bg.elevated3`, estado on gradiente `emerald`; thumb com sombra dupla e leve "squeeze" horizontal (elastic) ao alternar.

### 7.6 Badges / Tags de categoria
- Pill pequena, fundo da cor da categoria @ 16% opacidade, texto na cor sólida da categoria, ícone SF Symbol 10pt.

### 7.7 Progress (metas)
- **ProgressRing**: anel com gradiente cônico (gold→emerald conforme progresso), ponta arredondada, animação de preenchimento com easing `spring`, número central contando suavemente.
- **ProgressBar linear** (orçamento por categoria): trilho `bg.elevated3` 6pt altura, preenchimento com gradiente e glow na ponta quando >90%.

### 7.8 Gráficos
- **Linha (patrimônio/fluxo de caixa)**: curva `catmull-rom` suavizada, área abaixo com gradiente vertical (cor → transparente 0%), ponto mais recente com glow pulsante sutil, drag no gráfico revela tooltip flutuante com haptic leve a cada troca de ponto.
- **Barras (receita x despesa por mês)**: barras com radius no topo, altura anima com spring em cascata (stagger 40ms), barra ativa (mês atual) com glow, demais com opacidade 80%.
- **Doughnut (categorias de gasto)**: espessura 14pt, gap entre segmentos 3°, segmento tocado "levanta" 4pt para fora do centro + haptic.

### 7.9 Avatares / Ícones de instituição
- Círculo 40pt, `glass.thin`, ícone/monograma centralizado; para cartões, mini-mockup do cartão físico em miniatura com gradiente da bandeira.

### 7.10 Modals / Sheets
- `presentationDetents` com handle customizado (pill 36×5, `ink.quaternary`), fundo `glass.regular`, entrada com spring (nunca slide linear), conteúdo interno com fade+slide stagger.

## 8. Estados e feedback visual

| Estado | Tratamento |
|---|---|
| Loading | Skeleton shimmer diagonal (não spinner genérico) nos cards; hero card mostra "respiração" de opacidade 100%↔85% |
| Vazio | Ilustração line-art minimalista + copy calma ("Nada por aqui ainda — vamos criar sua primeira meta?") |
| Erro | Mesh gradient muda para `mesh.alert`, ícone com shake sutil (2px, 2 ciclos), nunca vermelho puro |
| Sucesso (salvar/concluir meta) | Confete físico contido (12–16 partículas, gravidade real, 900ms) + haptic `.success` + check com trace-in do SF Symbol |
| Exclusão | Card colapsa em altura com spring + fade, haptic `.warning`, undo toast flutuante por 4s |
| Pull to refresh | Substituímos o spinner do sistema por um "respirar" do glow do hero card + haptic leve no threshold |

## 9. Acessibilidade

Contraste mínimo AA para todo texto sobre glass (testado sobre a variante mais clara do mesh). Todos os componentes respeitam `Reduce Motion` (animações de física viram fade curto) e `Dynamic Type` até `XXL` sem quebra de layout (cards viram scroll interno antes de cortar texto).

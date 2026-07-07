# Aurum — Arquitetura, UX, Animações, Microinterações e Navegação

## 1. Arquitetura do app

**Padrão**: SwiftUI + MVVM leve + Observation (`@Observable`), sem dependências externas na fundação (Design System e Dashboard não dependem de nenhum pacote de terceiros).

```
Aurum/
├─ App/
│  └─ AurumApp.swift                 // @main, injeta ambiente, tema
├─ DesignSystem/
│  ├─ Colors.swift                   // Color tokens (seção 1 do design system)
│  ├─ Typography.swift               // Font tokens + modifiers
│  ├─ Spacing.swift                  // Espaçamento e radius
│  ├─ Materials.swift                // Glass/blur/mesh gradient
│  └─ Shadows.swift                  // Sombras em 2 camadas
├─ Components/
│  ├─ GlassCard.swift
│  ├─ PrimaryButton.swift / SecondaryButton.swift
│  ├─ AnimatedNumberText.swift
│  ├─ ProgressRing.swift
│  ├─ CustomLineChart.swift
│  ├─ CustomBarChart.swift
│  ├─ CategoryDoughnutChart.swift
│  ├─ SegmentedTabs.swift
│  ├─ FloatingTabBar.swift
│  ├─ CategoryBadge.swift
│  └─ EmptyStateView.swift
├─ Models/
│  ├─ Transaction.swift, Goal.swift, Investment.swift, Card.swift, Subscription.swift
│  └─ MockData.swift                 // dados de demonstração
├─ Screens/
│  ├─ Root/RootView.swift            // shell de navegação
│  ├─ Dashboard/                     // tela principal (foco desta entrega)
│  ├─ Transactions/ (placeholder estilizado)
│  ├─ Goals/ (placeholder estilizado)
│  ├─ Investments/ (placeholder estilizado)
│  └─ Cards/ (placeholder estilizado)
└─ Utilities/
   ├─ Haptics.swift
   └─ View+Extensions.swift
```

**Por que MVVM leve, não Clean Architecture completa?** Este é um app de consumo pessoal, não um app enterprise com múltiplas equipes. Camadas demais matariam a velocidade de iteração visual, que é a prioridade #1 deste projeto. Cada `Screen` tem uma `ViewModel` `@Observable` que expõe apenas o necessário para a View — sem casos de uso, repositórios ou injeção de dependência complexa nesta fase. Isso pode evoluir quando entrar persistência real (Core Data/SwiftData) e sincronização.

## 2. Princípios de UX

1. **Uma pergunta por tela.** Dashboard responde "como estou financeiramente, agora?". Nunca tentamos responder duas perguntas grandes na mesma composição.
2. **Números antes de rótulos.** O olho deve encontrar o valor antes do texto explicativo — tamanho e peso tipográfico fazem esse trabalho, não cor de destaque.
3. **Nunca mais de 2 ações primárias visíveis por tela.** Ações secundárias vivem em menus contextuais (long press / swipe).
4. **Todo dado tem uma direção.** Nenhum número aparece "nu" — sempre acompanhado de uma tendência (↑12% este mês, comparação com mês anterior), pois contexto é o que transforma dado em informação.
5. **Espaço em branco é conteúdo.** Se uma tela parece "vazia" mas está balanceada, está correta. Preenchimento não é o objetivo.
6. **A pessoa nunca espera olhando para nada.** Todo carregamento tem um skeleton com a forma final do conteúdo — nunca um spinner central genérico.

## 3. Navegação (cinematográfica)

- **Casca de navegação**: `TabView` customizado substituído por `FloatingTabBar` (não a tab bar padrão do sistema) — flutuante, `glass.regular`, ancorada a 16pt da borda inferior, com indicador de seleção que desliza via `matchedGeometryEffect` chamado `tabIndicator`.
- **Abas**: Dashboard · Transações · Metas · Investimentos · Cartões (5 abas, ícone SF Symbol + label, ícone "respira" — leve scale 1.0→1.08→1.0 — ao ser selecionado).
- **Drill-down**: `NavigationStack` por aba. Transição push customizada: a tela de origem recua levemente (scale 0.96, brightness -4%) enquanto a nova entra com slide+fade — sensação de profundidade, não de troca de slide.
- **Detalhe de card → tela cheia**: usa `matchedGeometryEffect` (ex.: tocar no card de patrimônio expande para a tela de detalhe do patrimônio; o card literalmente **é** o header da próxima tela, não uma nova view surgindo do nada).
- **Criação rápida (nova transação/meta)**: `fullScreenCover` com fundo que faz blur progressivo do conteúdo anterior (não corte abrupto) e o formulário sobe com spring.
- **Menus contextuais**: long press em qualquer card/linha abre `contextMenu` customizado com ações relevantes (editar, duplicar, excluir, categorizar).
- **Bottom sheets**: `presentationDetents([.medium, .large])` com handle customizado — usados para filtros, seleção de categoria, detalhes rápidos de transação.

## 4. Catálogo de animações

| Animação | Onde | Especificação |
|---|---|---|
| Entrada da Dashboard | Ao abrir o app | Cards entram em cascata (stagger 60–90ms), cada um com fade+slide-up 16pt + spring `response 0.5 damping 0.8`; o hero de patrimônio entra primeiro e sozinho, os demais seguem |
| Contagem de números | Todo valor monetário exibido pela primeira vez | `AnimatedNumberText` interpola de 0 (ou do valor anterior) ao valor final em 900ms com curva `easeOut`, formatando moeda a cada frame relevante |
| Gráfico de linha | Aparecimento do gráfico | Trace da curva da esquerda para a direita (via `trim(from:to:)`) em 700ms, área de gradiente faz fade-in atrás com 200ms de atraso |
| Gráfico de barras | Aparecimento | Cada barra cresce do eixo para cima, stagger 40ms, spring `damping 0.75` |
| Anel de progresso (meta) | Aparecimento/atualização | `trim` anima de 0 até o progresso atual, 800ms, easing `easeInOut`; ao concluir 100%, pulso único de glow + haptic `.success` |
| Respiração do FAB | Contínua, sutil | Scale 1.0↔1.03 a cada 2.4s, loop infinito, opacidade do glow acompanha |
| Tilt de card | Drag do dedo sobre o card | RotationEffect 3D (`.rotation3DEffect`) até 4°, eixo conforme posição do toque, retorna com spring ao soltar |
| Parallax do fundo | Scroll da Dashboard | Mesh gradient de fundo se move a 0.3x da velocidade do scroll (profundidade) |
| Pull to refresh | Topo da lista/dashboard | Glow do hero card pulsa + puxa levemente para baixo com resistência elástica; ao soltar, haptic + recolhimento com spring |

## 5. Microinterações

- **Botões**: press = scale 0.96 + haptic `.light`; release = spring de volta.
- **Swipe em linha de transação**: swipe esquerda revela "Excluir" (coral) e "Categorizar" (azure) com resistência progressiva (rubber-banding) e snap por spring.
- **Long press em card**: leve scale 1.02 + sombra sobe (`resting`→`raised`) antes do menu contextual abrir, para dar noção de "levantar o objeto".
- **Toggle de visibilidade de saldo** (ícone de olho no hero card): números fazem blur-in/out (não apenas escondem), com haptic `.light`.
- **Concluir meta**: confete contido + haptic `.success` + o card da meta "se ilumina" (glow gold por 1.2s) antes de mover para uma seção "Concluídas".
- **Excluir transação**: card colapsa em altura (não em opacidade só) + toast "Excluído — Desfazer" flutuante por 4s.
- **Adicionar novo item**: o novo card entra do topo da lista com leve overshoot (bounce natural, `damping 0.65`), nunca aparece "estático".
- **Troca de aba**: ícone da aba selecionada tem bounce vertical de 2pt na chegada.

## 6. Wireframes descritivos

Ver `03-WIREFRAMES.md` para a descrição tela a tela.

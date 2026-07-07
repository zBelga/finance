# Aurum

Um app financeiro para iOS com fundação visual de altíssimo acabamento — vidro escuro, luz dourada contida, animações com física real. Ver `docs/` para a documentação completa de design.

## Documentação

1. `docs/00-VISION-MOODBOARD.md` — identidade, nome, moodboard descritivo, princípios não negociáveis.
2. `docs/01-DESIGN-SYSTEM.md` — cores, tipografia, espaçamento, radius, sombras, glass/blur, componentes, estados.
3. `docs/02-ARQUITETURA-UX-ANIMACOES.md` — arquitetura de código, princípios de UX, navegação, catálogo de animações e microinterações.
4. `docs/03-WIREFRAMES.md` — wireframes descritivos de todas as telas.

## O que já está implementado

- **Design System completo em código**: `Sources/DesignSystem/` (cores, tipografia, espaçamento/radius, sombras em duas camadas, materiais de vidro/blur com highlight e mesh gradient).
- **Componentes premium reutilizáveis**: `Sources/Components/` — `GlassCard`, `PrimaryButton`/`SecondaryButton`, `FloatingActionButton`, `AnimatedNumberText` (contagem suave de valores), `TrendBadge`, `ProgressRing`/`AurumProgressBar`, `CustomLineChart` (Swift Charts com gradiente, glow e tooltip por arraste), `CustomBarChart` (barras com crescimento em cascata), `CategoryDoughnutChart` (segmentos que "levantam" ao toque), `SegmentedTabs`, `FloatingTabBar`, `CategoryBadge`, `EmptyStateView`.
- **Dashboard completa** (`Sources/Screens/Dashboard/`): patrimônio (hero card com sparkline), calendário financeiro, fluxo de caixa, receitas/despesas, objetivos, investimentos, gastos por categoria, cartões e assinaturas — tudo com entrada em cascata, parallax sutil de fundo e pull-to-refresh customizado.
- **Navegação**: `RootView` com `FloatingTabBar` flutuante e `NavigationStack` por aba.
- **Telas placeholder estilizadas** (próxima fase de profundidade): Transações, Metas, Investimentos, Cartões — já usam o Design System e dados mock, prontas para receber persistência real.

Todos os valores são dados de demonstração em `Sources/Models/MockData.swift`.

## Como abrir no Xcode

Este repositório não inclui um `.xcodeproj` binário (evitamos gerar esse arquivo à mão para não corrompê-lo). Duas formas de gerar o projeto:

### Opção A — XcodeGen (recomendado)

```bash
brew install xcodegen
cd financeiro
xcodegen generate
open Aurum.xcodeproj
```

O `project.yml` na raiz já define o target `Aurum` (iOS 17+, todas as fontes em `Sources/`).

### Opção B — Manualmente, sem XcodeGen

1. No Xcode: **File → New → Project → iOS → App**. Nome do produto: `Aurum`. Interface: SwiftUI. Deployment target: iOS 17.
2. Apague o `ContentView.swift` e o `Info.plist` gerados automaticamente.
3. Arraste a pasta `Sources/` inteira para dentro do projeto no Xcode (marcando "Copy items if needed" desmarcado, "Create groups").
4. Aponte o Info.plist do target para `Sources/App/Info.plist` (Target → Build Settings → Info.plist File).
5. Rode em um simulador de iPhone (ex.: iPhone 15 Pro).

## Próximos passos sugeridos

- Persistência real (SwiftData) substituindo `MockData`.
- Fluxo completo de criação rápida (nova transação/meta) via `fullScreenCover`, especificado em `docs/03-WIREFRAMES.md` §6.
- Aprofundar Transações, Metas, Investimentos e Cartões no mesmo nível de polimento da Dashboard.
- Detalhe do patrimônio com transição `matchedGeometryEffect` a partir do hero card.

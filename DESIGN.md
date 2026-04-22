# DESIGN.md — Editorial GRC

A design system for a governance, risk, and compliance SaaS platform. Written
for AI coding agents (Claude, Cursor, Windsurf) and humans. Drop this file
into a project root and reference it when building UI.

> **North-star check**: "Would Anthropic ship this?" If a surface reads as
> calm, deliberate, and trustworthy — yes. If it reads busy, shouty, or
> corporate — redesign.

---

## 1. Visual Theme & Atmosphere

**Editorial GRC.** Serious but never stodgy. Warm but precise. Dense when
the work demands it, spacious when the content deserves air. The brand
purple (`#6A12CD`) is the signature and is treated as a real character
beat — not a token accent and not a reason for decoration.

**Mood words**: editorial, warm, precise, data-first, quietly AI-native.

**What this is**:
- Long-form audit reports that feel like *The New Yorker* with a risk table.
- Dashboards that respect the 8-hour workday of a compliance officer.
- AI responses that feel like a thoughtful analyst wrote them, not a chatbot.
- Data density as a feature, not a crisis.

**What this is not**:
- Enterprise navy. Glowing dark techy. Startup-cool gradient soup.
- Infographic pastels. Playful SaaS with rounded emoji mascots.
- Chat-bubble AI with avatar circles and "AI is typing…" skeuomorphism.
- 90s SaaS: thick borders, heavy shadows, gray-on-gray, all-caps banners.

**Voice of the UI**: sentence-case, confident, declarative. Say "Risk
assessment," not "RISK ASSESSMENT." Say "View all" not "VIEW ALL →".
Prefer short complete sentences over truncated labels. When a table column
header is a noun, it gets capitalized like a name ("Owner", "Severity").
When an empty state speaks, it speaks in full sentences — "No risks match
these filters. Clear filters or broaden your query." — not "Nothing here."

---

## 2. Color Palette & Roles

Colors are organized as **primitive → semantic → component**. Only touch
primitives when extending the system. Most UI should pull from semantic
tokens (e.g., `--color-surface`, `--color-text`, `--color-danger`).

### Brand purple (derived from `#6A12CD`)

| Token         | Hex       | Role                                                   |
|---------------|-----------|--------------------------------------------------------|
| `brand-50`    | `#F7F0FF` | Tinted surfaces, hover tiles                           |
| `brand-100`  | `#EDDEFE` | Pill background, info banner                           |
| `brand-200`  | `#DCBBFD` | Illustration accent, chart tint                        |
| `brand-300`  | `#C393FA` | Chart series on light mode                             |
| `brand-400`  | `#A366F0` | Hover on primary button                                |
| `brand-500`  | `#8838DE` | Secondary accent                                       |
| **`brand-600`** | **`#6A12CD`** | **Anchor — buttons, links, large display**     |
| `brand-700`  | `#550FA5` | **On-surface body text (AA-safe)**                     |
| `brand-800`  | `#3B0B72` | Pressed, dense-data accent                             |
| **`brand-900`** | **`#26064A`** | **Anchor — display ink, dark-mode surface**    |
| `brand-950`  | `#170330` | Dark-mode canvas base                                   |

> **Accessibility note**: `brand-600` on `paper-50` is ~4.0:1 — OK for large
> display and button backgrounds with white text, NOT for small body copy.
> For text on light surfaces use `brand-700` (~7.2:1).

### Warm neutrals ("paper & ink")

| Token       | Hex       | Role                                                   |
|-------------|-----------|--------------------------------------------------------|
| `paper-0`   | `#FFFFFF` | Cards on tinted surfaces                               |
| `paper-50`  | `#FAF7F2` | **Light canvas** (body background)                     |
| `paper-100` | `#F3EEE5` | Subtle surface, zebra banding                          |
| `paper-200` | `#E8E1D2` | Divider on warm surface                                |
| `paper-300` | `#D6CCB7` | Muted illustration baseline                            |
| `ink-300`   | `#C2B9CB` | Placeholder text                                       |
| `ink-400`   | `#9A8FAE` | Secondary text                                         |
| `ink-500`   | `#6B5D82` | Meta, caption                                          |
| `ink-600`   | `#4A3D62` | Body on tinted surface                                 |
| `ink-700`   | `#332848` | Strong body                                            |
| `ink-800`   | `#1F1433` | Headings                                               |
| `ink-900`   | `#0F0720` | Display, highest-contrast ink                          |

**Dark mode inverts**: canvas `#12081E`, ink `#F1EDE3`, surfaces lifted with
`brand-900` tints rather than pure black. Paper tokens remain warm.

### Semantic (GRC-specific, not generic)

| Role         | Light     | Dark      | Usage                                       |
|--------------|-----------|-----------|---------------------------------------------|
| `risk`       | `#B42318` | `#F97066` | Critical severity, destructive actions      |
| `high`       | `#C2410C` | `#FB923C` | High severity                               |
| `mitigated`  | `#B45309` | `#FBBF24` | Mitigated risk, medium severity             |
| `compliant`  | `#15803D` | `#4ADE80` | Compliant, low severity, success            |
| `evidence`   | `#0369A1` | `#38BDF8` | Evidence links, citations, sources          |
| `info`       | `#6A12CD` | `#A366F0` | Informational, brand-adjacent notes         |
| `draft`      | `#6B5D82` | `#9A8FAE` | Draft, not-started, muted                   |

> **Rule**: never use pure red/amber/green. The custom GRC scale (crimson /
> burnt-orange / old-gold / moss) is colorblind-safer and doesn't read as
> consumer-web.

### Data-viz (8-color categorical, colorblind-safe)

Pick in order. Don't exceed 5 series on a single chart without explicit
design review.

1. `#6A12CD` brand violet
2. `#C2410C` burnt orange
3. `#0369A1` sky blue
4. `#15803D` moss green
5. `#B45309` old gold
6. `#9333EA` secondary violet
7. `#0891B2` cyan
8. `#B42318` crimson

**Diverging scale (risk heatmaps, 4-stop)**:
`#15803D → #FBBF24 → #C2410C → #B42318` (low → critical).

**Sequential scale (utilization, 5-stop)**:
`#F7F0FF → #DCBBFD → #A366F0 → #6A12CD → #3B0B72`.

### Color opacity scale

Alpha tokens applied to ink or brand when semantic color alone is too loud
or when building overlays. Prefer solid discrete tokens (above) for most UI;
use opacity only when a solid token can't represent the need (disabled
states, modal scrims, row-hover tints, illustration layers).

| Token        | Alpha | Use                                                    |
|--------------|-------|--------------------------------------------------------|
| `alpha-100`  | 1.0   | Primary text, primary background, solid fills         |
| `alpha-80`   | 0.80  | Secondary text, subtle emphasis on primary tokens     |
| `alpha-50`   | 0.50  | Disabled text, muted foreground, muted border         |
| `alpha-20`   | 0.18  | Background tints, light surfaces, row hover, overlay  |
| `alpha-10`   | 0.10  | Extra-subtle hover tint, chart baseline, gridlines    |
| `alpha-scrim`| 0.40  | Modal/dialog backdrop behind overlays                 |

Compose as `var(--ink-900) / <alpha>` in Tailwind v4 (`text-ink-900/80`) or
`color-mix(in oklab, var(--ink-900) 80%, transparent)` in raw CSS.

---

## 3. Typography Rules

### Faces

| Role       | Default (OSS)          | Upgrade (paid, optional)       |
|------------|------------------------|--------------------------------|
| Display    | **Source Serif 4** Variable | Tiempos Headline, GT Sectra |
| Body / UI  | **Inter** Variable     | Söhne                          |
| Mono       | **JetBrains Mono** Variable | Söhne Mono, Berkeley Mono |

All faces are variable, self-hosted (or delivered through a font CDN with
subsetting). Tabular numerics are enabled globally on `.numeric` and inside
`<table>`, `<td>`, `<th>`.

### Scale (1.25 major-third, tuned — px / rem / line-height / letter-spacing / weight / face)

Root font-size is `16px`, so `1rem = 16px`. Use `rem` in code for
accessibility (respects user font-size preference); `px` listed here for
Figma / design-tool parity.

| Token         | Size px | Size rem | Line ht | Tracking  | Weight | Face       |
|---------------|---------|----------|---------|-----------|--------|------------|
| `display-2xl` | 72      | 4.500    | 1.05    | −0.03em   | 320    | Display    |
| `display-xl`  | 56      | 3.500    | 1.07    | −0.025em  | 380    | Display    |
| `display-lg`  | 44      | 2.750    | 1.10    | −0.020em  | 420    | Display    |
| `display-md`  | 36      | 2.250    | 1.15    | −0.015em  | 480    | Display    |
| `display-sm`  | 28      | 1.750    | 1.20    | −0.010em  | 520    | Display    |
| `heading-xl`  | 24      | 1.500    | 1.25    | −0.005em  | 600    | Inter      |
| `heading-lg`  | 20      | 1.250    | 1.30    |  0        | 600    | Inter      |
| `heading-md`  | 17      | 1.063    | 1.40    |  0        | 600    | Inter      |
| `heading-sm`  | 15      | 0.938    | 1.45    |  0.005em  | 620    | Inter      |
| `body-lg`     | 17      | 1.063    | 1.65    |  0        | 400    | Inter      |
| `body`        | 15      | 0.938    | 1.60    |  0        | 400    | Inter      |
| `body-sm`     | 13      | 0.813    | 1.55    |  0        | 440    | Inter      |
| `label`       | 12      | 0.750    | 1.30    |  0.02em (uppercase) | 560 | Inter |
| `code`        | 13      | 0.813    | 1.55    |  0        | 420    | JetBrains  |
| `code-sm`     | 12      | 0.750    | 1.50    |  0        | 460    | JetBrains  |
| `numeric`     | inherit | inherit  | inherit | (tabular) | 520    | Inter      |

### Rules

- **Serif is a character beat, not a default.** Use display-* only for
  narrative headers (reports, dashboards, AI responses, section hero).
  Primary page chrome, tables, and forms are all Inter.
- **All numbers in tables, KPIs, and risk figures** use `numeric` (tabular
  nums + Inter 520). Proportional digits are forbidden in data contexts.
- **Uppercase labels** are reserved for `label` token only — never apply
  `text-transform: uppercase` to anything else.
- **Line length cap**: body prose maxes out at 66ch; report reader mode
  goes to 72ch with a serif body option.

### Icon sizes

| Token       | Size px | Size rem | Stroke | Use                              |
|-------------|---------|----------|--------|----------------------------------|
| `icon-sm`   | 14      | 0.875    | 1.5px  | Compact rows, inline with `body-sm`, pills |
| `icon-md`   | 16      | 1.000    | 1.5px  | Default — buttons, inputs, tabs  |
| `icon-lg`   | 20      | 1.250    | 1.75px | Primary nav, page header, lg button |
| `icon-xl`   | 24      | 1.500    | 1.75px | Hero surfaces, empty-state illustration |
| `icon-2xl`  | 32      | 2.000    | 2px    | Marketing, onboarding            |

All icons are from [Lucide](https://lucide.dev), rendered as SVG with
`stroke-linecap: round` and `stroke-linejoin: round`. Never mix stroke and
filled icon libraries. Never tint icons with `fill` — use `color` and let
SVGs inherit `currentColor`.

---

## 4. Component Stylings

Components are **shadcn-themed** (Radix primitives + Tailwind v4). These are
the defaults; derivations should preserve tokens, not override them.

### Button

```
// Primary
height: 40px (md), 32px (sm), 48px (lg)
padding: 0 16px
radius: 8px
background: brand-600
color: paper-0
font: heading-md weight 600
transition: background 150ms standard, transform 75ms standard

hover   → brand-500
active  → brand-800, translateY(0.5px)
focus   → ring 4px brand-600/24 (glow-brand)
disabled→ brand-600/40, pointer-events: none
loading → spinner in paper-0, label preserved (not replaced)
```

**Variants**: `primary` (above), `secondary` (paper-0 bg, ink-800 text, 1px
`paper-200` border), `ghost` (transparent bg, ink-700 text, brand-50 hover),
`destructive` (risk bg, paper-0 text), `link` (text-only, brand-700,
underline on hover).

### Input / Textarea

```
height: 40px (md)
padding: 10px 12px
radius: 8px
background: paper-0
border: 1px paper-200
color: ink-900
placeholder: ink-300
font: body

hover   → border paper-300
focus   → border brand-600, ring 3px brand-600/20
error   → border risk, ring 3px risk/20
disabled→ background paper-100, color ink-400
```

Never use a shadow for input focus. The brand ring is the signal.

### Card

```
background: paper-0
border: 1px paper-200
radius: 12px
padding: 24px (default), 16px (compact)
shadow: none

hover (interactive cards only)
  → border paper-300, shadow sm
```

**Variants**: `outlined` (default above), `elevated` (shadow md, no border),
`muted` (paper-100 background, no border), `feature` (brand-50 background,
brand-200 border — for highlighted AI suggestions or KPIs).

### Table / DataGrid

```
typography: body-sm (compact) or body (comfortable)
row height: 32px compact, 44px comfortable
cell padding: 6px 12px (compact), 12px 16px (comfortable)
header: label token on paper-100, ink-600
zebra: alternating paper-50 / paper-100 (or off)
hover: row background paper-100
selected: row background brand-50, left border 2px brand-600
numeric cells: text-align right, numeric font
```

- Use sticky first column when >5 columns and horizontal scrolling is likely.
- Use column group headers for risk matrices (Q1 / Q2 / Q3 / Q4).
- Every table ships with a compact toggle; default is comfortable.

### Badge / Pill — no border, no icon

Pills are flat: tinted background + semantic text. **No border. No glyph.**
The text label itself is the source of truth (so colorblind users rely on
words, not icon/color).

```
height: 20px (sm), 24px (md), 28px (lg)
padding: 0 8px (sm), 0 10px (md), 0 12px (lg)
radius: 999px
font: label
background: [semantic]-50  (or alpha tint in dark mode)
color: [semantic]-700 on light / [semantic] on dark
border: none
```

Two taxonomies share the same style:

**Status pills** (generic, used for form validation, toasts, system banners):
`Default` (draft neutral), `Success`, `Error`, `Warning`, `Info`, `Disabled`.

**GRC severity pills** (domain-specific, for risk rows, findings, audit
results): `Critical`, `High`, `Medium`, `Low`, `Info`. Same visual treatment
as status pills — no border, no icon, strong label text.

Because no glyph distinguishes severity, **severity labels must always be
spelled out** (`Critical`, not `C`; `High`, not `H`). Charts and heatmaps
still carry redundant encoding (color + position + tooltip text).

### Dialog / Drawer

- Overlay: `ink-900` at 40% opacity + 4px backdrop-blur.
- Surface: paper-0, 16px radius, shadow xl, max-width 560px (md) or 720px (lg).
- Header: display-sm serif for narrative dialogs ("Delete audit?"), heading-md
  sans for task dialogs ("Edit control").
- Close button is a ghost icon-button, top-right, 16px from edge.

### AIResponse (signature pattern)

```
container: rounded-xl, 1px gradient border
  (linear-gradient 135deg, brand-600 0%, brand-400 50%, #E879F9 100% at 24% opacity)
background: paper-0 with brand-50 tint (rgba(106,18,205,0.03))
padding: 24px
min-height: 120px

header: optional meta row — "Answered in 1.2s · 4 sources"
body: body-lg, ink-800, 66ch max
citations: mono code-sm inside brand-50 pills, clickable to source
tool calls: collapsible section, mono code-sm, monospace grid
streaming cursor: 2px wide, brand-600, blinking at 1.2s cycle
thinking dots: three brand-400 dots, pulsing spring easing, 900ms stagger
```

The AIResponse is **not a chat bubble**. No avatar. No "AI said" tag.
It's presented as considered prose with citations. Think: a column in a
well-designed news app. If multiple responses stack, separate with a
16px paper-200 rule, not a new bubble.

### Empty state

- Illustration optional; if present use `paper-300` linework only (no color).
- Title: heading-lg serif if the surface is narrative, heading-md sans
  otherwise.
- Body: body, ink-500, 2 sentences max.
- CTA: secondary button for the primary action.

---

## 5. Layout Principles

### Grid

- 8pt base, 4pt sub-grid allowed for icon-aware alignments.
- Content container: 1200px max for dashboards, 960px for reports (reader
  mode), 1440px for data-heavy tables.
- Column gaps: 24px on dashboards, 16px on compact tables, 32px on reports.

### Spacing scale

`0, 2, 4, 6, 8, 12, 16, 20, 24, 32, 40, 48, 64, 80, 96, 128` (px).
Everything snaps to this. Never introduce a new step without governance.

### Density

- **Comfortable** (default): row 44px, cell pad 12/16px, body type.
- **Compact**: row 32px, cell pad 6/12px, body-sm type.
- Density is a user preference, stored in `localStorage`. Density toggle
  sits in the Topbar ⚙ menu. Every table, data grid, and list supports
  both — not a feature of the component.

### App shell

- Left sidebar (256px expanded, 64px collapsed). Collapses at <1024px.
- No top header bar — brand, search, and user profile live in the sidebar.
- Content panel: `#FCFAFD` canvas (brand-600 at ~2%), 28px page padding.

### Sidebar

Dark sidebar anchored to brand-900. All content is white with opacity
hierarchy. No header bar — the sidebar holds everything.

```
width: 256px
background: brand-900
border-right: 1px rgba(255,255,255,0.08)
display: flex, column, full height

Tokens:
  --sidebar-bg:          brand-900
  --sidebar-border:      rgba(255,255,255, 0.08)
  --sidebar-text:        rgba(255,255,255, 0.85)
  --sidebar-text-dim:    rgba(255,255,255, 0.55)
  --sidebar-hover:       rgba(255,255,255, 0.08)
  --sidebar-active-bg:   rgba(255,255,255, 0.08)
  --sidebar-active-text: #FFFFFF
  --sidebar-active-bar:  #FFFFFF
```

**Structure** (top → bottom):

1. **Logo row** — 30×30 icon (gradient brand-500→400, radius 8, shadow
   `0 2px 6px brand-600/30`), brand name 15px/700 white, subtitle
   10.5px/500 white/70% with dropdown chevron. Bottom border
   `rgba(255,255,255,0.06)`. Padding 18px 16px 16px.

2. **Top actions** — "Ask IRA" (chat icon) and "Search" (search icon).
   12px, #FFFFFF. Same `.sb-item` structure.

3. **Primary nav** — Home (active), Recents. Standard `.sb-item` at
   36px height, 13px/520, `rgba(255,255,255,0.85)`.

4. **Programs group** — section label "PROGRAMS" (10px/560, uppercase,
   0.08em tracking, white/55%). Sub-items: Planning, Process Hub,
   Risk Register (with white pill badge `14`, brand-600 text),
   Control Library. All use `.sb-item` — same height, font, padding.

5. **Main nav** — Dashboard, Report, Workflow Library, AI Concierge.

6. **Bottom nav** — Configuration, Admin.

7. **User profile** — card container `rgba(255,255,255,0.06)` bg +
   `rgba(255,255,255,0.08)` border. Avatar 32×32 white bg, brand-600
   text, weight 700. Name 13px/600 white. Role 11px white/55%.
   Three-dot menu white/45%.

**Nav item (`.sb-item`)**:
```
height: 36px
padding: 0 14px
margin: 1px 8px
radius: 8px
font: 13px Inter, weight 520
color: rgba(255,255,255, 0.85)
transition: background 150ms

hover → background rgba(255,255,255, 0.08), color #FFFFFF
```

**Active state**:
```
background: rgba(255,255,255, 0.08) — same as hover
color: #FFFFFF
font-weight: 600
left accent bar: 3px wide, #FFFFFF, left: 0, top: 0, bottom: 0
  border-radius: 8px 0 0 8px
```

**Dividers**: 1px `rgba(255,255,255,0.08)`, margin 6px 14px.

**Badge** (e.g., Risk Register count):
```
background: #FFFFFF
color: brand-600
font: 10.5px, weight 600
padding: 2px 7px
radius: 9999px
```

### Report reader

- 960px max-width container, `paper-50` canvas.
- Body column: 66ch width, centered.
- Serif body option toggled per reader preference — remembers across reads.
- Section headers: display-md serif, 80px top margin, 24px bottom.
- First paragraph of section 1 gets a drop-cap (3 lines tall, Source Serif
  weight 320, `brand-700`).

### Dashboard

- 12-column grid at ≥1280px, 8-column at ≥768px, stack below.
- KPI tiles span 3 columns (12-col) or 2 (8-col).
- Primary chart card spans 8 or full-width; secondary charts 4 wide.
- AI Q&A surface is always accessible from ⌘K or a sticky bottom-right FAB
  — never the only way to reach it.

---

## 6. Depth & Elevation

Elevation is expressed through **borders first, shadows sparingly, tint
never**. Cards sit on paper; they don't float on air.

| Level   | Use                             | Definition                                               |
|---------|--------------------------------|----------------------------------------------------------|
| `z-0`   | Canvas                         | No border, no shadow                                     |
| `z-1`   | Card resting                   | 1px `paper-200` border, no shadow                        |
| `z-2`   | Card hover / interactive       | 1px `paper-300` border, `shadow-sm`                      |
| `z-3`   | Popover, dropdown              | No border, `shadow-md`, brand-50 focus ring when active  |
| `z-4`   | Dialog, drawer                 | `shadow-xl`, overlay behind                              |
| `z-5`   | Toast                          | `shadow-lg`, auto-dismiss 5s default                     |
| `z-6`   | Command palette                | `shadow-xl`, brand-100 top-border hairline               |

Shadows — decomposed (x / y / blur / spread / color), DTCG composite form
for direct Tokens Studio → Style Dictionary ingestion:

| Token         | X    | Y    | Blur | Spread | Color                       | Notes               |
|---------------|------|------|------|--------|-----------------------------|---------------------|
| `shadow-xs`   | 0    | 1    | 0    | 0      | `rgb(15 7 32 / 0.04)`       | Hairline underline  |
| `shadow-sm.1` | 0    | 1    | 2    | 0      | `rgb(15 7 32 / 0.05)`       | Soft drop           |
| `shadow-sm.2` | 0    | 0    | 0    | 1      | `rgb(15 7 32 / 0.03)`       | Ring                |
| `shadow-md.1` | 0    | 4    | 12   | 0      | `rgb(15 7 32 / 0.06)`       | Soft lift           |
| `shadow-md.2` | 0    | 1    | 2    | 0      | `rgb(15 7 32 / 0.05)`       | Contact             |
| `shadow-lg.1` | 0    | 12   | 32   | 0      | `rgb(15 7 32 / 0.08)`       | Float               |
| `shadow-lg.2` | 0    | 4    | 12   | 0      | `rgb(15 7 32 / 0.05)`       | Contact             |
| `shadow-xl.1` | 0    | 24   | 48   | 0      | `rgb(15 7 32 / 0.12)`       | Modal               |
| `shadow-xl.2` | 0    | 12   | 24   | 0      | `rgb(15 7 32 / 0.06)`       | Contact             |
| `glow-brand`  | 0    | 0    | 0    | 4      | `rgb(106 18 205 / 0.24)`    | Focus only          |

Composite tokens layer two shadows (`.1` + `.2`) — in DTCG and CSS this is
a single `box-shadow` value with comma-separated layers. Style Dictionary
emits them accordingly.

Dark mode override:

| Token         | X    | Y    | Blur | Spread | Color                     |
|---------------|------|------|------|--------|---------------------------|
| `shadow-*`    | (same geometry) | | | | `rgb(0 0 0 / 0.40)` at all levels |
| `inset-lift`  | 0    | 1    | 0    | 0      | `rgb(255 255 255 / 0.04)` |

Dark-mode cards also carry the `inset-lift` token as an inset shadow so
surfaces remain perceptible against near-black.

---

## 7. Do's and Don'ts

### Do

- **Use serif for narrative hierarchy.** Report hero, dashboard hero, AI
  response header, section breaks in long-form content.
- **Use tabular nums on every number.** Risk scores, KPIs, table cells,
  audit findings counts.
- **Use explicit label text for severity.** Never rely on color alone.
  `Critical` / `High` / `Medium` / `Low` are always spelled out. Charts
  add position/tooltip as redundant encoding beyond color.
- **Snap to the 8pt grid.** If something needs 14px, use 12 or 16.
- **Reserve `brand-600` for signal.** Primary buttons, selected state,
  focus ring, links. Don't paint containers with it.
- **Write UI copy in full sentences** with a period. "No results match
  these filters." — not "No results."
- **Prefer borders to shadows** for card elevation. Shadow only when you
  need genuine spatial lift (popovers, dialogs, toasts).
- **Respect `prefers-reduced-motion`.** Replace all motion with opacity-only
  or instant transitions.
- **Ship compact density.** Every table must work at row-height 32. Power
  users live there.
- **Show AI thinking honestly.** Pulse dots during generation; cursor while
  streaming; timestamp when done. Don't fake streaming on static text.

### Don't

- **Don't use pure red/amber/green for severity.** Use the custom GRC
  scale (crimson / burnt-orange / old-gold / moss) — colorblind-safer and
  doesn't read as consumer-web.
- **Don't put the brand purple on body text over light.** It's
  borderline-AA. Use `brand-700` for text; reserve `brand-600` for
  backgrounds and large display.
- **Don't use emoji in UI copy.** Use Lucide icons.
- **Don't use drop-shadows decoratively** on cards, buttons, or sidebars.
  Shadow is for true lift (popovers, dialogs), not for "making things pop."
- **Don't animate for decoration.** Motion is a state-transition signal.
  No hover-bounce. No scroll-reveals. No marquee.
- **Don't stack more than three brand colors on a screen.** More than
  three reads as loud.
- **Don't center body paragraphs.** Left-aligned or justified (for reports).
  Centered is for hero moments only.
- **Don't use tooltips to hide critical information.** If a value needs
  explaining, explain it inline.
- **Don't write "AI is typing…".** That's chatbot clutter. Use the pulse
  indicator and move on.
- **Don't create a new component when a primitive composed does the job.**
  A "RiskPill" is just a `Badge` with a severity variant.

---

## 8. Responsive Behavior

### Breakpoints

| Name  | Min width | Typical device          |
|-------|-----------|-------------------------|
| `sm`  | 640px     | Large phone (landscape) |
| `md`  | 768px     | Tablet                  |
| `lg`  | 1024px    | Small laptop            |
| `xl`  | 1280px    | Desktop                 |
| `2xl` | 1536px    | Large desktop           |

### Rules

- **Sidebar** collapses to icon-only at `<lg` (1024px). Below `md` it
  becomes a drawer summoned from a menu button.
- **Topbar** keeps the logo, ⌘K search, notifications, avatar. Everything
  else goes to an overflow menu below `md`.
- **Dashboards** stack to a single column below `md`. KPI tiles go 2-per-
  row below `md`, full-width below `sm`.
- **Tables** gain a horizontal scroll region below `lg` with the first
  column sticky. Below `md`, offer a "view as cards" toggle and show each
  row as a card for scannability.
- **Reports** reduce max-width to 100% below `md` with 16px padding.
  Drop-cap disables below `sm`.
- **AI Q&A**: at `≥lg`, right-side panel (480px). At `<lg`, full-screen
  sheet (bottom-up on mobile).
- **Touch targets**: minimum 44×44px on all interactive elements below
  `md`. Use `py-2.5` minimum on buttons.
- **Typography**: display-2xl scales to display-xl at `<md`, display-xl
  to display-lg, and so on down one step. Body sizes don't change.

---

## 9. Agent Prompt Guide

### Quick reference

- **Default canvas**: `#FAF7F2` (light), `#12081E` (dark).
- **Primary button**: `background: #6A12CD; color: #FFFFFF; height: 40px; radius: 8px; font: Inter 600 15px`.
- **Body text on light**: `color: #1F1433` (ink-800). Never pure black.
- **Link**: `color: #550FA5` (brand-700), underline on hover only.
- **Focus ring**: `0 0 0 4px rgba(106, 18, 205, 0.24)`.
- **Card**: `background: #FFFFFF; border: 1px solid #E8E1D2; radius: 12px; padding: 24px`.
- **Serif display**: `font-family: "Source Serif 4", Georgia, serif; font-weight: 420; letter-spacing: -0.02em`.
- **Mono**: `font-family: "JetBrains Mono", "SF Mono", Consolas, monospace`.

### Ready-to-use prompts

**"Build me a risk summary card"**
```
Card (outlined variant), 320×220px.
Header row: label "ENTERPRISE RISK" (Inter 560, 12px, uppercase, ink-500).
Metric: display-lg serif "78" in ink-900, followed by " / 100" in ink-400
(inline, subdued).
Trend row: "↑ 12%" in compliant-700 with arrow icon.
Severity breakdown: four horizontal rows with severity pill + count,
  aligned right.
Footer CTA: "View all risks →" as link-variant button, brand-700.
```

**"Build me an AI response card"**
```
Container: rounded-xl, 1px gradient border
  (linear-gradient 135deg, #6A12CD, #A366F0, #E879F9 at 24% opacity),
  background #FFFFFF with rgba(106,18,205,0.03) tint, 24px padding.
Meta row: "Answered in 1.2s · 4 sources" in ink-500 body-sm, then 8px gap.
Body: body-lg (17px Inter 400 line-height 28), max 66ch.
Citations: inline pills, mono code-sm (13px JetBrains 420), brand-50 bg,
  brand-700 text, 4px radius, clickable.
Tool calls: collapsible panel below body, mono, paper-100 background.
```

**"Build me a compliance dashboard header"**
```
Section: py-32 px-32, paper-50 canvas.
Left column:
  label (uppercase caption): "Q1 2026 · Operational Risk".
  display-xl serif title: "Operational Risk Assessment".
  body-lg ink-600 intro paragraph, max 66ch:
    "A review of control effectiveness across 14 business units, with
     findings prioritized by impact and remediation velocity."
Right column (auto-aligned): KPI tiles — Risk Score, Open Findings,
  Control Coverage, Last Audit.
Below: 12-col grid of charts and tables.
```

**"Build me a pill"** (status or severity — same visual treatment)
```
Height 24px (md) or 20px (sm) or 28px (lg).
Radius 999px. Padding 0 10px (md).
Font: label (12px Inter 560, uppercase, tracking 0.02em).
Background: [semantic]-50 tint (e.g., #FEECEB for error/critical).
Color: [semantic]-700 (e.g., #8F1A12 for error/critical) on light mode.
Border: NONE. Icon: NONE.
Label: full word — "Critical", "Success", "Error", "Info" — never abbreviated.
```

**"Build me a data table"**
```
Full-width TanStack Table. Header in label token on paper-100.
Row: 44px height comfortable or 32px compact (user preference).
Zebra banding: paper-50 / paper-100.
Hover: row background paper-100. Selected row: brand-50 background,
  2px brand-600 left border.
Numeric columns: text-align right, numeric font (tabular).
Sort glyph: Lucide ChevronUp/Down in ink-500, next to active column header.
Filter bar: sticky top of table, paper-0 bg, 1px paper-200 bottom border.
Pagination: right-aligned, "1–50 of 142 · ‹ ›".
```

### Refusal list

If a generated UI includes any of the following, redo it:

- Pure `#FF0000`, `#FFA500`, `#00FF00` — use the GRC semantic scale.
- Drop-shadow on a button.
- `text-transform: uppercase` on anything other than `label` token.
- Emoji in UI copy (🎉, 👋, 🚀, etc.).
- Truncated labels with `...` when full text fits.
- Centered body paragraphs outside of hero moments.
- A chat-bubble AI response with avatar circle.
- Pastel gradients used as backgrounds on content cards.
- Pure black `#000000` for text or backgrounds.
- **Pills with borders or icons/glyphs** — pills are flat: tint + label.
- **Abbreviated severity labels** (`C`, `H`, `M`, `L`) — always spelled out.

### When to deviate

The design system is opinionated, not dogmatic. Deviate when:

- The user-experience cost of strict adherence exceeds the consistency benefit.
- A domain requirement (regulatory color coding, auditor convention) demands
  a specific signal.
- An accessibility need surpasses the system's default (e.g., AAA on
  public-sector reports).

Document the deviation in the component's JSDoc so the next agent sees why.

---

## 10. Component State Reference

Exhaustive per-component state matrices, sizes, and composition variants.
Keep this section authoritative when building React components; the shorter
stylings in §4 are summaries.

Every component inherits the global focus ring (`glow-brand`) and respects
`prefers-reduced-motion`. Every disabled state drops to 50% alpha of its
default label/fill and disables pointer events.

### 10.1 Button

**Sizes** (px / rem):

| Size | Height | Padding X | Min-width (icon-only) | Font      | Icon  | Radius |
|------|--------|-----------|------------------------|-----------|-------|--------|
| sm   | 32 / 2.00    | 12 / 0.75 | 32 / 2.00 | `body-sm` (13) | `icon-sm` (14) | `r-md` (8) |
| md   | 40 / 2.50    | 16 / 1.00 | 40 / 2.50 | `heading-md` (15 / 600) | `icon-md` (16) | `r-md` (8) |
| lg   | 48 / 3.00    | 20 / 1.25 | 48 / 3.00 | `heading-md` (17 / 600) | `icon-lg` (20) | `r-md` (8) |

Icon-only buttons are square (`height × height`). Icon-with-label gap: 8px.

**Variants × states** (all states): `default`, `hover`, `focus`, `active`,
`loading`, `disabled`.

| Variant     | Default                                           | Hover                     | Active                 | Disabled                     |
|-------------|---------------------------------------------------|---------------------------|------------------------|------------------------------|
| primary     | bg `brand-600`, text `paper-0`                   | bg `brand-500`            | bg `brand-800`, ty+0.5 | bg `brand-600/50`, text `paper-0/70` |
| secondary   | bg `paper-0`, text `ink-800`, border `paper-200` | border `paper-300`, bg `paper-50` | bg `paper-100`   | bg `paper-100`, text `ink-400`, border `paper-200` |
| ghost       | bg transparent, text `ink-700`                   | bg `brand-50`, text `brand-700` | bg `brand-100`    | text `ink-400`               |
| destructive | bg `risk`, text `paper-0`                        | bg `#9B1E14`              | bg `#7A1710`           | bg `risk/50`                  |
| link        | text `brand-700`                                  | text `brand-800`, underline | text `brand-900`    | text `ink-400`                |

Focus: all variants add `glow-brand` ring (4px `brand-600/24`).
Loading: spinner (16/20/24px by size) in fg color; label stays visible;
pointer-events disabled.

**Icon placement variants**:
- `icon-left`: `[icon 16px] [label]` with 8px gap
- `icon-right`: `[label] [icon 16px]` with 8px gap
- `icon-only`: square, aria-label required
- `none`: text only

### 10.2 Checkbox & Radio

**Size**: 16×16 (`1rem`) checkbox. 16×16 radio (round). Stroke 1.5px, radius
`r-xs` (4) for checkbox, `full` for radio.

| State     | Checkbox                                                        | Radio                                           |
|-----------|------------------------------------------------------------------|-------------------------------------------------|
| default   | border `paper-300`, bg `paper-0`                                 | border `paper-300`, bg `paper-0`                |
| hover     | border `ink-400`                                                 | border `ink-400`                                |
| focus     | + `glow-brand` ring                                              | + `glow-brand` ring                             |
| checked   | bg `brand-600`, border `brand-600`, check glyph `paper-0` 1.5px | bg `paper-0`, border `brand-600`, inner dot 6px `brand-600` |
| indeterminate | bg `brand-600`, border `brand-600`, dash glyph                | (n/a)                                           |
| disabled  | bg `paper-100`, border `paper-200`, opacity 50%                 | bg `paper-100`, border `paper-200`, opacity 50%|
| error     | border `risk`, bg `risk/10`                                      | border `risk`, bg `risk/10`                     |

Label sits to the right, 8px gap, `body` size, `ink-800` color. Helper/error
text below label at `body-sm`, `ink-500` (helper) or `risk` (error).

### 10.3 Dropdown (menu)

Dropdown is an action menu (user menu, row-actions, overflow). Built on
Radix `DropdownMenu`.

**Trigger** — any button variant; common pattern is `ghost` + `icon-only`
(three-dot menu) or `secondary` + `icon-right` (⌄ chevron).

| State    | Trigger                                    | Menu surface                                     | Item                                  |
|----------|--------------------------------------------|--------------------------------------------------|---------------------------------------|
| default  | `ghost` button default                      | hidden                                           | (n/a)                                 |
| focus    | + `glow-brand` ring                         | hidden                                           | (n/a)                                 |
| open     | bg `brand-50`, text `brand-700`             | `paper-0` bg, `r-lg`, `shadow-md`, 4px pad       | `body` text, 8×12 pad, `r-sm`         |
| selected | —                                           | —                                                | bg `brand-50`, text `brand-700`, `check` icon right |
| disabled | opacity 50%, pointer events off             | —                                                | text `ink-400`, pointer events off    |

Menu min-width 192px, max-width 320px. Items have 32px min-height. Group
headers use `label` token. Separator 1px `paper-200`.

### 10.4 Select (form field)

Select is a single-choice form input. Built on Radix `Select`.

| State    | Trigger (the field)                                             | Popover                                        | Option                              |
|----------|-----------------------------------------------------------------|------------------------------------------------|-------------------------------------|
| default  | 40px h, border `paper-200`, text `ink-900`, chevron-down right | hidden                                         | (n/a)                               |
| focus    | border `brand-600`, ring `brand-600/20` (3px)                   | hidden                                         | (n/a)                               |
| open     | border `brand-600`, chevron rotates 180°                         | `paper-0`, `r-md`, `shadow-md`, max-h 320, scroll | highlighted row uses `brand-50` bg |
| filled   | text `ink-900`, border `paper-200`                              | —                                              | —                                   |
| selected | check icon (optional) + highlighted row                          | —                                              | bg `brand-50`, text `brand-700`    |
| error    | border `risk`, ring `risk/20`                                    | —                                              | —                                   |
| disabled | bg `paper-100`, text `ink-400`, border `paper-200`               | —                                              | —                                   |

Placeholder: `ink-300` text. When empty, show placeholder; when set, show
value in `ink-900`.

### 10.5 Date picker

Single date + range variants. Built on Radix `Popover` + `react-day-picker`
(or `@internationalized/date` if we need full locale rigor).

| State    | Trigger input                                             | Popover calendar                                                   |
|----------|-----------------------------------------------------------|--------------------------------------------------------------------|
| default  | same as Select trigger, shows `Select date` placeholder   | hidden                                                             |
| open     | border `brand-600`                                         | `paper-0` surface, `r-lg`, `shadow-lg`, 16px pad                  |
| selected | text `ink-900` with formatted date (`Apr 28, 2026`)        | selected day: `brand-600` bg, `paper-0` text, `r-md`               |
| range    | `Apr 28 → May 10, 2026`                                    | range: `brand-50` bg between endpoints, endpoints `brand-600`      |
| disabled | bg `paper-100`, text `ink-400`                             | disabled dates: `ink-300`, struck-through on hover                 |
| today    | —                                                          | ring `brand-600/30` around the current day                          |

Calendar cell: 32×32, `body-sm` numeric, hover `paper-100`. Month nav:
`ghost` icon-button `ChevronLeft`/`ChevronRight`. Year select: `Select`
pattern embedded in header.

### 10.6 Tabs

Underline tabs (primary pattern) and segmented tabs (secondary pattern).

**Underline tabs**:

| State    | Tab                                                            |
|----------|----------------------------------------------------------------|
| default  | text `ink-600`, 2px transparent bottom border                 |
| hover    | text `ink-800`                                                 |
| active   | text `brand-700`, 2px `brand-600` bottom border               |
| focus    | + `glow-brand` ring on the tab hit-area                        |
| disabled | text `ink-400`, opacity 50%, pointer events off                |

Height 44px (comfortable) / 36px (compact). Padding 0 12px. Gap between
tabs: 4px. Bottom border of the tablist: 1px `paper-200`.

**Segmented tabs** (for density-compact toolbars):

| State    | Tab                                                            |
|----------|----------------------------------------------------------------|
| default  | bg transparent, text `ink-700`                                 |
| hover    | bg `paper-100`                                                 |
| active   | bg `paper-0`, text `ink-900`, `shadow-xs`                     |
| focus    | + `glow-brand` ring                                            |
| disabled | opacity 50%                                                    |

Container: bg `paper-100`, `r-md`, 2px pad. Tab: 32px h, `body-sm`, 4px pad.

### 10.7 Breadcrumb

| State    | Item                                           |
|----------|------------------------------------------------|
| default  | text `ink-500`, `body-sm`, separator `/ ` in `ink-300` |
| hover    | text `ink-800`                                 |
| current  | text `ink-900`, weight 540, no link            |

Truncate long items with `…` at 24ch. Collapse middle items with a `…`
ellipsis button (Radix `DropdownMenu` below) when the trail exceeds 4 items.

### 10.8 Disabled states — composite surfaces

| Surface      | Disabled treatment                                                       |
|--------------|--------------------------------------------------------------------------|
| Tab          | text `ink-400`, opacity 50%, pointer-events off                          |
| Nav item     | text `ink-400`, icon `ink-400`, no hover bg, tooltip `"Coming soon"` if user hovers |
| Card (interactive) | opacity 60%, cursor `not-allowed`, hover effects disabled          |
| Any button   | see §10.1 disabled row                                                    |
| Any form input | see §10.10 Input disabled                                              |

Global principle: disabled = muted foreground at 50% alpha, frozen pointer
events, no hover/active response.

### 10.9 Toast notification

Built on `sonner`. Fixed position bottom-right (comfortable) or top-right
(dense surfaces). Width 380px. Auto-dismiss 5s (info/success), 8s (warning),
persistent (error, until dismissed). All have a close (×) icon-button.

| Variant   | Surface                           | Icon (Lucide)         | Text                                  |
|-----------|-----------------------------------|-----------------------|---------------------------------------|
| default   | bg `ink-900`, text `paper-0`     | —                     | `body-sm`                             |
| success   | bg `compliant-50`, text `compliant` | `CheckCircle`      | `body-sm` ink-900 title, ink-700 body |
| error     | bg `risk-50`, text `risk`         | `AlertCircle`         | same                                  |
| warning   | bg `mitigated-50`, text `mitigated` | `AlertTriangle`    | same                                  |
| info      | bg `evidence-50`, text `evidence` | `Info`                | same                                  |
| dismissed | (animating out)                   | —                     | slide-right + fade 200ms emphasized   |

Radius `r-lg` (12). Shadow `shadow-lg`. 1px border matching the tint's
`*-100` color (subtle, NOT the pill's no-border treatment — toasts benefit
from a slight outline to separate from dense backgrounds). Icon sits
top-left; close ×  top-right.

> Note: Toasts are the **one place** where an icon is retained for category
> at a glance — they're ephemeral and out-of-reading-flow. Pills stay
> text-only.

### 10.10 Pills — no border, no icon

See §4. Sizes:

| Size | Height | Padding X | Font                         |
|------|--------|-----------|------------------------------|
| sm   | 20     | 8         | `label` at 11px              |
| md   | 24     | 10        | `label` at 12px (default)    |
| lg   | 28     | 12        | `label` at 13px              |

**State × variant matrix** (shared by status + severity taxonomies):

| State     | Default       | Success       | Error         | Warning       | Info          | Disabled       |
|-----------|---------------|---------------|---------------|---------------|---------------|----------------|
| bg        | `draft-50`    | `compliant-50`| `risk-50`     | `mitigated-50`| `evidence-50` | `paper-100`   |
| text      | `draft`       | `compliant`   | `risk`        | `mitigated`   | `evidence`    | `ink-400`      |

GRC severity mapping (same visual treatment, different label text):
Critical → Error tint; High → Warning tint (stronger — `high-50` / `high`);
Medium → Warning muted; Low → Success; Info → Info.

### 10.11 Input

**Sizes**:

| Size | Height | Padding | Font      | Icon |
|------|--------|---------|-----------|------|
| sm   | 32 / 2.00 | 8/10    | `body-sm` | 14   |
| md   | 40 / 2.50 | 10/12   | `body`    | 16   |
| lg   | 48 / 3.00 | 12/16   | `body-lg` | 18   |

**States**:

| State      | Border        | Background    | Text         | Notes                                |
|------------|---------------|---------------|--------------|--------------------------------------|
| default    | `paper-200`   | `paper-0`     | `ink-900`    | placeholder `ink-300`                |
| hover      | `paper-300`   | `paper-0`     | `ink-900`    |                                      |
| focus      | `brand-600`   | `paper-0`     | `ink-900`    | + 3px ring `brand-600/20`            |
| filled     | `paper-200`   | `paper-0`     | `ink-900`    | same as default but with value set   |
| error      | `risk`        | `risk-50`     | `ink-900`    | + 3px ring `risk/20` on focus        |
| success    | `compliant`   | `compliant-50`| `ink-900`    | + 3px ring `compliant/20` on focus   |
| disabled   | `paper-200`   | `paper-100`   | `ink-400`    | no hover/focus response              |
| read-only  | `paper-200`   | `paper-50`    | `ink-800`    | selectable text, no caret            |

**Composition variants**:

- **with label** — `label` token (12px uppercase) above, 6px gap.
- **with helper text** — `body-sm` `ink-500` below, 4px gap.
- **with error text** — `body-sm` `risk` below, 4px gap, `AlertCircle`
  icon 14px inline left of text.
- **with icon left** — icon at 14/16/18 (by size) `ink-500`, left pad 40/44/52 instead of 10/12/16.
- **with icon right** — same geometry, right-aligned, common for search clear (×), password toggle, date picker trigger.
- **with placeholder** — `ink-300`, same font as value; disappears on input.

### 10.12 Modal / Dialog

Built on Radix `Dialog`. Overlay: `ink-900/40` + 4px backdrop-blur.

**Sizes**:

| Size       | Max width | Min height | Padding      | Use                             |
|------------|-----------|------------|--------------|---------------------------------|
| sm         | 400 / 25.0 | 160        | 24/20/16     | Confirmations, quick forms      |
| md         | 560 / 35.0 | 240        | 32/24/24     | Default — edit forms            |
| lg         | 720 / 45.0 | 320        | 40/32/32     | Detail views, record editors    |
| xl         | 960 / 60.0 | 480        | 48/40/40     | Complex workflows, multi-step   |
| fullscreen | 100vw     | 100vh      | 48/64/48     | Immersive editing, reports      |
| auto       | max-content, up to 90vw | auto | inherits   | Content-fit (e.g., image lightbox) |

Structure:

- **Header**: title (`display-sm` for narrative / `heading-md` for task) +
  optional subtitle in `ink-500`; close × top-right as icon-only ghost.
- **Body**: padding per size; body font; 16px gap between fields.
- **Footer**: right-aligned action row, primary CTA rightmost, secondary
  left of it. Destructive actions use `destructive` variant.

Radius `r-xl` (16). Shadow `shadow-xl`. Animation: fade 200ms + scale
0.96 → 1 standard ease, reverse on close.

### 10.13 Icon library

Source: **Lucide** (`lucide-react`). Tree-shakable. Stroke-based (pairs
well with the editorial/serif atmosphere — no filled glyphs).

**Recommended GRC icon set** (keep to this short catalog unless a new
surface truly needs more):

| Category          | Icons                                                                   |
|-------------------|-------------------------------------------------------------------------|
| Risk & severity   | `Shield`, `ShieldAlert`, `ShieldCheck`, `AlertCircle`, `AlertTriangle`, `AlertOctagon` |
| Compliance        | `CheckCircle2`, `XCircle`, `MinusCircle`, `Clock`, `CalendarCheck`      |
| Audit & evidence  | `ClipboardCheck`, `ClipboardList`, `FileText`, `FileCheck`, `Paperclip`, `Link2` |
| Data & reporting  | `BarChart3`, `LineChart`, `PieChart`, `TrendingUp`, `TrendingDown`, `Download`, `Upload`, `Filter`, `Search` |
| Navigation & UI   | `ChevronDown`, `ChevronRight`, `ChevronLeft`, `ChevronUp`, `MoreHorizontal`, `MoreVertical`, `X`, `Menu`, `Settings2` |
| Action            | `Plus`, `Minus`, `Edit3`, `Trash2`, `Copy`, `Send`, `Share2`, `RefreshCw` |
| AI                | `Sparkles`, `Wand2`, `Bot`, `Zap`, `MessageSquare`, `Brain`            |
| People & access   | `User`, `Users`, `UserCheck`, `UserX`, `Lock`, `Unlock`, `Key`         |
| Time & workflow   | `History`, `CalendarDays`, `ArrowRight`, `ArrowLeft`, `CornerDownRight`|
| Sources           | `BookOpen`, `Database`, `Cloud`, `GitBranch`, `Layers`                 |

Sizes: use §3.4 icon-size tokens. All icons inherit `currentColor`. Never
set `fill=` on a Lucide SVG.

---

## License & attribution

This `DESIGN.md` is the canonical specification for the design system.
Treat it as the source of truth. If UI and this document disagree, this
document wins until explicitly amended.

Format inspired by the `getdesign.md` 9-section convention. Tuned for
GRC SaaS; assumes React 19 + Tailwind v4 + shadcn/ui + Radix primitives.

_Last refined: 2026-04-21._

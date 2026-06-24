// =====================================================================
//  Petra Construction, Company Profile
//  Theme + reusable components  (revamp 2)
//  Warm-black base, gold primary, teal/steel secondary, warm clay tint,
//  plus semantic status colours, to bring the document to life.
// =====================================================================

// ---- Palette (generated in OKLCH via tools/palette.py) --------------
// Luxury principle: one metallic accent (gold) carries the design;
// warm onyx + cream neutrals do the structural work; a single deep,
// muted navy complement is used only as an occasional panel surface.
//
// Warm neutrals (very low chroma, hue ≈ gold so blacks read warm)
#let bg-base    = rgb("#0C0B08")   // warm onyx
#let bg-card    = rgb("#191713")   // panel / card
#let bg-card-2  = rgb("#23201B")   // raised panel
#let border-col = rgb("#36322C")   // hairline borders
#let text-white = rgb("#F4F1EC")   // cream / ivory (headings)
#let text-body  = rgb("#C1BDB7")   // warm light grey (body)
#let text-muted = rgb("#89867E")   // muted taupe (captions / labels)

// The one accent: gold
#let gold       = rgb("#C9A24B")   // primary (brand)
#let gold-light = rgb("#F2D089")
#let gold-deep  = rgb("#A98328")

// Complement, deep & muted (used sparingly, as a surface)
#let bg-navy    = rgb("#232D45")   // deep navy panel
#let bg-navy-2  = rgb("#2B3650")
#let navy       = rgb("#3E4D6B")
#let navy-soft  = rgb("#8B98B5")

// Muted, earthy status colours
#let success    = rgb("#84A98B")   // sage (completed)
#let amber      = rgb("#C39D71")   // honey (ongoing)

// Back-compat aliases (old names → restrained palette, no rainbow)
#let steel       = navy
#let steel-light = navy-soft
#let steel-deep  = navy
#let clay        = gold
#let clay-light  = gold-light

// ---- Type ----------------------------------------------------------
#let body-font    = "Nimbus Sans"
#let display-font = "Nimbus Sans"

// ---- Small helpers -------------------------------------------------

// Uppercase, letter-spaced eyebrow label (accent-coloured)
#let eyebrow(body, accent: gold) = text(
  font: display-font, size: 9pt, weight: "bold",
  fill: accent, tracking: 3pt,
)[#upper(body)]

// A short accent rule
#let accent-rule(w: 52pt, accent: gold) = box(width: w, height: 3pt, radius: 1.5pt, fill: accent)
#let gold-rule(w: 52pt) = accent-rule(w: w, accent: gold)   // backwards-compat

// Large section title: number tab + kicker + title + double rule
#let section-title(kicker, title, accent: gold, size: 31pt) = {
  block(spacing: 0pt)[
    #eyebrow(kicker, accent: accent)
    #v(10pt)
    #text(font: display-font, size: size, weight: "bold", fill: text-white)[#title]
    #v(12pt)
    #stack(dir: ltr, spacing: 5pt,
      box(width: 40pt, height: 3pt, radius: 1.5pt, fill: accent),
      box(width: 14pt, height: 3pt, radius: 1.5pt, fill: accent.transparentize(55%)),
    )
  ]
  v(20pt)
}

// Transparent logo (cream + gold) for dark pages
#let logo-badge(width: 150pt) = image("../assets/logo/logo-dark.png", width: width)

// A bordered card with an optional coloured top edge
#let card(body, fill: bg-card, accent: none) = block(
  width: 100%, fill: fill,
  stroke: if accent != none { (top: 2.5pt + accent, rest: 0.6pt + border-col) } else { 0.6pt + border-col },
  radius: 5pt, inset: 16pt,
)[#body]

// Big stat: number + label + note  (size adjustable)
#let stat(number, label, note: none, accent: gold-light, size: 28pt) = {
  text(font: display-font, size: size, weight: "bold", fill: accent)[#number]
  v(4pt)
  text(font: display-font, size: 9pt, weight: "bold", fill: text-white, tracking: 1.5pt)[#upper(label)]
  if note != none {
    v(4pt)
    text(size: 8.5pt, fill: text-muted)[#note]
  }
}

// Compact project-meta tile: label + readable value (+ optional status dot)
#let meta-item(label, value, note: none, accent: text-white, dot: none) = card(fill: bg-card-2)[
  #text(size: 8pt, fill: gold, tracking: 1.5pt)[#upper(label)]
  #v(7pt)
  #if dot != none {
    box(baseline: -1pt, circle(radius: 3pt, fill: dot))
    h(6pt)
  }
  #text(font: display-font, size: 15pt, weight: "bold", fill: accent)[#value]
  #if note != none {
    v(4pt)
    text(size: 8.5pt, fill: text-muted)[#note]
  }
]

// Photo caption
#let caption(body) = align(center)[
  #text(size: 8pt, fill: text-muted, tracking: 1pt)[#upper(body)]
]

// =====================================================================
//  Organisation chart (high-contrast, coloured connectors)
// =====================================================================
#let conn = steel-light
#let drop(h: 14pt) = align(center, box(width: 2pt, height: h, fill: conn))

#let org-node(title, sub: none, accent: steel, fill: bg-card-2, fg: text-white) = block(
  width: 100%, fill: fill,
  stroke: (left: 3pt + accent, rest: 0.6pt + border-col),
  radius: 4pt, inset: (x: 12pt, y: 11pt),
)[
  #align(center)[
    #text(font: display-font, size: 10.5pt, weight: "bold", fill: fg)[#title]
    #if sub != none [
      #v(3pt)
      #text(size: 8.5pt, fill: if fg == bg-base { rgb("#3a3a3a") } else { text-muted })[#sub]
    ]
  ]
]

#let org-chart() = {
  // Tier 1
  align(center, box(width: 62%,
    block(width: 100%, fill: gold, radius: 5pt, inset: (x: 14pt, y: 13pt))[
      #align(center)[
        #text(font: display-font, size: 13pt, weight: "bold", fill: bg-base)[Director / Engineer]
        #v(2pt)
        #text(size: 9pt, fill: rgb("#4a3c18"))[Gayindu Umesh Perera]
      ]
    ]
  ))
  drop(h: 16pt)
  line(length: 100%, stroke: 1pt + conn)
  grid(columns: (1fr, 1fr, 1fr), drop(), drop(), drop())
  v(2pt)
  grid(columns: (1fr, 1fr, 1fr), gutter: 12pt,
    org-node("Chief Quantity Surveyor", sub: "Chithra Perera", accent: steel),
    org-node("Secretary", sub: "Ramya de Silva", accent: clay),
    org-node("Construction Manager", sub: "Yasoda S. Abeykoon", accent: gold),
  )
  // Tier 3 under the Construction Manager (3rd column)
  grid(columns: (1fr, 1fr, 1fr), [], [], drop())
  grid(columns: (1fr, 1fr, 1fr), [], [], [
    #line(length: 100%, stroke: 1pt + conn)
    #grid(columns: (1fr, 1fr), drop(h: 12pt), drop(h: 12pt))
    #v(2pt)
    #grid(columns: (1fr, 1fr), gutter: 8pt,
      org-node("Civil", sub: "Supervisor", accent: steel-deep),
      org-node("M&E", sub: "Supervisor", accent: steel-deep),
    )
  ])
}

// =====================================================================
//  Document shell
// =====================================================================
#let profile(body) = {
  set document(title: "Petra Construction, Company Profile", author: "Petra Construction Co. (Pvt.) Ltd.")
  set page(
    width: 210mm, height: 297mm,
    margin: (x: 22mm, top: 24mm, bottom: 20mm),
    fill: bg-base,
    header: context {
      let pg = counter(page).get().first()
      if pg == 1 { return }
      set text(size: 8pt, fill: text-muted, tracking: 1.5pt)
      grid(
        columns: (auto, 1fr, auto),
        align: (left + horizon, center, right + horizon),
        gutter: 8pt,
        grid(columns: (auto, auto), gutter: 6pt, align: horizon,
          box(width: 5pt, height: 5pt, radius: 1pt, fill: gold),
          upper[Petra Construction],
        ),
        [],
        upper[Company Profile],
      )
      v(5pt)
      line(length: 100%, stroke: 0.5pt + border-col)
    },
    footer: context {
      let pg = counter(page).get().first()
      if pg == 1 { return }
      let total = counter(page).final().first()
      line(length: 100%, stroke: 0.5pt + border-col)
      v(5pt)
      set text(size: 8pt, fill: text-muted, tracking: 1pt)
      grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        upper[Solid foundations · Timeless structures],
        [#text(fill: gold, weight: "bold")[#pg] #h(2pt) / #h(2pt) #total],
      )
    },
  )
  set text(font: body-font, size: 10.5pt, fill: text-body, lang: "en", hyphenate: false)
  set par(justify: false, leading: 0.78em, spacing: 1.1em)

  show heading: it => block[
    #text(font: display-font, fill: text-white, weight: "bold")[#it.body]
  ]

  body
}

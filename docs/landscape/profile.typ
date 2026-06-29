// =====================================================================
//  Petra Construction - Company Profile (LANDSCAPE edition)
//  Reuses the palette + components from ../lib.typ, adds a landscape
//  shell with a vertical "COMPANY PROFILE" side band and the logo at
//  the bottom of the band on every page.
// =====================================================================
#import "../../lib/theme.typ": *

#set document(
  title: "Petra Construction, Company Profile",
  author: "Petra Construction Co. (Pvt.) Ltd.",
)

// =====================================================================
//  LIGHT (PRINT-FRIENDLY) THEME, landscape only
//  The shared theme.typ is dark. For the printed landscape copy we use a
//  warm cream paper with dark ink text and gold accents, so it reads
//  clearly on paper. These local definitions override the dark ones for
//  THIS document only; the portrait profile stays dark.
// =====================================================================
// Warm cream neutrals
#let bg-base    = rgb("#F6F1E9")   // warm cream page
#let bg-card    = rgb("#FFFFFF")   // white panel
#let bg-card-2  = rgb("#F1E9DB")   // raised warm panel
#let border-col = rgb("#E2DACB")   // soft hairline border
#let text-white = rgb("#1C1814")   // near-black ink (headings)
#let text-body  = rgb("#4A443B")   // dark warm grey (body)
#let text-muted = rgb("#8A8275")   // muted taupe (captions / labels)

// Gold, deepened a touch so it reads on cream
#let gold       = rgb("#A57C22")   // primary accent (also small text)
#let gold-light = rgb("#C9A24B")   // brighter gold for large fills
#let gold-deep  = rgb("#7E631A")

// Accents / status, deepened for the light background
#let navy       = rgb("#2E3A55")
#let conn       = rgb("#B7AD98")   // org-chart connectors on cream
#let steel      = navy
#let clay       = gold
#let success    = rgb("#4E7C5B")   // completed
#let amber      = rgb("#A9772F")   // ongoing

// ---- Components, rebound to the light palette above -----------------
#let eyebrow(body, accent: gold) = text(
  font: display-font, size: 9pt, weight: "bold",
  fill: accent, tracking: 3pt,
)[#upper(body)]

#let accent-rule(w: 52pt, accent: gold) = box(width: w, height: 3pt, radius: 1.5pt, fill: accent)

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

#let card(body, fill: bg-card, accent: none) = block(
  width: 100%, fill: fill,
  stroke: if accent != none { (top: 2.5pt + accent, rest: 0.6pt + border-col) } else { 0.6pt + border-col },
  radius: 5pt, inset: 16pt,
)[#body]

#let stat(number, label, note: none, accent: gold, size: 28pt) = {
  text(font: display-font, size: size, weight: "bold", fill: accent)[#number]
  v(4pt)
  text(font: display-font, size: 9pt, weight: "bold", fill: text-white, tracking: 1.5pt)[#upper(label)]
  if note != none {
    v(4pt)
    text(size: 8.5pt, fill: text-muted)[#note]
  }
}

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
      #text(size: 8.5pt, fill: text-muted)[#sub]
    ]
  ]
]

#let LOGO = "../../assets/logo/logo-light.png"

// ---- The left side band (drawn on every page) ----------------------
#let side-band = {
  // strip surface
  place(top + left, rect(width: 26mm, height: 100%, fill: bg-card))
  // gold edge rule
  place(top + left, dx: 26mm, rect(width: 1.2pt, height: 100%, fill: gold))
  // vertical COMPANY PROFILE text (reads bottom-to-top), centred in strip
  place(left + horizon, dx: -67mm,
    rotate(-90deg, origin: center,
      box(width: 160mm, height: 26mm)[
        #align(center + horizon, text(size: 10pt, fill: text-muted, tracking: 6pt)[
          #upper[Company Profile]
        ])
      ]))
  // emblem top + bottom of the strip
  place(top + left, dx: 3mm, dy: 9mm, image(LOGO, width: 20mm))
  place(bottom + left, dx: 3mm, dy: -9mm, image(LOGO, width: 20mm))
}

#set page(
  width: 297mm, height: 210mm,
  margin: (left: 38mm, right: 18mm, top: 17mm, bottom: 16mm),
  fill: bg-base,
  background: side-band,
  footer: context {
    let pg = counter(page).get().first()
    if pg == 1 { return }
    set text(size: 8pt, fill: text-muted, tracking: 1pt)
    grid(columns: (1fr, auto),
      align: (left + horizon, right + horizon),
      upper[Solid foundations · Timeless structures],
      [petraconstructions.lk #h(10pt) #text(fill: gold, weight: "bold")[#pg]],
    )
  },
)
#set text(font: body-font, size: 10.5pt, fill: text-body, lang: "en", hyphenate: false)
#set par(justify: false, leading: 0.78em, spacing: 1.1em)

// Uniform cropped photo tile
#let tile(path, h: 52mm) = box(
  width: 100%, clip: true, radius: 3pt, stroke: 0.6pt + border-col,
)[#image(path, width: 100%, height: h, fit: "cover")]

// =====================================================================
//  PAGE 1 - COVER
// =====================================================================
#place(top + right, dx: 18mm, dy: -17mm,
  rect(width: 150mm, height: 150mm,
    fill: gradient.radial(gold.transparentize(72%), bg-base.transparentize(100%),
      center: (100%, 0%), radius: 90%)))

#place(top + right, text(size: 9pt, fill: text-muted, tracking: 2pt)[COMPANY PROFILE · 2026])

#v(1fr)
#grid(
  columns: (1.35fr, 1fr),
  align: (left + horizon, center + horizon),
  gutter: 20pt,
  [
    #eyebrow[Solid Foundations · Timeless Structures]
    #v(12pt)
    #text(font: display-font, size: 56pt, weight: "bold", fill: text-white)[Petra]
    #v(-14pt)
    #text(font: display-font, size: 56pt, weight: "bold", fill: gold)[Construction]
    #v(12pt)
    #text(size: 16pt, style: "italic", fill: gold)[On this rock we build.]
    #v(10pt)
    #block(width: 92%)[
      #text(size: 13pt, fill: text-body)[
        Precision-engineered residences and structures, built to endure. Civil, M&E
        and turnkey construction delivered with engineering rigour.
      ]
    ]
  ],
  image(LOGO, width: 165pt),
)
#v(1fr)
#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 16pt,
  card(stat([4], "Signature Projects", note: [Completed & in progress], size: 30pt)),
  card(stat([Rs 500M+], "Project Value", note: [Across the portfolio], size: 26pt)),
  card(stat([100%], "Client-Led Delivery", note: [Quality · Safety · On-time], size: 30pt)),
)

#pagebreak()

// =====================================================================
//  PAGE 2 - ABOUT
// =====================================================================
#section-title("01 · Who We Are", "About Petra")

#grid(
  columns: (1.25fr, 1fr),
  gutter: 22pt,
  align: (left + top, left + top),
  [
    #text(size: 11.5pt, fill: text-body)[
      *Petra Construction Co. (Pvt.) Ltd.* is a Sri Lankan construction and engineering
      company delivering precision-built residential and commercial structures. From
      complex foundations to fully finished luxury homes, we combine sound engineering
      with careful craftsmanship to create spaces that are built to last.
    ]
    #v(10pt)
    #text(size: 11.5pt, fill: text-body)[
      Founded by a civil engineer trained internationally, Petra was established on a
      simple intention: to raise the standard of construction quality, transparency and
      reliability for our clients. Every project, whether a private residence or an
      industrial structure, is managed end to end by qualified engineers and quantity
      surveyors.
    ]
    #v(16pt)
    #grid(columns: (1fr, 1fr, 1fr), gutter: 12pt,
      card(stat([Civil], "Core Discipline", note: [RCC & structures], size: 22pt)),
      card(stat([M&E], "Building Services", note: [Mechanical & electrical], size: 22pt)),
      card(stat([Turnkey], "Delivery Model", note: [Concept to handover], size: 22pt)),
    )
  ],
  [
    #card[
      #eyebrow[What We Do]
      #v(8pt)
      #text(fill: text-body)[
        Design-led civil construction, mechanical & electrical (M&E) works, and turnkey
        delivery of luxury and semi-luxury homes, managed from first survey to final
        handover.
      ]
    ]
    #v(12pt)
    #card[
      #eyebrow[Our Approach]
      #v(8pt)
      #text(fill: text-body)[
        Engineer-led, cost-controlled and safety-first. Detailed quantity surveying
        keeps budgets accurate, while on-site supervision keeps quality high and timelines
        on track.
      ]
    ]
  ],
)

#pagebreak()

// =====================================================================
//  PAGE 3 - MISSION, VISION & VALUES
// =====================================================================
#section-title("02 · Our Purpose", "Mission, Vision & Values")

#grid(
  columns: (1fr, 1fr),
  gutter: 16pt,
  card(fill: bg-card-2)[
    #eyebrow("Our Vision", accent: gold)
    #v(10pt)
    #text(size: 11.5pt, fill: text-white)[
      To be Sri Lanka's most trusted name in engineered construction, the partner
      clients choose when quality, integrity and lasting value matter most.
    ]
  ],
  card(fill: bg-card-2)[
    #eyebrow("Our Mission", accent: gold)
    #v(10pt)
    #text(size: 11.5pt, fill: text-white)[
      To deliver precision-built structures through engineering excellence, transparent
      costing and uncompromising safety, on time, every time.
    ]
  ],
)

#v(18pt)
#eyebrow("Our Values")
#v(12pt)

#let value(title, desc) = card[
  #text(font: display-font, size: 12.5pt, weight: "bold", fill: gold)[#title]
  #v(6pt)
  #text(size: 9pt, fill: text-body)[#desc]
]

#grid(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  gutter: 10pt,
  value("Integrity", "Honest costing and transparent communication."),
  value("Engineering Rigour", "Qualified engineers lead every stage."),
  value("Safety First", "Disciplined site practices that protect people."),
  value("Craftsmanship", "Detailing held to a luxury standard."),
  value("Reliability", "Realistic timelines, met with discipline."),
  value("Client Partnership", "We build for the people who use it."),
)

#pagebreak()

// =====================================================================
//  PAGE 4 - SERVICES
// =====================================================================
#section-title("03 · Capabilities", "Our Services")

#let service(title, items) = card[
  #text(font: display-font, size: 13pt, weight: "bold", fill: text-white)[#title]
  #v(6pt)
  #accent-rule(w: 30pt, accent: gold)
  #v(10pt)
  #for it in items [
    #grid(columns: (11pt, 1fr), text(fill: gold)[•], text(size: 9pt, fill: text-body)[#it])
    #v(5pt)
  ]
]

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 14pt,
  service("Civil Engineering", (
    "Reinforced concrete (RCC) structures",
    "Foundations, columns & slabs",
    "Masonry, plastering & waterproofing",
    "Luxury & semi-luxury homes",
  )),
  service("Mechanical & Electrical", (
    "Electrical installation & distribution",
    "Plumbing, water & sanitary systems",
    "HVAC & ventilation",
    "Building services coordination",
  )),
  service("Project & Cost Management", (
    "Quantity surveying & BOQ preparation",
    "Transparent cost estimation",
    "Site supervision & quality control",
    "Programme & timeline management",
  )),
  service("Turnkey Delivery", (
    "Design coordination",
    "End-to-end project execution",
    "Interior finishing & fit-out",
    "Handover & after-care",
  )),
)

#pagebreak()

// =====================================================================
//  PAGE 5 - OUR TEAM
// =====================================================================
#section-title("04 · The People", "Our Team")

#let person(name, role, creds) = card[
  #text(font: display-font, size: 12pt, weight: "bold", fill: text-white)[#name]
  #v(3pt)
  #text(size: 8.5pt, fill: gold, tracking: 1pt)[#upper(role)]
  #v(9pt)
  #line(length: 100%, stroke: 0.5pt + border-col)
  #v(9pt)
  #text(size: 9pt, fill: text-body)[#creds]
]

#grid(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr),
  gutter: 12pt,
  person("Gayindu Umesh Perera", "Director / Engineer",
    [BSc in Civil Engineering, RMIT University, Australia. Leads engineering, design and overall delivery.]),
  person("Chitra Perera", "Chief Quantity Surveyor",
    [City & Guilds · AMASI · MSST (London). Heads cost planning, BOQs and quantity surveying.]),
  person("Yasoda Srimal Abeykoon", "Construction Manager",
    [HND in Quantity Surveying, University of Liverpool. Manages site execution and programming.]),
  person("Nimal Thanthriarachchi", "M&E Engineer",
    [35 years' experience in the hotel industry, specialised in air-conditioning, refrigeration and heating.]),
  person("Ramya De Silva", "Secretary",
    [Coordinates administration, client communication and project documentation.]),
)

#pagebreak()

// =====================================================================
//  PAGE 6 - ORGANISATION STRUCTURE
// =====================================================================
#section-title("05 · How We Work", "Organisation Structure")

#v(6pt)
#align(center, box(width: 42%,
  block(width: 100%, fill: gold-light, radius: 5pt, inset: (x: 14pt, y: 12pt))[
    #align(center)[
      #text(font: display-font, size: 13pt, weight: "bold", fill: rgb("#2A2114"))[Director / Engineer]
      #v(2pt)
      #text(size: 9pt, fill: rgb("#4a3c18"))[Gayindu Umesh Perera]
    ]
  ]))
#drop(h: 18pt)
#line(length: 100%, stroke: 1pt + conn)
#grid(columns: (1fr, 1fr, 1fr, 1fr), drop(), drop(), drop(), drop())
#v(2pt)
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 14pt,
  org-node("Chief Quantity Surveyor", sub: "Chitra Perera", accent: steel),
  org-node("Construction Manager", sub: "Yasoda Srimal Abeykoon", accent: clay),
  org-node("M&E Engineer", sub: "Nimal Thanthriarachchi", accent: steel),
  org-node("Secretary", sub: "Ramya De Silva", accent: clay),
)

#v(20pt)
#align(center)[#text(size: 9.5pt, fill: text-muted)[
  A lean, engineer-led structure: the Director / Engineer oversees quantity surveying,
  construction management, building services and administration.
]]

#pagebreak()

// =====================================================================
//  PROJECT pages (landscape spreads)
// =====================================================================
#let project(kicker, name, status, status-dot, type, type-note, loc, loc-note, photos, desc) = {
  section-title(kicker, name, size: 26pt)
  grid(columns: (1fr, 1fr, 1fr), gutter: 10pt,
    meta-item("Status", status, dot: status-dot, accent: status-dot),
    meta-item("Type", type, note: type-note),
    meta-item("Location", loc, note: loc-note),
  )
  v(12pt)
  grid(columns: (1fr,) * photos.len(), gutter: 10pt,
    ..photos.map(p => tile(p, h: 72mm)))
  v(12pt)
  text(size: 10.5pt, fill: text-body)[#desc]
}

#project(
  "06 · Completed Project", "Two-Storey Luxury Residence",
  "Completed", success, "Residence", [Two-storey luxury home], "Attidiya", [Sri Lanka],
  (
    "../../assets/projects/two-storey-attidiya/01-entrance.jpeg",
    "../../assets/projects/two-storey-attidiya/03-lake-view.jpeg",
    "../../assets/projects/two-storey-attidiya/02-living-dusk.jpeg",
    "../../assets/projects/two-storey-attidiya/04-bedroom.jpeg",
  ),
  [A two-storey luxury residence in Attidiya overlooking the lake. The design pairs warm
   timber detailing and open living spaces with an engineered concrete structure,
   delivering a calm, light-filled home framed by its waterside setting.],
)

#pagebreak()

#project(
  "07 · Completed Project", "Three-Storey Luxury Residence",
  "Completed", success, "Residence", [Three-storey luxury home], "Nedimala", [Sri Lanka],
  (
    "../../assets/projects/three-storey-nedimala/01-glass-dining.jpeg",
    "../../assets/projects/three-storey-nedimala/02-pool.jpeg",
    "../../assets/projects/three-storey-nedimala/03-lounge.jpeg",
    "../../assets/projects/three-storey-nedimala/04-staircase.jpeg",
  ),
  [A contemporary three-storey luxury home in Nedimala built around light and water.
   Floor-to-ceiling glazing, a private indoor pool and warm timber staircases are set
   against a crisp engineered structure, creating a calm, resort-like residence.],
)

#pagebreak()

#project(
  "08 · Completed Project", "Kalutara Luxury Hotel",
  "Completed", success, "Hotel", [Beachfront hospitality], "Kalutara", [Oceanfront setting],
  (
    "../../assets/projects/kalutara-hotel/01-exterior-night.jpeg",
    "../../assets/projects/kalutara-hotel/02-beach-dining.jpeg",
    "../../assets/projects/kalutara-hotel/03-sea-view-room.jpeg",
    "../../assets/projects/kalutara-hotel/05-restaurant.jpeg",
  ),
  [A beachfront luxury hotel built on a robust concrete frame with refined guest-room
   interiors, sea-facing balconies and a bright oceanside dining hall. Every space is
   oriented to the shoreline.],
)

#pagebreak()

#project(
  "09 · Project In Progress", "Low Cost Housing Project",
  "Ongoing", amber, "Housing", [Low cost build], "Kalawana", [Ratnapura District],
  (
    "../../assets/projects/kalawana-housing/01-blockwork.jpeg",
    "../../assets/projects/kalawana-housing/02-columns.jpeg",
    "../../assets/projects/kalawana-housing/03-roof-steel.jpeg",
  ),
  [A low cost housing project under construction at Kalawana, designed to deliver
   durable, well-built homes at an accessible price point, executed with the same care
   as our luxury work: reinforced concrete columns, precision blockwork and an engineered
   steel roof structure.],
)

#pagebreak()

// =====================================================================
//  FINAL - WHY PETRA + CONTACT
// =====================================================================
#place(bottom + right, dx: 18mm, dy: 16mm,
  rect(width: 150mm, height: 150mm,
    fill: gradient.radial(gold.transparentize(74%), bg-base.transparentize(100%),
      center: (100%, 100%), radius: 90%)))

#section-title("10 · Let's Build", "Why Choose Petra")

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 12pt,
  card[#text(fill: gold, weight: "bold")[Engineer-led.] #text(fill: text-body)[ Run by qualified engineers and quantity surveyors.]],
  card[#text(fill: gold, weight: "bold")[Transparent costing.] #text(fill: text-body)[ Detailed BOQs and accurate estimates.]],
  card[#text(fill: gold, weight: "bold")[Quality finishes.] #text(fill: text-body)[ Luxury-standard detailing and craftsmanship.]],
  card[#text(fill: gold, weight: "bold")[On-time delivery.] #text(fill: text-body)[ Disciplined sites and realistic programmes.]],
)

#v(1fr)

#grid(
  columns: (auto, 1fr),
  align: (center + horizon, left + top),
  gutter: 24pt,
  image(LOGO, width: 150pt),
  card(fill: bg-card-2)[
    #eyebrow[Get In Touch]
    #v(12pt)
    #grid(
      columns: (1fr, 1.2fr),
      column-gutter: 18pt,
      row-gutter: 14pt,
      [
        #text(size: 9pt, fill: gold, tracking: 1pt)[PHONE] \
        #v(3pt)
        #text(size: 10pt, fill: text-white)[077 735 6371 · 077 929 8315]
      ],
      [
        #text(size: 9pt, fill: gold, tracking: 1pt)[EMAIL] \
        #v(3pt)
        #text(size: 10pt, fill: text-white)[petraconstructionlk\@gmail.com]
      ],
      [
        #text(size: 9pt, fill: gold, tracking: 1pt)[ADDRESS] \
        #v(3pt)
        #text(size: 10pt, fill: text-white)[71A Lake Road, Attidiya, Dehiwala]
      ],
      [
        #text(size: 9pt, fill: gold, tracking: 1pt)[WEBSITE] \
        #v(3pt)
        #text(size: 10pt, fill: text-white)[petraconstructions.lk]
      ],
    )
  ],
)

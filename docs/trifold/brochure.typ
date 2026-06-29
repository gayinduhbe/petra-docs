// =====================================================================
//  Petra Construction, Tri-fold Brochure (leaflet)
//  One A4 landscape sheet, printed both sides, folded into 3 panels.
//  Print-friendly cream interior with a dark gold cover panel.
//  Reuses the fonts, logo and project photos from the shared project.
//
//  Panel layout (left -> right):
//    OUTSIDE page : Back / Contact | Teaser flap | Front cover
//    INSIDE  page : About + Why    | Services    | Signature projects
//
//  Printing: double-sided, flip on the SHORT edge, fold into thirds
//  with the cover facing out.
// =====================================================================
#import "../../lib/theme.typ": body-font, display-font

#set document(
  title: "Petra Construction, Brochure",
  author: "Petra Construction Co. (Pvt.) Ltd.",
)

// ---- Light, print-friendly palette (mirrors the landscape edition) --
#let bg-base    = rgb("#F6F1E9")   // warm cream page
#let bg-dark    = rgb("#0C0B08")   // warm onyx (cover panel)
#let bg-card    = rgb("#FFFFFF")   // white panel
#let bg-card-2  = rgb("#F1E9DB")   // raised warm panel
#let border-col = rgb("#E2DACB")   // soft hairline border
#let ink        = rgb("#1C1814")   // near-black ink (headings)
#let body       = rgb("#4A443B")   // dark warm grey (body)
#let muted      = rgb("#8A8275")   // muted taupe (captions / labels)
#let cream      = rgb("#F4F1EC")   // cream text (on dark)
#let cream-body = rgb("#C1BDB7")   // light body (on dark)
#let cream-mut  = rgb("#89867E")   // muted (on dark)

#let gold       = rgb("#A57C22")   // primary accent (reads on cream)
#let gold-light = rgb("#C9A24B")   // brighter gold (fills, on dark)
#let success    = rgb("#4E7C5B")   // completed
#let amber      = rgb("#A9772F")   // ongoing

// ---- Page: A4 landscape, full-bleed cream, no flow margin -----------
#set page(
  width: 297mm, height: 210mm,
  margin: 0pt,
  fill: bg-base,
)
#set text(font: body-font, size: 9pt, fill: body, lang: "en", hyphenate: false)
#set par(justify: false, leading: 0.7em, spacing: 0.95em)

// ---- Small helpers --------------------------------------------------
#let eyebrow(b, accent: gold) = text(
  font: display-font, size: 8pt, weight: "bold", fill: accent, tracking: 2.5pt,
)[#upper(b)]

#let rule-mark(w: 34pt, accent: gold) = box(width: w, height: 2.5pt, radius: 1.25pt, fill: accent)

#let head(kicker, title, size: 18pt, on-dark: false) = {
  eyebrow(kicker)
  v(7pt)
  text(font: display-font, size: size, weight: "bold",
    fill: if on-dark { cream } else { ink })[#title]
  v(8pt)
  rule-mark()
  v(12pt)
}

// One panel of the tri-fold: full height column with padding.
#let panel(body-content, fill: none, pad: 12mm) = block(
  width: 100%, height: 100%, fill: fill, inset: pad,
)[#body-content]

// Project photo cropped to a uniform tile.
#let tile(path, h: 30mm) = box(
  width: 100%, clip: true, radius: 3pt, stroke: 0.6pt + border-col,
)[#image(path, width: 100%, height: h, fit: "cover")]

// Compact status dot + label.
#let status(label, col) = {
  box(baseline: -1pt, circle(radius: 2.5pt, fill: col))
  h(5pt)
  text(size: 7.5pt, fill: muted, tracking: 1pt)[#upper(label)]
}

// Fold guide lines (subtle dashed verticals at the two folds).
#let fold-guides = place(top + left, dx: 0pt, dy: 0pt, box(width: 297mm, height: 210mm)[
  #place(left, dx: 99mm,  line(start: (0pt, 0pt), end: (0pt, 210mm),
    stroke: (paint: border-col, thickness: 0.5pt, dash: "dotted")))
  #place(left, dx: 198mm, line(start: (0pt, 0pt), end: (0pt, 210mm),
    stroke: (paint: border-col, thickness: 0.5pt, dash: "dotted")))
])

// =====================================================================
//  OUTSIDE PAGE :  Back / Contact  |  Teaser flap  |  Front cover
// =====================================================================
#fold-guides
#grid(
  columns: (1fr, 1fr, 1fr),
  rows: (100%),

  // ---- Panel 1 : BACK / CONTACT -------------------------------------
  panel(fill: bg-card-2)[
    #image("../../assets/logo/logo-light.png", width: 96pt)
    #v(1fr)
    #eyebrow[Get In Touch]
    #v(12pt)

    #text(size: 7.5pt, fill: gold, tracking: 1.5pt)[PHONE]
    #v(3pt)
    #text(size: 10pt, fill: ink, weight: "bold")[077 735 6371]
    #linebreak()
    #text(size: 10pt, fill: ink, weight: "bold")[077 929 8315]
    #v(11pt)

    #text(size: 7.5pt, fill: gold, tracking: 1.5pt)[EMAIL]
    #v(3pt)
    #text(size: 9.5pt, fill: ink)[inquiry\@petraconstructions.lk]
    #v(11pt)

    #text(size: 7.5pt, fill: gold, tracking: 1.5pt)[WEBSITE]
    #v(3pt)
    #text(size: 9.5pt, fill: ink)[petraconstructions.lk]
    #v(11pt)

    #text(size: 7.5pt, fill: gold, tracking: 1.5pt)[ADDRESS]
    #v(3pt)
    #text(size: 9.5pt, fill: ink)[71A Lake Road, \ Attidiya, Dehiwala]

    #v(1fr)
    #line(length: 100%, stroke: 0.5pt + border-col)
    #v(8pt)
    #text(size: 7pt, fill: muted, tracking: 1.5pt)[
      PETRA CONSTRUCTION CO. (PVT.) LTD.
    ]
  ],

  // ---- Panel 2 : TEASER FLAP (leads with projects) ------------------
  panel(fill: bg-base)[
    #eyebrow[Proven On Site]
    #v(7pt)
    #text(font: display-font, size: 17pt, weight: "bold", fill: ink)[
      Built to endure.
    ]
    #v(10pt)
    #tile("../../assets/projects/kalutara-hotel/02-beach-dining.jpeg", h: 58mm)
    #v(5pt)
    #text(size: 7.5pt, fill: muted, tracking: 1pt)[KALUTARA LUXURY HOTEL · COMPLETED]
    #v(12pt)
    #text(size: 9pt, fill: body)[
      From luxury homes to a beachfront hotel, every Petra project is
      engineer-led, costed transparently and finished to a standard we
      are proud to put our name to.
    ]
    #v(1fr)
    #grid(
      columns: (auto, 1fr),
      gutter: 10pt,
      align: (horizon, horizon),
      text(font: display-font, size: 30pt, weight: "bold", fill: gold)[4],
      text(size: 8.5pt, fill: ink, weight: "bold")[
        SIGNATURE PROJECTS \
        #text(weight: "regular", fill: muted)[Completed & in progress]
      ],
    )
  ],

  // ---- Panel 3 : FRONT COVER (light, premium) -----------------------
  panel(fill: bg-card-2, pad: 13mm)[
    #place(top + right, dx: 13mm, dy: -13mm,
      rect(width: 95mm, height: 95mm,
        fill: gradient.radial(gold.transparentize(80%), bg-card-2.transparentize(100%),
          center: (100%, 0%), radius: 90%)))
    #image("../../assets/logo/logo-light.png", width: 104pt)
    #v(1fr)
    #text(font: display-font, size: 38pt, weight: "bold", fill: ink)[Petra]
    #v(-12pt)
    #text(font: display-font, size: 38pt, weight: "bold", fill: gold)[Construction]
    #v(16pt)
    // Company motto, featured.
    #rule-mark(w: 30pt)
    #v(10pt)
    #text(font: display-font, size: 16pt, style: "italic", fill: ink)[
      Solid Foundations, \ Timeless Structures
    ]
    #v(14pt)
    #block(width: 94%)[
      #text(size: 9.5pt, fill: body)[
        Precision-engineered residences and structures, built to endure.
        Civil, M&E and turnkey construction, delivered with engineering rigour.
      ]
    ]
    #v(1fr)
    #line(length: 100%, stroke: 0.5pt + border-col)
    #v(8pt)
    #text(size: 8pt, fill: muted, tracking: 2pt)[COMPANY BROCHURE · 2026]
  ],
)

#pagebreak()

// =====================================================================
//  INSIDE PAGE :  About + Why  |  Services  |  Signature projects
// =====================================================================
#fold-guides
#grid(
  columns: (1fr, 1fr, 1fr),
  rows: (100%),

  // ---- Panel 4 : ABOUT + WHY ----------------------------------------
  panel(fill: bg-base)[
    #head("Who We Are", "About Petra", size: 19pt)
    #text(size: 9pt, fill: body)[
      *Petra Construction Co. (Pvt.) Ltd.* is a Sri Lankan construction and
      engineering company delivering precision-built residential and commercial
      structures. From complex foundations to fully finished luxury homes, we
      combine sound engineering with careful craftsmanship.
    ]
    #v(7pt)
    #text(size: 9pt, fill: body)[
      Founded by an internationally trained civil engineer, every project is
      managed end to end by qualified engineers and quantity surveyors, so
      clients deal with professionals at every stage.
    ]

    #v(16pt)
    #eyebrow[Why Choose Petra]
    #v(11pt)

    #let why(title, desc) = block(spacing: 9pt)[
      #text(size: 9.5pt, weight: "bold", fill: gold)[#title]
      #linebreak()
      #text(size: 8.5pt, fill: body)[#desc]
    ]
    #why("Engineer-led", "Every project run by qualified engineers and quantity surveyors.")
    #why("Transparent costing", "Detailed BOQs and accurate estimates, no surprises.")
    #why("Quality finishes", "Luxury-standard detailing and craftsmanship throughout.")
    #why("On-time, safe delivery", "Disciplined sites and realistic, dependable programmes.")
  ],

  // ---- Panel 5 : SERVICES -------------------------------------------
  panel(fill: bg-card-2)[
    #head("Capabilities", "Our Services", size: 19pt)

    #let service(title, items) = block(spacing: 11pt)[
      #text(font: display-font, size: 11pt, weight: "bold", fill: ink)[#title]
      #v(4pt)
      #for it in items [
        #grid(columns: (9pt, 1fr), gutter: 2pt,
          text(fill: gold)[•], text(size: 8.5pt, fill: body)[#it])
        #v(2.5pt)
      ]
    ]
    #service("Civil Engineering", (
      "Reinforced concrete (RCC) structures",
      "Foundations, columns, slabs & masonry",
      "Luxury & semi-luxury homes",
    ))
    #service("Mechanical & Electrical", (
      "Electrical installation & distribution",
      "Plumbing, water & sanitary systems",
      "HVAC, ventilation & building services",
    ))
    #service("Project & Cost Management", (
      "Quantity surveying & BOQ preparation",
      "Transparent cost estimation",
      "Site supervision & quality control",
    ))
    #service("Turnkey Delivery", (
      "Design coordination & execution",
      "Interior finishing & fit-out",
      "Handover & after-care",
    ))
  ],

  // ---- Panel 6 : SIGNATURE PROJECTS (lead) --------------------------
  panel(fill: bg-base)[
    #head("Signature Projects", "Recent Work", size: 19pt)

    #let project(path, name, place-loc, stat-label, stat-col) = block(spacing: 9pt)[
      #tile(path, h: 28mm)
      #v(5pt)
      #text(size: 9.5pt, weight: "bold", fill: ink)[#name]
      #linebreak()
      #text(size: 8pt, fill: muted)[#place-loc]
      #v(4pt)
      #status(stat-label, stat-col)
    ]

    #project(
      "../../assets/projects/two-storey-attidiya/03-lake-view.jpeg",
      "Two-Storey Luxury Residence", "Attidiya", "Completed", success)
    #v(9pt)
    #project(
      "../../assets/projects/three-storey-nedimala/02-pool.jpeg",
      "Three-Storey Luxury Residence", "Nedimala", "Completed", success)
    #v(9pt)
    #project(
      "../../assets/projects/kalawana-housing/02-columns.jpeg",
      "Cost-Effective Housing Project", "Kalawana, Ratnapura", "Ongoing", amber)
  ],
)

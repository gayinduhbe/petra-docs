#import "../../lib/theme.typ": *

#show: profile

// Helper: a project photo cropped to a uniform tile
#let tile(path, h: 52mm) = box(
  width: 100%, clip: true, radius: 3pt, stroke: 0.6pt + border-col,
)[#image(path, width: 100%, height: h, fit: "cover")]

// =====================================================================
//  PAGE 1, COVER
// =====================================================================
#place(top + right, dx: 22mm, dy: -24mm,
  rect(width: 130mm, height: 130mm,
    fill: gradient.radial(gold.transparentize(70%), bg-base.transparentize(100%),
      center: (100%, 0%), radius: 90%)))

#v(8mm)
#logo-badge(width: 130pt)

#v(1fr)

#eyebrow[Solid Foundations · Timeless Structures]
#v(14pt)
#text(font: display-font, size: 58pt, weight: "bold", fill: text-white)[Petra]
#v(-10pt)
#text(font: display-font, size: 58pt, weight: "bold", fill: gold)[Construction]
#v(12pt)
#block(width: 78%)[
  #text(size: 12pt, fill: text-body)[
    Precision-engineered residences and structures, built to endure.
    Civil, M&E and turnkey construction delivered with engineering rigour.
  ]
]

#v(1fr)

// Cover stat band
#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 14pt,
  card(stat([4], "Signature Projects", note: [Completed & in progress], size: 30pt)),
  card(stat([Rs 500M+], "Project Value", note: [Across the portfolio], size: 24pt)),
  card(stat([100%], "Client-Led Delivery", note: [Quality · Safety · On-time], size: 30pt)),
)

#v(10pt)
#align(right)[#text(size: 9pt, fill: text-muted, tracking: 2pt)[COMPANY PROFILE · 2026]]

#pagebreak()

// =====================================================================
//  PAGE 2, CONTENTS
// =====================================================================
#section-title("Overview", "Contents")

#let toc-row(num, title, desc) = {
  grid(
    columns: (auto, 1fr),
    gutter: 16pt,
    align: (top, top),
    text(font: display-font, size: 20pt, weight: "bold", fill: gold)[#num],
    [
      #text(size: 12pt, weight: "bold", fill: text-white)[#title] \
      #text(size: 9.5pt, fill: text-muted)[#desc]
    ],
  )
  v(5pt)
  line(length: 100%, stroke: 0.5pt + border-col)
  v(7pt)
}

#toc-row("01", "About Petra", "Who we are and what we set out to do")
#toc-row("02", "Director's Message", "From the founder & chief engineer")
#toc-row("03", "Mission, Vision & Values", "The principles that guide our work")
#toc-row("04", "Our Services", "Civil, M&E and turnkey capabilities")
#toc-row("05", "Our Team", "The people behind the projects")
#toc-row("06", "Project · Two-Storey Residence", "Completed luxury home, Attidiya")
#toc-row("07", "Project · Three-Storey Residence", "Completed luxury home, Nedimala")
#toc-row("08", "Project · Kalutara Luxury Hotel", "Completed beachfront hotel")
#toc-row("09", "Project · Cost-Effective Housing", "Kalawana, in progress")
#toc-row("10", "Why Choose Petra & Contact", "Get in touch")

#pagebreak()

// =====================================================================
//  PAGE 3, ABOUT
// =====================================================================
#section-title("01 · Who We Are", "About Petra")

#text(size: 11pt, fill: text-body)[
  *Petra Construction Co. (Pvt.) Ltd.* is a Sri Lankan construction and engineering
  company delivering precision-built residential and commercial structures. From
  complex foundations to fully finished luxury homes, we combine sound engineering
  with careful craftsmanship to create spaces that are built to last.
]

#v(8pt)

#text(size: 11pt, fill: text-body)[
  Founded by a civil engineer trained internationally, Petra was established on a
  simple intention: to raise the standard of construction quality, transparency and
  reliability for our clients. Every project, whether a private residence or an
  industrial structure, is managed end to end by qualified engineers and quantity
  surveyors, so clients deal with professionals at every stage.
]

#v(20pt)

#grid(
  columns: (1fr, 1fr),
  gutter: 14pt,
  card[
    #eyebrow[What We Do]
    #v(8pt)
    #text(fill: text-body)[
      Design-led civil construction, mechanical & electrical (M&E) works, and
      turnkey delivery of luxury and semi-luxury homes, managed from first survey
      to final handover.
    ]
  ],
  card[
    #eyebrow[Our Approach]
    #v(8pt)
    #text(fill: text-body)[
      Engineer-led, cost-controlled and safety-first. Detailed quantity surveying
      keeps budgets honest, while on-site supervision keeps quality high and
      timelines on track.
    ]
  ],
)

#v(14pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 14pt,
  card(stat([Civil], "Core Discipline", note: [RCC, masonry & structures], size: 26pt)),
  card(stat([M&E], "Building Services", note: [Mechanical & electrical], size: 26pt)),
  card(stat([Turnkey], "Delivery Model", note: [Concept to handover], size: 26pt)),
)

#pagebreak()

// =====================================================================
//  PAGE 4, DIRECTOR'S MESSAGE
// =====================================================================
#section-title("02 · Leadership", "Director's Message")

#grid(
  columns: (1fr, 1.6fr),
  gutter: 20pt,
  align: (top, top),
  [
    #card(fill: bg-card-2)[
      #text(font: display-font, size: 16pt, weight: "bold", fill: text-white)[
        Gayindu Umesh Perera
      ]
      #v(4pt)
      #text(size: 9.5pt, fill: gold, tracking: 1pt)[DIRECTOR / ENGINEER]
      #v(12pt)
      #line(length: 100%, stroke: 0.5pt + border-col)
      #v(12pt)
      #text(size: 9.5pt, fill: text-body)[
        BSc in Civil Engineering \
        RMIT University, Australia
      ]
    ]
  ],
  [
    #text(size: 11pt, fill: text-body)[
      "I started Petra Construction with a clear purpose, to bring international
      engineering standards to the homes and structures we build here in Sri Lanka.

      Too often, clients are left guessing about cost, quality and timelines. We do
      the opposite: every project is led by qualified engineers and quantity
      surveyors, costed transparently, and built with materials and methods we would
      use in our own homes.

      Whether we are pouring a foundation or finishing a luxury residence, our
      commitment is the same, solid foundations and timeless structures that our
      clients are proud to own."
    ]
    #v(14pt)
    #text(font: display-font, size: 13pt, weight: "bold", fill: gold)[Gayindu Umesh Perera]
    #linebreak()
    #text(size: 9pt, fill: text-muted)[Founder · Director · Chartered route, Civil Engineering]
  ],
)

#pagebreak()

// =====================================================================
//  PAGE 5, MISSION, VISION & VALUES
// =====================================================================
#section-title("03 · Our Purpose", "Mission, Vision & Values")

#grid(
  columns: (1fr, 1fr),
  gutter: 14pt,
  card(fill: bg-card-2)[
    #eyebrow("Our Vision", accent: gold)
    #v(10pt)
    #text(size: 11pt, fill: text-white)[
      To be Sri Lanka's most trusted name in engineered construction, the partner
      clients choose when quality, integrity and lasting value matter most.
    ]
  ],
  card(fill: bg-card-2)[
    #eyebrow("Our Mission", accent: gold)
    #v(10pt)
    #text(size: 11pt, fill: text-white)[
      To deliver precision-built structures through engineering excellence,
      transparent costing and uncompromising safety, on time, every time.
    ]
  ],
)

#v(20pt)
#eyebrow("Our Values")
#v(14pt)

#let value(title, desc) = card[
  #text(font: display-font, size: 13pt, weight: "bold", fill: gold)[#title]
  #v(6pt)
  #text(size: 9.5pt, fill: text-body)[#desc]
]

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 12pt,
  value("Integrity", "Honest costing and transparent communication on every project."),
  value("Engineering Rigour", "Qualified engineers and surveyors lead every stage of work."),
  value("Safety First", "Disciplined site practices that protect people and quality."),
  value("Craftsmanship", "Finishes and detailing held to a luxury standard."),
  value("Reliability", "Realistic timelines, and the discipline to meet them."),
  value("Client Partnership", "We build for the people who will live and work in it."),
)

#pagebreak()

// =====================================================================
//  PAGE 6, SERVICES
// =====================================================================
#section-title("04 · Capabilities", "Our Services")

#text(size: 11pt, fill: text-body)[
  Petra delivers complete building projects in-house, from groundwork and structure
  through to mechanical, electrical and finishing works. Clients can engage us for a
  single discipline or for fully turnkey delivery.
]

#v(18pt)

#let service(title, items) = card[
  #text(font: display-font, size: 14pt, weight: "bold", fill: text-white)[#title]
  #v(6pt)
  #accent-rule(w: 32pt, accent: gold)
  #v(10pt)
  #for it in items [
    #grid(columns: (12pt, 1fr), text(fill: gold)[•], text(size: 9.5pt, fill: text-body)[#it])
    #v(5pt)
  ]
]

#grid(
  columns: (1fr, 1fr),
  gutter: 14pt,
  service("Civil Engineering", (
    "Reinforced concrete (RCC) structures",
    "Foundations, columns & slabs",
    "Masonry, plastering & waterproofing",
    "Luxury & semi-luxury home construction",
  )),
  service("Mechanical & Electrical (M&E)", (
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
//  PAGE 7, OUR TEAM
// =====================================================================
#section-title("05 · The People", "Our Team")

#let person(name, role, creds) = card[
  #text(font: display-font, size: 13pt, weight: "bold", fill: text-white)[#name]
  #v(3pt)
  #text(size: 9pt, fill: gold, tracking: 1pt)[#upper(role)]
  #v(10pt)
  #line(length: 100%, stroke: 0.5pt + border-col)
  #v(10pt)
  #text(size: 9.5pt, fill: text-body)[#creds]
]

#grid(
  columns: (1fr, 1fr),
  gutter: 14pt,
  person("Gayindu Umesh Perera", "Director / Engineer",
    [BSc in Civil Engineering, RMIT University, Australia. Leads engineering, design and overall project delivery.]),
  person("Chitra Perera", "Chief Quantity Surveyor",
    [City & Guilds (London) · AMASI (London) · MSST (London). Heads cost planning, BOQs and quantity surveying.]),
  person("Yasoda Srimal Abeykoon", "Construction Manager",
    [HND in Quantity Surveying, University of Liverpool. Manages site execution, programming and on-the-ground construction.]),
  person("Ramya De Silva", "Secretary",
    [Coordinates administration, client communication and project documentation.]),
  person("Nimal Thanthriarachchi", "M&E Engineer",
    [35 years' experience in the hotel industry, specialised in air-conditioning, refrigeration and heating.]),
)

#pagebreak()

// =====================================================================
//  PAGE 9, PROJECT 1 · LAKE HOUSE
// =====================================================================
#section-title("06 · Completed Project", "Two-Storey Luxury Residence", size: 26pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 10pt,
  meta-item("Status", "Completed", dot: success, accent: success),
  meta-item("Type", "Residence", note: [Two-storey luxury home]),
  meta-item("Location", "Attidiya", note: [Sri Lanka]),
)

#v(12pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 10pt,
  tile("../../assets/projects/two-storey-attidiya/01-entrance.jpeg", h: 46mm),
  tile("../../assets/projects/two-storey-attidiya/03-lake-view.jpeg", h: 46mm),
  tile("../../assets/projects/two-storey-attidiya/02-living-dusk.jpeg", h: 46mm),
)
#v(10pt)
#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 10pt,
  tile("../../assets/projects/two-storey-attidiya/04-bedroom.jpeg", h: 46mm),
  tile("../../assets/projects/two-storey-attidiya/06-landing.jpeg", h: 46mm),
  tile("../../assets/projects/two-storey-attidiya/05-bathroom.jpeg", h: 46mm),
)

#v(12pt)
#text(size: 10pt, fill: text-body)[
  A two-storey luxury residence in Attidiya overlooking the lake. The design pairs
  warm timber detailing and open living spaces with an engineered concrete structure,
  delivering a calm, light-filled home framed by its waterside setting.
]

#pagebreak()

// =====================================================================
//  PAGE · THREE-STOREY LUXURY RESIDENCE (NEDIMALA)
// =====================================================================
#section-title("07 · Completed Project", "Three-Storey Luxury Residence", size: 26pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 10pt,
  meta-item("Status", "Completed", dot: success, accent: success),
  meta-item("Type", "Residence", note: [Three-storey luxury home]),
  meta-item("Location", "Nedimala", note: [Sri Lanka]),
)

#v(12pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 10pt,
  tile("../../assets/projects/three-storey-nedimala/01-glass-dining.jpeg", h: 46mm),
  tile("../../assets/projects/three-storey-nedimala/02-pool.jpeg", h: 46mm),
  tile("../../assets/projects/three-storey-nedimala/03-lounge.jpeg", h: 46mm),
)
#v(10pt)
#grid(
  columns: (1fr, 1fr),
  gutter: 10pt,
  tile("../../assets/projects/three-storey-nedimala/04-staircase.jpeg", h: 46mm),
  tile("../../assets/projects/three-storey-nedimala/05-bedroom.jpeg", h: 46mm),
)

#v(12pt)
#text(size: 10pt, fill: text-body)[
  A contemporary three-storey luxury home in Nedimala built around light and water.
  Floor-to-ceiling glazing, a private indoor pool and warm timber staircases are set
  against a crisp engineered structure, creating a calm, resort-like residence over
  three levels.
]

#pagebreak()

// =====================================================================
//  PAGE · KALUTARA LUXURY HOTEL
// =====================================================================
#section-title("08 · Completed Project", "Kalutara Luxury Hotel", size: 26pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 10pt,
  meta-item("Status", "Completed", dot: success, accent: success),
  meta-item("Type", "Hotel", note: [Beachfront hospitality]),
  meta-item("Location", "Kalutara", note: [Oceanfront setting]),
)

#v(12pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 10pt,
  tile("../../assets/projects/kalutara-hotel/01-exterior-night.jpeg", h: 46mm),
  tile("../../assets/projects/kalutara-hotel/02-beach-dining.jpeg", h: 46mm),
  tile("../../assets/projects/kalutara-hotel/03-sea-view-room.jpeg", h: 46mm),
)
#v(10pt)
#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 10pt,
  tile("../../assets/projects/kalutara-hotel/04-balcony-room.jpeg", h: 46mm),
  tile("../../assets/projects/kalutara-hotel/05-restaurant.jpeg", h: 46mm),
  tile("../../assets/projects/kalutara-hotel/06-deluxe-room.jpeg", h: 46mm),
)

#v(12pt)
#text(size: 10pt, fill: text-body)[
  A beachfront luxury hotel built on a robust concrete frame with refined guest-room
  interiors, sea-facing balconies and a bright oceanside dining hall. Every space is
  oriented to the shoreline, turning the building's structure into uninterrupted
  views of the coast.
]

#pagebreak()

// =====================================================================
//  PAGE · COST-EFFECTIVE HOUSING PROJECT (KALAWANA, ONGOING)
// =====================================================================
#section-title("09 · Project In Progress", "Cost-Effective Housing Project", size: 26pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 10pt,
  meta-item("Status", "Ongoing", note: [Under construction], dot: amber, accent: amber),
  meta-item("Type", "Housing", note: [Cost-effective build]),
  meta-item("Location", "Kalawana", note: [Ratnapura District]),
)

#v(12pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 10pt,
  tile("../../assets/projects/kalawana-housing/01-blockwork.jpeg", h: 68mm),
  tile("../../assets/projects/kalawana-housing/02-columns.jpeg", h: 68mm),
  tile("../../assets/projects/kalawana-housing/03-roof-steel.jpeg", h: 68mm),
)

#v(14pt)
#text(size: 10pt, fill: text-body)[
  A cost-effective housing project currently under construction at Kalawana, designed
  to deliver durable, well-built homes at an accessible price point. These images show
  the engineering that underpins every Petra build: reinforced concrete columns,
  precision blockwork and an engineered steel roof structure, executed with the same
  care as our luxury work.
]

#pagebreak()

// =====================================================================
//  PAGE 12, WHY PETRA + CONTACT (back)
// =====================================================================
#place(bottom + right, dx: 22mm, dy: 20mm,
  rect(width: 140mm, height: 140mm,
    fill: gradient.radial(gold.transparentize(72%), bg-base.transparentize(100%),
      center: (100%, 100%), radius: 90%)))

#section-title("10 · Let's Build", "Why Choose Petra")

#grid(
  columns: (1fr, 1fr),
  gutter: 12pt,
  card[#text(fill: gold, weight: "bold")[Engineer-led.] #text(fill: text-body)[ Every project is run by qualified engineers and quantity surveyors.]],
  card[#text(fill: gold, weight: "bold")[Transparent costing.] #text(fill: text-body)[ Detailed BOQs and honest estimates, no surprises.]],
  card[#text(fill: gold, weight: "bold")[Quality finishes.] #text(fill: text-body)[ Luxury-standard detailing and craftsmanship.]],
  card[#text(fill: gold, weight: "bold")[On-time, safe delivery.] #text(fill: text-body)[ Disciplined sites and realistic programmes.]],
)

#v(1fr)

#logo-badge(width: 120pt)
#v(16pt)

#card(fill: bg-card-2)[
  #eyebrow[Get In Touch]
  #v(12pt)
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 14pt,
    row-gutter: 14pt,
    [
      #text(size: 9pt, fill: gold, tracking: 1pt)[PHONE] \
      #v(3pt)
      #text(size: 10pt, fill: text-white)[077 735 6371 \ 077 929 8315]
    ],
    [
      #text(size: 9pt, fill: gold, tracking: 1pt)[EMAIL] \
      #v(3pt)
      #text(size: 10pt, fill: text-white)[inquiry\@petraconstructions.lk]
    ],
    [
      #text(size: 9pt, fill: gold, tracking: 1pt)[WEBSITE] \
      #v(3pt)
      #text(size: 10pt, fill: text-white)[petraconstructions.lk]
    ],
    [
      #text(size: 9pt, fill: gold, tracking: 1pt)[ADDRESS] \
      #v(3pt)
      #text(size: 10pt, fill: text-white)[71A Lake Road, \ Attidiya, Dehiwala]
    ],
  )
]

#v(12pt)
#align(center)[#text(size: 9pt, fill: text-muted, tracking: 2pt)[
  PETRA CONSTRUCTION CO. (PVT.) LTD. · SOLID FOUNDATIONS · TIMELESS STRUCTURES
]]

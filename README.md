# Petra Construction, Company Profile

Source for the official company-profile documents of **Petra Construction Co. (Pvt.) Ltd.**, a Sri Lankan construction and engineering company.

The documents are written in [**Typst**](https://typst.app/) and share a single design system, so every version stays visually consistent. There are currently two layouts:

| Document | Orientation | Pages | Output |
| --- | --- | --- | --- |
| **Company Profile** | Portrait (A4) | 12 | [`build/petra-company-profile.pdf`](build/petra-company-profile.pdf) |
| **Company Profile** | Landscape (A4) | 11 | [`build/petra-company-profile-landscape.pdf`](build/petra-company-profile-landscape.pdf) |

> **Tagline:** Solid Foundations, Timeless Structures

---

## Quick start

### Prerequisites

- [**Typst**](https://github.com/typst/typst) `0.13+` (developed on `0.14.2`)
- The **Nimbus Sans** font (ships with `gsfonts` / `urw-base35` on most Linux distros)
- *Optional*, only to regenerate the logo or palette: **Python 3** with the deps in [`tools/requirements.txt`](tools/requirements.txt)

### Build the PDFs

```bash
make            # builds both portrait and landscape
make portrait   # just the portrait version
make landscape  # just the landscape version
```

Or call Typst directly. Note the `--root .` flag: it is **required** because the documents in `docs/` read shared files (theme, assets) from the repo root.

```bash
typst compile --root . docs/portrait/profile.typ   build/petra-company-profile.pdf
typst compile --root . docs/landscape/profile.typ  build/petra-company-profile-landscape.pdf
```

Live preview while editing:

```bash
make watch-portrait      # or: make watch-landscape
```

---

## Repository layout

```text
.
├── README.md
├── CLAUDE.md                  # guide for AI agents / future contributors
├── Makefile                   # build, watch, logo, clean
├── lib/
│   └── theme.typ              # shared palette, components, page shell
├── docs/                      # one folder per document version
│   ├── portrait/
│   │   └── profile.typ
│   └── landscape/
│       └── profile.typ
├── assets/
│   ├── logo/
│   │   ├── logo-source.jpeg   # original artwork (input to tools/make_logo.py)
│   │   ├── logo-dark.png      # transparent lockup for dark pages
│   │   └── logo-light.png     # transparent lockup for light pages
│   └── projects/              # one folder per project, curated photos
│       ├── two-storey-attidiya/
│       ├── three-storey-nedimala/
│       ├── kalutara-hotel/
│       └── kalawana-housing/
├── tools/
│   ├── make_logo.py           # rebuilds the transparent logo PNGs
│   ├── palette.py             # prints the OKLCH-derived colour palette
│   └── requirements.txt
└── build/                     # compiled PDFs (committed for easy download)
```

---

## Design system

Everything visual is defined once in [`lib/theme.typ`](lib/theme.typ) and imported by each document.

### Colour palette

A restrained, luxury palette: warm near-black plus cream neutrals, **gold as the single metallic accent**, and one deep muted navy used only as an occasional panel surface. The accent colours were generated in the perceptually uniform **OKLCH** space (see [`tools/palette.py`](tools/palette.py)) so they harmonise rather than clash.

| Role | Hex | Use |
| --- | --- | --- |
| Base | `#0C0B08` | Page background (warm onyx) |
| Card | `#191713` / `#23201B` | Panels |
| Cream | `#F4F1EC` | Headings |
| Body | `#C1BDB7` | Body text |
| Muted | `#89867E` | Captions, labels |
| **Gold** | `#C9A24B` | Primary accent |
| Navy | `#232D45` | Complementary panel surface |
| Sage | `#84A98B` | "Completed" status |
| Honey | `#C39D71` | "Ongoing" status |

### Typography

- **Nimbus Sans** for both display and body (a clean, static Helvetica-like grotesque).
- Variable fonts are intentionally avoided: Typst renders their bold weights poorly.

---

## Editing guide

### Change content

Each document is a single `.typ` file under `docs/`. Sections are clearly commented (for example `PAGE 1, COVER`). Edit the text inline and rebuild.

### Add or change a project

1. Drop curated photos into a new folder under `assets/projects/<project-slug>/`, named with an ordering prefix and a short description, for example `01-exterior.jpeg`.
2. Add a project block in each document you want it to appear in (copy an existing block).
3. Update the table of contents and section numbering in the portrait document.

### Update the logo

Replace `assets/logo/logo-source.jpeg`, then:

```bash
pip install -r tools/requirements.txt   # first time only
make logo                               # regenerates logo-dark.png and logo-light.png
```

---

## Writing conventions

These keep the documents clean and on-brand. Please follow them:

- **No em dashes.** Use commas, colons, or full stops.
- **No hyphenated line breaks.** Hyphenation is disabled globally; let lines wrap at spaces.
- **Gold is the only accent.** Resist adding more saturated colours; keep structure neutral.
- Keep wording client-focused and concrete.

---

## Company reference

| Field | Value |
| --- | --- |
| Legal name | Petra Construction Co. (Pvt.) Ltd. |
| Address | 71A Lake Road, Attidiya, Dehiwala |
| Phone | 077 735 6371, 077 929 8315 |
| Email | inquiry@petraconstructions.lk |
| Website | petraconstructions.lk |

**Leadership and team**

- **Gayindu Umesh Perera**, Director / Engineer. BSc in Civil Engineering, RMIT University, Australia.
- **Chitra Perera**, Chief Quantity Surveyor. City & Guilds, AMASI, MSST (London).
- **Yasoda Srimal Abeykoon**, Construction Manager. HND in Quantity Surveying, University of Liverpool.
- **Nimal Thanthriarachchi**, M&E Engineer. 35 years in the hotel industry, air-conditioning, refrigeration and heating.
- **Ramya De Silva**, Secretary.

**Projects**

| Project | Location | Status |
| --- | --- | --- |
| Two-Storey Luxury Residence | Attidiya | Completed |
| Three-Storey Luxury Residence | Nedimala | Completed |
| Kalutara Luxury Hotel | Kalutara | Completed |
| Cost-Effective Housing Project | Kalawana | In progress |

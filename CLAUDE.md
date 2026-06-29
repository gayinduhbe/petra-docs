# CLAUDE.md

Guidance for Claude and other AI agents working in this repository. Read this before making changes.

## Who you are working with

The person using this repo is **non-technical**. They do not write code and are not expected to understand Typst, the build system, or the terminal. When you explain what you did or what you need from them:

- Keep it short and plain. Lead with the outcome (for example, "Done, the phone number is updated on both PDFs"), not the mechanics.
- Avoid jargon. If you must mention a technical thing, explain it in one simple line.
- Do the technical work yourself (editing files, building, checking pages). Do not ask them to run commands or edit code unless there is truly no other way, and if you do, give exact step-by-step instructions.
- When you need a decision, ask about the *content or look* (wording, photos, colours), not the implementation.

## What this is

Typst source for the company-profile documents of **Petra Construction Co. (Pvt.) Ltd.** (Sri Lanka). One shared design system in `lib/theme.typ` feeds multiple document layouts in `docs/`. Compiled PDFs live in `build/`.

There are three documents today: a **portrait** profile (12 pages, dark), a **landscape** profile (11 pages, light/print-friendly), and a **tri-fold brochure** (`docs/trifold/brochure.typ`, one A4 landscape sheet / 2 PDF pages, light interior with a dark gold cover). They share fonts, logo, and project assets. The brochure uses its own light palette and panel components inline rather than the shared dark `card()`/`stat()`, the same pattern the landscape edition uses.

## Build and verify

Always build with `--root .` from the repo root. The documents live in `docs/<layout>/` but read `lib/theme.typ` and `assets/` from the root, which Typst only allows when the root is set.

```bash
make all          # all three documents
make portrait     # docs/portrait/profile.typ  -> build/petra-company-profile.pdf
make landscape    # docs/landscape/profile.typ -> build/petra-company-profile-landscape.pdf
make brochure     # docs/trifold/brochure.typ  -> build/petra-brochure.pdf
```

Direct invocation if `make` is unavailable:

```bash
typst compile --root . docs/portrait/profile.typ  build/petra-company-profile.pdf
typst compile --root . docs/landscape/profile.typ build/petra-company-profile-landscape.pdf
```

**Always recompile after editing**, and visually verify. To inspect pages, render to PNG (these go to ignored scratch dirs):

```bash
pdftoppm -png -r 80 build/petra-company-profile.pdf .preview/p
```

After a change, sanity-check the page count with `pdfinfo`. A surprise extra page usually means content overflowed (see Gotchas).

## Non-negotiable conventions

1. **No em dashes anywhere in document text.** Use commas, colons, or full stops. The user is firm on this. To enforce, grep for the long-dash character across `docs/` and `lib/` before finishing and confirm zero matches.
2. **No hyphenated line breaks.** Hyphenation is disabled (`hyphenate: false`) and paragraphs are ragged (`justify: false`). Do not re-enable them. If a word is too wide for its box, shrink the font or widen the box rather than letting it break.
3. **Gold is the only accent colour.** The palette is deliberately restrained (warm neutrals + gold, with one muted navy as a panel surface). Do NOT reintroduce multiple saturated accent colours per card; that "rainbow on dark" look was explicitly rejected as looking AI-generated.
4. **Keep both documents in sync** when changing shared facts (names, contact details, project list).

## Architecture

### `lib/theme.typ` exports

- **Palette**: `bg-base`, `bg-card`, `bg-card-2`, `bg-navy`, `border-col`, `text-white`, `text-body`, `text-muted`, `gold`, `gold-light`, `gold-deep`, `navy`, `navy-soft`, `success`, `amber`. Plus back-compat aliases `steel`/`clay` that now point at the restrained palette.
- **Fonts**: `body-font` and `display-font`, both `"Nimbus Sans"`.
- **Components**: `eyebrow()`, `accent-rule()`, `section-title(kicker, title, accent: gold, size: 31pt)`, `card(body, fill:, accent:)`, `stat()`, `meta-item()`, `caption()`, `org-node()`, `org-chart()`, `drop()`, `logo-badge()`.
- **Portrait shell**: `profile(body)` sets the portrait page (used via `#show: profile` in the portrait doc). The landscape doc defines its own page shell inline instead.

### How documents consume it

Each doc starts with `#import "../../lib/theme.typ": *`. The portrait doc applies `#show: profile`. The landscape doc sets up its own `#set page(...)` with the vertical "COMPANY PROFILE" side band and the logo at top and bottom of that band.

### Image paths (important)

In Typst, `image()` paths are relative to the **file that contains the call**, and must stay within `--root`.

- Calls inside `lib/theme.typ` (for example `logo-badge`) use `../assets/...`.
- Calls inside `docs/<layout>/profile.typ` use `../../assets/...`.

If you move a file, fix its image paths accordingly.

## Common tasks

### Add a project

1. Curate photos into `assets/projects/<slug>/` with ordered, descriptive names (`01-exterior.jpeg`, ...).
2. Copy an existing project block in the doc(s). Portrait uses explicit per-page blocks; landscape uses the `project(...)` helper near the bottom of `docs/landscape/profile.typ`.
3. In the portrait doc, also update the **table of contents** rows and renumber the section kickers (`06 ·`, `07 ·`, ...) and the "Why Choose" kicker.
4. Update the cover "Signature Projects" count if it changed.
5. Rebuild both and check page counts.

### Change colours

Edit the palette block at the top of `lib/theme.typ`. To derive new harmonised values, run `python3 tools/palette.py` (prints OKLCH-based hexes anchored on the brand gold). Keep the restraint rule above in mind.

### Regenerate the logo

`assets/logo/logo-source.jpeg` is the input. `tools/make_logo.py` strips the background, recolours the artwork, replaces the old "HOLDINGS" wordmark with "PETRA / CONSTRUCTION", and writes `logo-dark.png` (cream, for dark pages) and `logo-light.png` (ink, for light pages).

```bash
pip install -r tools/requirements.txt
make logo
```

## Gotchas

- **`--root .` is mandatory.** Without it you get `failed to load file (access denied)` on the import.
- **Variable fonts render badly** in Typst (weak bold). Stick to static fonts like Nimbus Sans. The build emits harmless "variable fonts are not currently supported" warnings for some system fonts; ignore them.
- **Overflow creates phantom pages.** A trailing in-flow element that does not fit pushes a near-blank page. Prefer `place(...)` for corner stamps (date, decorative gradients) so they do not consume flow. This already bit the landscape cover once.
- **`align` propagates into grid cells.** Setting a grid cell to `right + horizon` will right-align and vertically collapse the content inside a card placed there. Use `left + top` for text-bearing cells.
- **`&` is special in `sed` replacements.** Escape it (`\&`) or prefer the editor when touching strings like "M&E".
- **Python tooling needs a venv** on this machine (PEP 668 blocks system pip). Activate one before running the tools.

## Source data and known state

Use these facts; do not invent company details.

- **Contact**: 71A Lake Road, Attidiya, Dehiwala. Phones 077 735 6371 and 077 929 8315. Email petraconstructionlk@gmail.com. Website www.petraconstructions.lk.
- **Team**: Gayindu Umesh Perera (Director/Engineer, BSc Civil Eng, RMIT Australia); Chitra Perera (Chief QS: City & Guilds, AMASI, MSST London); Yasoda Srimal Abeykoon (Construction Manager, HND Quantity Surveying, University of Liverpool); Nimal Thanthriarachchi (M&E Engineer, 35 years hotel industry, AC/refrigeration/heating); Ramya De Silva (Secretary).
- **Projects**: Two-Storey Luxury Residence (Attidiya, completed), Three-Storey Luxury Residence (Nedimala, completed), Kalutara Luxury Hotel (Kalutara, completed, beachfront), Cost-Effective Housing Project (Kalawana, ongoing).

### Open items / placeholders (confirm with the user before treating as final)

- **Cover stats** ("Rs 500M+", "100%") are illustrative marketing figures.
- **Kalawana project photos** are placeholder construction-progress shots reused from an earlier site; swap when real Kalawana photos arrive.
- The spelling **AMASI** and the domain **petraconstructions.lk** (plural, shown with the **www.** prefix) are intentional per the user. The contact email is **petraconstructionlk@gmail.com** (note: singular "construction", a Gmail address, not on the domain).

## Commits

- Use short, semantic commit messages: `feat:`, `fix:`, `chore:`, `docs:`, `style:`.
- Keep them to a single concise line. No long bodies unless genuinely needed.
- Do not add authorship or co-author trailers (no "Co-Authored-By", no "Generated with" lines).

### Push after every change

The user is non-technical and wants the GitHub copy to always be current. So after making a change:

1. Rebuild the affected document(s) and confirm they **build cleanly and the page counts are right** (no overflow / phantom pages).
2. Only if the build is clean, commit and push straight to `main` (`git push origin main`). Include the rebuilt PDF(s) in `build/` in the commit so the downloadable copies stay in sync.
3. If the build fails or a page overflows, do NOT push. Fix it first, or tell the user what is wrong.
4. In your reply, mention in one short line that the changes were pushed (for example, "Pushed to GitHub").

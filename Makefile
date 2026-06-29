# Petra Construction company-profile documents
# Typst sources live in docs/, shared theme in lib/, output in build/.

TYPST   ?= typst
ROOT    := .
BUILD   := build

PORTRAIT_SRC  := docs/portrait/profile.typ
LANDSCAPE_SRC := docs/landscape/profile.typ
BROCHURE_SRC  := docs/trifold/brochure.typ
PORTRAIT_PDF  := $(BUILD)/petra-company-profile.pdf
LANDSCAPE_PDF := $(BUILD)/petra-company-profile-landscape.pdf
BROCHURE_PDF  := $(BUILD)/petra-brochure.pdf

.PHONY: all portrait landscape brochure logo watch-portrait watch-landscape watch-brochure clean

all: portrait landscape brochure

portrait: $(BUILD)
	$(TYPST) compile --root $(ROOT) $(PORTRAIT_SRC) $(PORTRAIT_PDF)

landscape: $(BUILD)
	$(TYPST) compile --root $(ROOT) $(LANDSCAPE_SRC) $(LANDSCAPE_PDF)

brochure: $(BUILD)
	$(TYPST) compile --root $(ROOT) $(BROCHURE_SRC) $(BROCHURE_PDF)

# Regenerate the transparent logo PNGs from the source artwork.
# Needs the Python deps: pip install -r tools/requirements.txt
logo:
	python3 tools/make_logo.py

# Live-recompile while editing.
watch-portrait:
	$(TYPST) watch --root $(ROOT) $(PORTRAIT_SRC) $(PORTRAIT_PDF)

watch-landscape:
	$(TYPST) watch --root $(ROOT) $(LANDSCAPE_SRC) $(LANDSCAPE_PDF)

watch-brochure:
	$(TYPST) watch --root $(ROOT) $(BROCHURE_SRC) $(BROCHURE_PDF)

$(BUILD):
	mkdir -p $(BUILD)

clean:
	rm -f $(PORTRAIT_PDF) $(LANDSCAPE_PDF) $(BROCHURE_PDF)

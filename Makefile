# Root LaTeX build automation

TEX_MAIN := document.tex
PDF_MAIN := $(TEX_MAIN:.tex=.pdf)
LATEXMK := latexmk
LATEXMK_FLAGS := -pdf -synctex=1 -interaction=nonstopmode -file-line-error

.PHONY: help pdf watch force rebuild clean cleanall

help:
	@echo "LaTeX build targets:"
	@echo "  make pdf      - Build PDF with latexmk"
	@echo "  make watch    - Auto-rebuild on file changes"
	@echo "  make force    - Force build even with LaTeX errors"
	@echo "  make rebuild  - Clean then full rebuild"
	@echo "  make clean    - Remove intermediate files"
	@echo "  make cleanall - Remove intermediate files and generated PDF"

pdf: $(PDF_MAIN)

$(PDF_MAIN): $(TEX_MAIN)
	$(LATEXMK) $(LATEXMK_FLAGS) "$<"

watch:
	$(LATEXMK) -pvc $(LATEXMK_FLAGS) "$(TEX_MAIN)"

force:
	$(LATEXMK) -f -g $(LATEXMK_FLAGS) "$(TEX_MAIN)"

rebuild: clean
	$(LATEXMK) -g $(LATEXMK_FLAGS) "$(TEX_MAIN)"

clean:
	$(LATEXMK) -c "$(TEX_MAIN)"

cleanall:
	$(LATEXMK) -C "$(TEX_MAIN)"

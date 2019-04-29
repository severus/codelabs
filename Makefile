TOOLS_DIR = tools
SRCS = $(filter-out $(wildcard $(TOOLS_DIR)/*),$(wildcard */*.md))
CLAAT_DIR = $(TOOLS_DIR)/claat
CLAAT = $(CLAAT_DIR)/bin/claat
ELEMENTS = $(TOOLS_DIR)/bazel-genfiles/bundle.zip
PREFIX = /assets
OUTDIR = public
ELEMENTS_OUTDIR = $(OUTDIR)$(PREFIX)/codelab-elements
GA_TRACKING_CODE = $(GA_TRACKING_CODE)

all: $(CLAAT) $(ELEMENTS)
	echo $(SRCS)
	$(CLAAT) export -prefix $(PREFIX) -o $(OUTDIR) -ga $(GA_TRACKING_CODE) $(SRCS)
	mkdir -p $(ELEMENTS_OUTDIR)
	unzip -o $(ELEMENTS) -d $(ELEMENTS_OUTDIR)

$(CLAAT):
	+$(MAKE) -C $(CLAAT_DIR)

$(ELEMENTS):
	cd $(TOOLS_DIR); bazel build --color=no --curses=no ...

clean:
	$(RM) $(CLAAT)
	$(RM) $(ELEMENTS)
	$(RM) -r $(OUTDIR)

.PHONY: all clean
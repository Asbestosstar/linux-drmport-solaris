SHELL=/bin/sh

.PHONY: help tree audit clean

help:
	@echo "Solaris NVIDIA port skeleton"
	@echo "  make tree   - show Solaris port layout"
	@echo "  make audit  - inventory Linux APIs still needing Solaris wrappers"
	@echo "  make clean  - remove local build products"

tree:
	@find solaris -maxdepth 3 -print | sort

audit:
	@./scripts/list-port-symbols.sh upstream/gpu

clean:
	rm -rf build/*

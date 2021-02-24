SHELL=bash
HOSTNAME = $(shell hostname)

install-octavius-preview:
	stow -nSv octavius -t ~

install-nonus-preview:
	stow -nSv nonus -t ~

install-octavius:
	stow -Sv octavius -t ~

install-nonus:
	stow -Sv nonus -t ~

install: install-$(HOSTNAME)-preview
	@echo ""
	@read -p "Are you sure? " -n 1 -r; \
		if [[ $$REPLY =~ ^[Yy] ]]; \
		then \
			make install-$(HOSTNAME); \
		else\
			echo -e "\nCancelling"; \
		fi

INSTALL=/usr/local/bin/install

install: \
	$(HOME)/.zlogin \
	$(HOME)/.zlogout \
	$(HOME)/.znewterm \
	$(HOME)/.zprofile \
	$(HOME)/.zshenv \
	$(HOME)/.zshrc

$(HOME)/%: %
	$(INSTALL) $^ $@
include GNUmakerules

ALLSRC = \
	.zlogin \
	.zlogout \
	.znewterm \
	.zprofile \
	.zshenv \
	.zshrc \

ALLDST = $(subst ., $(HOME)/., $(ALLSRC)) 

install: $(ALLDST)

echo:
	echo $(ALLSRC)
	echo $(ALLDST)

$(HOME)/%: %
	$(INSTALL) $^ $@

diff:
	for i in $(ALLSRC); do diff -u $(HOME)/$$i $$i; done

# This Makefile has been generated by the packaging/configure script. DO NOT
# modify it manually. If you want to modify the Makefile model, modify the
# packaging/Makefile.in file
NAME=beberlei-github2jira
VERSION=1.0.11
MAINTAINER=Benjamin Eberlei <kontakt@beberlei.de>
PACKAGENAME=beberlei-github2jira
PACKAGETYPE=deb
URL=http://www.beberlei.de
ARCH=all
DEPENDS=-d apache2 -d libapache2-mod-php5
MAINTAINER=Benjamin Eberlei <kontakt@beberlei.de>
DESCRIPTION=Turns Github PRs into Jira Tickets
POSTINST=
PREINST=
POSTRM=
PRERM=
TEMPLATEDIR=templates
TMP=/tmp
ENV=
PTMP=$(TMP)/$(PACKAGENAME)

all: package

clean:
	rm -rf $(PTMP)
	rm -rf vendor/zend/zf2/documentation
	rm -rf vendor/zend/zf2/tests

structure: clean
	mkdir -p $(PTMP)/src $(PTMP)/build $(PTMP)/misc
	rsync -r --exclude packaging --exclude Makefile \
		--exclude packaging_config.php --exclude '.git*' --exclude '.svn' \
		--exclude '.CVS' --exclude "$(TMP)" . $(PTMP)/src

template: structure
	./packaging/template $(PTMP)/src/$(TEMPLATEDIR) $(ENV)

build: template
	mkdir -p $(PTMP)/build/var/www/beberlei-github2jira
	rsync -a --exclude /templates  $(PTMP)/src/* $(PTMP)/build/var/www/beberlei-github2jira

package: build
	fpm -s dir -t $(PACKAGETYPE) -n "$(PACKAGENAME)" -v "$(VERSION)" -m "$(MAINTAINER)" --url "$(URL)" \
		--description "$(DESCRIPTION)" $(DEPENDS) $(POSTINST) $(PREINST) $(POSTRM) $(PRERM) \
		-a $(ARCH) -C $(PTMP)/build -p $(PTMP)/$(PACKAGENAME)_$(VERSION).$(PACKAGETYPE)


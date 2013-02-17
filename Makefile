all:
	@echo "Use 'make install' with root privilege to install simpletunet."

install:
	cp -f simpletunet /usr/local/sbin
	cp -f examples/simpletunet-init.debian /etc/init.d/simpletunet
	@echo "Set USERNAME and PASSWORD_MD5 in /etc/default/simpletunet."

.PHONY: all install

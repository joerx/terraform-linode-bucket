PACKAGE_NAME ?= $(shell basename $(CURDIR))
VERSION ?= $(shell git describe --tags --always --dirty)

package:
	mkdir -p out
	tar czf out/$(PACKAGE_NAME)-$(VERSION).tar.gz --exclude=.git --exclude=out --exclude=Makefile .

clean:
	rm -rf out

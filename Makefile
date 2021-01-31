

SOURCE_FILES := \
	xen-*.tar.gz \
	xen-*.tar.gz.sig \
	xen-*.pkg.tar.zst \
	zstd-dom0.patch

all: 
	bash 02_containerized_build.sh enter_container

containerize:
	bash 00_containerize.sh

clean:
	$(RM) -r pkg src

cleaner: clean
	$(RM) $(SOURCE_FILES)

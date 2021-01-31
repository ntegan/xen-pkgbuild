
all: 
	bash 02_containerized_build.sh enter_container

containerize:
	bash 00_containerize.sh

clean:
	$(RM) -r pkg src

cleaner: clean
	$(RM) xen-*.pkg.tar.zst xen-*.tar.gz xen-*.tar.gz.zig

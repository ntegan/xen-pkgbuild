

## Xen PKGBUILD
TODO: need to see what runtime `depends` need to add to PKGBUILD.  
The package builds for me successfully, still need to test
that everything works in an actual installation.

## Build
### To build in a container:
Make sure you have docker installed, and run `make`.

### To build in a container, more manually:
Enter container:  
`bash 00_containerize.sh`

#### Inside Container
Go to source directory:  
`cd /source`

Setup builduser and add xen signing key, etc:  
`bash 01_docker_environment.sh`

Make the package:  
`makepkg -s`



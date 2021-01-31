#!/bin/bash

set -euo pipefail

my_dir="$(cd $(dirname $0) && pwd)"

function enter_container_and_build {
    docker run --rm -v ${my_dir}:/source archlinux:base-devel "/source/02_containerized_build.sh" build
}
function build {
    bash ${my_dir}/01_docker_environment.sh
    su ntegan --shell /bin/bash -c 'cd /source; yes | makepkg -s'
}

if [[ ! "$#" =  "1"               ]]; then echo "need an argument";   exit 1; fi
if [[   "$1" =  "enter_container" ]]; then enter_container_and_build; exit 0; fi
if [[   "$1" =  "build"           ]]; then build;                     exit 0; fi

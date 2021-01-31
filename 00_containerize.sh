
my_dir="$(cd $(dirname $0) && pwd)"

docker run -it --rm -v ${my_dir}:/source archlinux:base-devel

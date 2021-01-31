
my_dir="$(cd $(dirname $0) && pwd)"

useradd -m ntegan
yes password | passwd ntegan

pacman -Sy
cat >> /etc/sudoers <<EOF 
ntegan ALL=(ALL) NOPASSWD: ALL
EOF
su ntegan
# TODO: su -c? run build script as ntegan?
# TODO: setup multilib probably

xen_key=23E3222C145F4475FA8060A783FE14C957E82BD9.asc
gpg --recv-keys 83FE14C957E82BD9


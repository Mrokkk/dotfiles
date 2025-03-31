#!/bin/sh

base_dir="$(dirname $0)"

user="${1}"

function die()
{
    echo "${@}"
    exit -1
}

if [[ -z "${user}" ]]
then
    echo "Username is needed"
    exit 1
fi

if [[ "$EUID" -ne 0 ]]
then
    echo "Script must be run as root!"
    exit 1
fi

pacman -S \
    --needed \
    7zip \
    alacritty \
    alsa-firmware \
    alsa-lib \
    alsa-tools \
    alsa-utils \
    arandr \
    bat \
    chromium \
    cifs-utils \
    clang \
    cloc \
    dmd \
    dmidecode \
    dub \
    dunst \
    firefox \
    fwupd \
    fzf \
    gcc \
    gdb \
    git \
    git-delta \
    gnome-themes-extra \
    grub \
    gsimplecal \
    gtk-engine-murrine \
    gtk-engines \
    gzip \
    hsetroot \
    htop \
    i3-wm \
    i3blocks \
    intel-gpu-tools \
    jre8-openjdk \
    libva \
    libva-intel-driver \
    llvm \
    lm_sensors \
    lxappearance \
    ly \
    man-pages \
    mate-themes \
    mesa \
    mesa-utils \
    network-manager-applet \
    networkmanager \
    nfs-utils \
    ninja \
    nmap \
    pavucontrol \
    pcmanfm \
    picom \
    pulseaudio \
    pulseaudio-alsa \
    python \
    redshift \
    refind \
    renderdoc \
    rofi \
    rsync \
    strace \
    stress \
    sudo \
    tmux \
    ttf-hack \
    vi \
    vim \
    vlc \
    vulkan-extra-layers \
    vulkan-extra-tools \
    vulkan-headers \
    vulkan-intel \
    wget \
    xclip \
    xfce4-clipman-plugin \
    xfce4-screenshooter \
    xorg \
    xorg-xinit \
    xterm \ 
    zsh || die "packages installation failed"

systemctl enable ly
systemctl enable NetworkManager

cp "${base_dir}/xorg.conf" /etc/X11/xorg.conf
cp "${base_dir}/rofi-logout" /sbin

useradd -m "${user}"
echo "Setting ${user} password"
passwd "${user}"
groupadd wheel
gpasswd -a "${user}" wheel
gpasswd -a "${user}" video
gpasswd -a "${user}" tty
usermod -s /bin/zsh "${user}"

su "${user}" -c "sh user_install.sh"

echo "Installation finished. Perform following configuration manually:"
echo "visudo # and uncomment wheel line"

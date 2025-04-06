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
    bubblewrap \
    cantarell-fonts \
    chromium \
    cifs-utils \
    clang \
    cloc \
    debugedit \
    dmd \
    dmidecode \
    dub \
    dunst \
    fakeroot \
    firefox \
    fwupd \
    fzf \
    gcc \
    gdb \
    git \
    git-delta \
    gnome-themes-extra \
    gnu-free-fonts \
    grub \
    gsimplecal \
    gtk-engine-murrine \
    gtk-engines \
    gzip \
    hsetroot \
    htop \
    i3-wm \
    i3blocks \
    i3lock \
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
    pciutils \
    pcmanfm \
    picom \
    pulseaudio \
    pulseaudio-alsa \
    python \
    python-lsp-server \
    redshift \
    refind \
    renderdoc \
    rofi \
    rsync \
    rust \
    strace \
    stress \
    sudo \
    tmux \
    ttf-hack \
    ttf-liberation \
    unzip \
    usbutils \
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
    xorg-fonts-100dpi \
    xorg-fonts-75dpi \
    xorg-xinit \
    xterm \
    zsh \
    zsh-completions || die "packages installation failed"

systemctl enable ly
systemctl enable NetworkManager

cp "${base_dir}/xorg.conf" /etc/X11/xorg.conf
cp "${base_dir}/rofi-logout" /sbin

groupadd wheel
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/00-wheel

useradd -m "${user}"
echo "Setting ${user} password"
passwd "${user}"
gpasswd -a "${user}" wheel
gpasswd -a "${user}" video
gpasswd -a "${user}" tty
usermod -s /bin/zsh "${user}"

su "${user}" -c "sh user_install.sh"

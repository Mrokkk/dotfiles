#!/bin/sh

set -e

base_dir="$(dirname $0)"

user="${1}"

function die()
{
    echo "${@}"
    exit -1
}

if [[ -z "${user}" ]]
then
    die "Username is needed"
fi

if [[ "$EUID" -ne 0 ]]
then
    die "Script must be run as root!"
fi

mkdir -p /etc/pacman.d/hooks
cp "${base_dir}/firejail-permissions.hook" /etc/pacman.d/hooks/

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
    dos2unix \
    dub \
    dunst \
    fakeroot \
    firefox \
    firejail \
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
    loupe \
    lxappearance \
    ly \
    man-pages \
    mate-themes \
    mesa \
    mesa-utils \
    mplayer \
    network-manager-applet \
    networkmanager \
    nfs-utils \
    ninja \
    nmap \
    pavucontrol \
    pciutils \
    pcmanfm \
    picom \
    pigar \
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
    tree \
    ttf-hack \
    ttf-liberation \
    udisks2 \
    unzip \
    usbutils \
    vi \
    vim \
    vlc \
    vlc-plugins-all \
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
    zip \
    zsh \
    zsh-completions || die "packages installation failed"

systemctl enable ly
systemctl enable NetworkManager

sed -i 's/^path =.*/path = null/g' /etc/ly/config.ini

ln -s /usr/bin/firejail /usr/local/bin/firefox
ln -s /usr/bin/firejail /usr/local/bin/chromium
ln -s /usr/bin/firejail /usr/local/bin/vlc

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
gpasswd -a "${user}" firejail
usermod -s /bin/zsh "${user}"

su "${user}" -c "sh user_install.sh"

echo "You can now reboot. On next startup run following command to finish installation"
echo "\$ ${base_dir}/user_install_finish.sh"

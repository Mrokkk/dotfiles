#!/bin/bash

set -e

base_dir="$(dirname "$0")"

. "${base_dir}/utils.sh"

user="${1}"

if [ -z "${user}" ]
then
    die "Username is needed"
fi

if [ "${EUID}" -ne 0 ]
then
    die "Script must be run as root!"
fi

mkdir -p /etc/pacman.d/hooks
step "install_firejail_hook" cp "${base_dir}/etc/pacman.d/firejail-permissions.hook" "/etc/pacman.d/hooks/"

step "install_packages" pacman -S \
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
    pkgconfig \
    pulseaudio \
    pulseaudio-alsa \
    python \
    python-lsp-server \
    redshift \
    refind \
    renderdoc \
    rofi \
    rsync \
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
    zsh-completions

install_to "${base_dir}/etc/X11/xorg.conf"  "/etc/X11"
install_to "${base_dir}/bin/rofi-logout"    "/bin"

step "enable_ly"                    systemctl enable ly
step "enable_network_manager"       systemctl enable NetworkManager
step "fix_ly_config"                sed -i 's/^path =.*/path = null/g' /etc/ly/config.ini
step "enable_firejail_for_firefox"  ln -s "/usr/bin/firejail" "/usr/local/bin/firefox"
step "enable_firejail_for_chromium" ln -s "/usr/bin/firejail" "/usr/local/bin/chromium"
step "enable_firejail_for_vlc"      ln -s "/usr/bin/firejail" "/usr/local/bin/vlc"

step "groupadd_wheel"       groupadd wheel
step "add_sudoers_wheel"    echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/00-wheel
step "user_create"          useradd -m "${user}"
step "user_setpasswd"       passwd "${user}"
step "user_group_wheel"     gpasswd -a "${user}" wheel
step "user_group_video"     gpasswd -a "${user}" video
step "user_group_tty"       gpasswd -a "${user}" tty
step "user_group_firejail"  gpasswd -a "${user}" firejail
step "user_set_zsh"         usermod -s /bin/zsh "${user}"

copy_cache_file_to_tmp
cd "/home/${user}"
su "${user}" -c "sh user_install.sh"

echo "You can now reboot. On next startup run following command to finish installation"
echo "\$ /home/${user}/user_install_finish.sh"

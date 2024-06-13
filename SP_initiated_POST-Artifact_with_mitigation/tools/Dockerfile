FROM archlinux:latest
RUN echo "[community]" >> /etc/pacman.conf
RUN echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
RUN echo "Server=https://archive.archlinux.org/repos/2023/05/18/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist
RUN pacman -Sy --noconfirm
RUN pacman -S --noconfirm archlinux-keyring
RUN pacman -S --noconfirm tamarin-prover
RUN pacman -S --noconfirm python3
ENV PATH /usr/share/maude:$PATH
RUN cp /usr/bin/maude /usr/share/maude/
CMD ["tamarin-prover", "interactive", ".", "--interface=*4", "--auto-sources", "--quit-on-warning"]

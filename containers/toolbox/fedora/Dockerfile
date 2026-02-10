FROM registry.fedoraproject.org/fedora-toolbox:43

RUN dnf -y upgrade --refresh && \
    dnf install -y \
      neovim \
      htop \
      less \
      fortune-mod \
      mc \
      vim-enhanced \
      tmux \
      tree \
      zsh \
      bind-utils \
      git-crypt \
      myrepos \
      unrar-free \
      direnv \
      jq \
      xclip \
      bat \
      ripgrep \
      fd-find \
      fira-code-fonts \
      nodejs \
      npm \
    && dnf clean all && rm -rf /var/cache/dnf

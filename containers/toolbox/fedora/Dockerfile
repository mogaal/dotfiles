# Build:  podman build -t dev-toolbox /path/to/this/dir/ (or ".")
# Create: toolbox create --image dev-toolbox dev
# Enter:  toolbox enter dev
FROM registry.fedoraproject.org/fedora-toolbox:43

# Base system + locale
RUN dnf -y upgrade --refresh && \
    dnf install -y --skip-unavailable \
      glibc-langpack-en \
    && dnf clean all && rm -rf /var/cache/dnf

# CLI essentials
RUN dnf install -y --skip-unavailable \
      neovim \
      htop \
      less \
      tmux \
      tree \
      zsh \
      mc \
      fortune-mod \
      bat \
      ripgrep \
      fd-find \
      fzf \
      zoxide \
      jq \
      yq \
      direnv \
      xclip \
      stow \
    && dnf clean all && rm -rf /var/cache/dnf

# eza is not in default Fedora repos, install via cargo or skip
RUN dnf install -y --skip-unavailable cargo && \
    cargo install eza && \
    cp ~/.cargo/bin/eza /usr/local/bin/ && \
    rm -rf ~/.cargo && \
    dnf remove -y cargo && \
    dnf clean all && rm -rf /var/cache/dnf

# Dev tools + build essentials
RUN dnf install -y --skip-unavailable \
      git-crypt \
      git-delta \
      myrepos \
      make \
      gcc \
      gcc-c++ \
      openssl \
      python3 \
      python3-pip \
      nodejs \
      ShellCheck \
    && dnf clean all && rm -rf /var/cache/dnf

# Fonts + misc
RUN dnf install -y --skip-unavailable \
      fira-code-fonts \
      bind-utils \
      unrar-free \
    && dnf clean all && rm -rf /var/cache/dnf

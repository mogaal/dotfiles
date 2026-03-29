FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      wget \
      unzip \
      lsof \
      git \
      openssh-client \
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
      git-crypt \
      git-delta \
      myrepos \
      make \
      build-essential \
      openssl \
      python3 \
      python3-pip \
      lua5.1 \
      luarocks \
      nodejs \
      npm \
      shellcheck \
      dnsutils \
      unrar-free \
      xz-utils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# CLI tools expected by current Neovim setup.
RUN npm install -g tree-sitter-cli opencode-ai@latest

# lazygit is not available in default Ubuntu repos; install from upstream release.
RUN arch="$(dpkg --print-architecture)" && \
    case "$arch" in \
      amd64) lazygit_arch="x86_64" ;; \
      arm64) lazygit_arch="arm64" ;; \
      *) echo "Unsupported architecture: $arch" >&2; exit 1 ;; \
    esac && \
    lazygit_version="$(curl -fsSL https://api.github.com/repos/jesseduffield/lazygit/releases/latest | jq -r .tag_name | sed 's/^v//')" && \
    curl -fsSL "https://github.com/jesseduffield/lazygit/releases/download/v${lazygit_version}/lazygit_${lazygit_version}_Linux_${lazygit_arch}.tar.gz" -o /tmp/lazygit.tar.gz && \
    tar -C /tmp -xzf /tmp/lazygit.tar.gz lazygit && \
    install /tmp/lazygit /usr/local/bin/lazygit && \
    rm -f /tmp/lazygit /tmp/lazygit.tar.gz

# Install latest stable Neovim (Ubuntu repo can be too old for current plugins).
RUN arch="$(dpkg --print-architecture)" && \
    case "$arch" in \
      amd64) nvim_arch="x86_64" ;; \
      arm64) nvim_arch="arm64" ;; \
      *) echo "Unsupported architecture: $arch" >&2; exit 1 ;; \
    esac && \
    curl -fsSL "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-${nvim_arch}.tar.gz" -o /tmp/nvim.tar.gz && \
    rm -rf /opt/nvim-linux-${nvim_arch} && \
    tar -C /opt -xzf /tmp/nvim.tar.gz && \
    ln -sf "/opt/nvim-linux-${nvim_arch}/bin/nvim" /usr/local/bin/nvim && \
    rm -f /tmp/nvim.tar.gz

# Ubuntu uses batcat/fdfind binary names; provide common names.
RUN ln -sf /usr/bin/batcat /usr/local/bin/bat && \
    ln -sf /usr/bin/fdfind /usr/local/bin/fd && \
    chsh -s /usr/bin/zsh root

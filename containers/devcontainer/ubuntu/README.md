# Ubuntu Dev Container (toolbox-like)

This image is for running your shell tools in a plain Docker/Podman container on Ubuntu servers, with a workflow close to toolbox.

## Build

From the repository root:

```bash
docker build -t mogaal-dev:ubuntu ./containers/devcontainer/ubuntu
```

Podman equivalent:

```bash
podman build -t mogaal-dev:ubuntu ./containers/devcontainer/ubuntu
```

## Run (mount full home, recommended)

```bash
docker run --rm -it \
  --name mogaal-dev \
  --hostname mogaal-dev \
  -v "$HOME:$HOME" \
  -w "$PWD" \
  -e HOME="$HOME" \
  --user "$(id -u):$(id -g)" \
  mogaal-dev:ubuntu zsh
```

Podman equivalent:

```bash
podman run --rm -it \
  --name mogaal-dev \
  --hostname mogaal-dev \
  -v "$HOME:$HOME" \
  -w "$PWD" \
  -e HOME="$HOME" \
  --user "$(id -u):$(id -g)" \
  mogaal-dev:ubuntu zsh
```

## Why this matches toolbox behavior

- your full home is available in the container,
- dotfiles are reused directly,
- project directories under home are already available,
- shell/editor/tmux config works without many individual bind mounts.

## Notes

- `--user "$(id -u):$(id -g)"` keeps created files owned by your host user.
- `-w "$PWD"` starts you in the same project directory.
- If you want a long-lived container, remove `--rm` and later run `docker start -ai mogaal-dev`.
- If you later add sensitive keys to this server, re-evaluate full-home mounting.

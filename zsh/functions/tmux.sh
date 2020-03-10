
# Load live-1 tmux session
function tmux-live-1 {
  MATCH=$(tmux ls | grep live-1)
  if [ -n "${MATCH}" ]; then
    tmux attach -t 'live-1'
  else
    tmux new-session -s 'live-1' \; \
    send-keys 'source ~/envs/kops-live-1 && kubectl cluster-info' C-m \; \
    split-window -v \; \
    select-pane -t 1 \; \
    send-keys 'source ~/envs/kops-live-1 && kubectl cluster-info' C-m \;
  fi
}

# Load cloudsleep tmux session
function tmux-cloudsleep {
  MATCH=$(tmux ls | grep cloudsleep)
  if [ -n "${MATCH}" ]; then
    tmux attach -t 'cloudsleep'
  else
    tmux new-session -s 'cloudsleep' \; \
    send-keys 'cd ~/workspace/gitlab/cloudsleep1' C-m \; \
    split-window -v \; \
    select-pane -t 1 \; \
    send-keys 'cd ~/workspace/gitlab/cloudsleep1' C-m \;
  fi
}


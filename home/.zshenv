export ZK_NOTEBOOK_DIR="$HOME/repos/notes"

# argcomplete completions from pipx, tolerant of python version and absence
_argcomplete_dirs=("$HOME"/.local/pipx/venvs/argcomplete/lib/python*/site-packages/argcomplete/bash_completion.d(N))
(( $#_argcomplete_dirs )) && fpath=( "${_argcomplete_dirs[-1]}" "${fpath[@]}" )
unset _argcomplete_dirs

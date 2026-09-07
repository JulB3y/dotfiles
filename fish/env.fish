## environment variable declaration
fish_add_path /home/julbey/.app-support/filen-cli/bin

set -gx BG_COLOR 292522
set -gx FL_COLOR 34302C
set -gx RED_COLOR D47766
set -gx YEL_COLOR EBC06D
set -gx GRE_COLOR 85B695
set -gx CYA_COLOR 89B3B6
set -gx BLU_COLOR A3A9CE
set -gx MGT_COLOR CF9BC2

set XDG_RUNTIME_DIR /run/user/$(id -u)

# relocated app data (see ~/.app-support)
set -gx PYENV_ROOT $HOME/.app-support/pyenv
set -gx RUSTUP_HOME $HOME/.app-support/rustup
set -gx NPM_CONFIG_CACHE $HOME/.app-support/npm-cache
set -gx GNUPGHOME $HOME/.app-support/gnupg
set -gx GIT_CONFIG_GLOBAL $HOME/.app-support/gitconfig


# fish completion for glyph. Generate: `glyph completions fish`;
# install: `glyph completions install`.

complete -c glyph -f

# Layer 1: subcommands at the first argument position.
complete -c glyph -n __fish_use_subcommand -a index -d 'Manage the catalog index'
complete -c glyph -n __fish_use_subcommand -a search -d 'Search the catalog'
complete -c glyph -n __fish_use_subcommand -a list -d 'List fonts'
complete -c glyph -n __fish_use_subcommand -a info -d 'Show font details'
complete -c glyph -n __fish_use_subcommand -a install -d 'Install a font'
complete -c glyph -n __fish_use_subcommand -a remove -d 'Remove an installed font'
complete -c glyph -n __fish_use_subcommand -a upgrade -d 'Upgrade fonts'
complete -c glyph -n __fish_use_subcommand -a completions -d 'Shell completion setup'
complete -c glyph -n __fish_use_subcommand -a help -d 'Show help'

# Layer 2: subcommand actions and flags.
complete -c glyph -n '__fish_seen_subcommand_from index' -a update -d 'Download and verify the catalog'
complete -c glyph -n '__fish_seen_subcommand_from index' -a status -d 'Show cached catalog information'
complete -c glyph -n '__fish_seen_subcommand_from completions' -a fish -d 'Print the fish completion script'
complete -c glyph -n '__fish_seen_subcommand_from completions' -a install -d 'Install the fish completion script'
complete -c glyph -n '__fish_seen_subcommand_from install remove upgrade' -l no-cache -d 'Skip fontconfig cache refresh'
complete -c glyph -n '__fish_seen_subcommand_from install remove upgrade' -l verbose -d 'Show full fc-cache output'
complete -c glyph -n '__fish_seen_subcommand_from list' -l catalog -d 'List catalog fonts'
complete -c glyph -n '__fish_seen_subcommand_from upgrade' -l all -d 'Upgrade all installed fonts'
complete -c glyph -n '__fish_seen_subcommand_from index search list info install remove upgrade completions' -l help -d 'Show help'

# Layer 3: live font ids from the hidden `__complete` backend.
complete -c glyph -n '__fish_seen_subcommand_from info' -a '(glyph __complete info (commandline -ct))'
complete -c glyph -n '__fish_seen_subcommand_from install' -a '(glyph __complete install (commandline -ct))'
complete -c glyph -n '__fish_seen_subcommand_from remove' -a '(glyph __complete remove (commandline -ct))'
complete -c glyph -n '__fish_seen_subcommand_from upgrade' -a '(glyph __complete upgrade (commandline -ct))'

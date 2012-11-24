
tmux status bar scripts
=======================

To use:

1) Create a configuration based on `config` in the repo.  Tweak the
   variables as desired to produce the right mix of status bar
   attributes.  Variables are:

  * `PREFIX` - this comes at the beginning of the status bar.

  * `SUFFIX` - this comes at the end of the status bar.

  * `DEFAULT_ITEM_ATTR` - the attribute string inserted just prior to
     each status bar entry.

  * `SEPARATOR` - the string inserted in between status bar entries.

  * `SCRIPTS` - space-separated list of script names, without ".sh"
     extensions, referring to scripts in the `scripts/` directory.

2) Update your `tmux.conf` to set `status-right` as follows:

    set -g status-right '#(.../tmux-status/tmux-status.sh .../config)'

Notes:

A script named in `$SCRIPTS` will be quietly omitted from the status
bar if:

 * it does not exist in the scripts directory;

 * it does exist but is not executable;

 * it exists and is executable but produces no output.

Otherwise, the output of the script will be added to the status bar
and separators will be added as appropriate.

The main script, `tmux-status.sh`, can be run with the `--strict`
argument to force the script to exit if it cannot find all and run of
the named scripts in `$SCRIPTS`:

    tmux-config.sh .../config --strict

`$PREFIX` and `$SUFFIX` will only be added to the status bar if at
least one status bar entry ran successfully.

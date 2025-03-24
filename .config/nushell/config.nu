$env.config.show_banner = false
$env.config = ($env.config | upsert hooks {
    display_output: {
        metadata access {|meta| match $meta.content_type? {
            "application/x-nuscript" | "application/x-nuon" | "text/x-nushell" => { nu-highlight },
            "application/json" => { ^bat --language=json --color=always --style=plain --paging=never },
            "text/x-python" => { ^bat --language=python --color=always --style=plain --paging=never },
            _ => {},
        }} | table
    }
})
$env.config = ($env.config | upsert keybindings [
    {
      name: fuzzy_history
      modifier: control
      keycode: char_r
      mode: [emacs, vi_normal, vi_insert]
      event: [
        {
          send: ExecuteHostCommand
          cmd: "let result = (
            history
            | get command
            | uniq
            | reverse
            | str join (char -i 0)
            | fzf --scheme=history
              --read0
              --height=40%
              --bind=ctrl-r:toggle-sort
              --highlight-line
              --query=(commandline | str substring 0..(commandline get-cursor))
              +m
            | complete
          ); if ($result.exit_code == 0) { commandline edit ($result.stdout | str trim) }"
        }
      ]
    }
    {
      name: fuzzy_file_dir_completion
      modifier: control
      keycode: char_t
      mode: [emacs, vi_normal, vi_insert]
      event: [
        {
          send: ExecuteHostCommand
          cmd: "commandline edit --insert (
            fzf --scheme=path
              --read0
              --height=40%
              --reverse
              --walker=file,dir,follow,hidden
              -m
            | lines 
            | str join ' '
          )"
        }
      ]
    }
])

alias cat = bat

alias ls-builtin = ls

def ls [
    --all (-a),         # Show hidden files
    --long (-l),        # Get all available columns for each entry (slower; columns are platform-dependent)
    --full-paths (-f),  # display paths as absolute paths
    --directory (-D),   # List the specified directory itself instead of its contents
    --mime-type (-m),   # Show mime-type in type column instead of 'file' (based on filenames only; files' contents are not examined)
    --threads (-t),     # Use multiple threads to list contents. Output will be non-deterministic.
    ...pattern: glob,   # The glob pattern to use.
]: [ nothing -> table ] {
    let pattern = if ($pattern | is-empty) { [ '.' ] } else { $pattern }
    let short_names = if ($full_paths) { false } else { true }

    if ($long) {
        (ls-builtin
            --all=$all
            --long=$long
            --short-names=$short_names
            --full-paths=$full_paths
            --du=true
            --directory=$directory
            --mime-type=$mime_type
            --threads=$threads
            ...$pattern
        )
    } else {
        (ls-builtin
            --all=$all
            --long=true
            --short-names=$short_names
            --full-paths=$full_paths
            --du=true
            --directory=$directory
            --mime-type=$mime_type
            --threads=$threads
            ...$pattern
        ) | select mode type size user group modified name
    }
}


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

alias cat = bat

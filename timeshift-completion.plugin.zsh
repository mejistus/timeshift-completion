#compdef timeshift

# Timeshift zsh completion plugin
# For Timeshift v25.12.4+

_timeshift() {
    local -a actions global_opts
    local ret=1

    # Primary actions (mutually exclusive)
    actions=(
        '--check[Create snapshot if scheduled]'
        '--create[Create snapshot (even if not scheduled)]'
        '--restore[Restore snapshot]'
        '--delete[Delete snapshot]'
        '--delete-all[Delete all snapshots]'
        '--list-snapshots[List snapshots]'
        '--list[List snapshots]'
        '--list-devices[List devices]'
        '--help[Show all options]'
        '--version[Print version number]'
    )

    # Global options
    global_opts=(
        '--snapshot-device[Specify backup device]:device:_timeshift_devices'
        '--yes[Answer YES to all confirmation prompts]'
        '--btrfs[Switch to BTRFS mode]'
        '--rsync[Switch to RSYNC mode]'
        '--debug[Show additional debug messages]'
        '--verbose[Show rsync output]'
        '--quiet[Hide rsync output]'
        '--scripted[Run in non-interactive mode]'
    )

    # Context-dependent options
    local -a create_opts restore_opts delete_opts
    create_opts=(
        '--comments[Set snapshot description]:description:'
        '--tags[Add tags to snapshot]:tag:(O B H D W M)'
    )
    restore_opts=(
        '--snapshot[Specify snapshot to restore]:snapshot:_timeshift_snapshots'
        '--target-device[Specify target device]:device:_timeshift_devices'
        '--target[Specify target device]:device:_timeshift_devices'
        '--grub-device[Specify device for GRUB2 bootloader]:device:_timeshift_devices'
        '--grub[Specify device for GRUB2 bootloader]:device:_timeshift_devices'
        '--skip-grub[Skip GRUB2 reinstall]'
    )
    delete_opts=(
        '--snapshot[Specify snapshot to delete]:snapshot:_timeshift_snapshots'
    )

    # Build completions based on what's already on the line
    local -a all_opts=($actions $global_opts)

    if (( ${words[(I)--create]} )); then
        all_opts+=($create_opts)
    elif (( ${words[(I)--restore]} )); then
        all_opts+=($restore_opts)
    elif (( ${words[(I)--delete]} )); then
        all_opts+=($delete_opts)
    fi

    _arguments -s -S $all_opts && ret=0
    return ret
}

# Complete snapshot names from timeshift --list output
_timeshift_snapshots() {
    local -a snaps
    local line
    # Parse "timeshift --list --scripted" output: snapshot names look like "2014-10-12_16-29-08"
    while IFS= read -r line; do
        if [[ "$line" =~ '([0-9]{4}-[0-9]{2}-[0-9]{2}_[0-9]{2}-[0-9]{2}-[0-9]{2})' ]]; then
            snaps+=("${match[1]}")
        fi
    done < <(sudo timeshift --list --scripted 2>/dev/null)

    if (( ${#snaps} )); then
        _describe 'snapshot' snaps
    else
        _message 'no snapshots found (may need sudo)'
    fi
}

# Complete device paths
_timeshift_devices() {
    local -a devs
    local line
    while IFS= read -r line; do
        if [[ "$line" =~ '/dev/[^ ]+' ]]; then
            devs+=("${match[0]}")
        fi
    done < <(sudo timeshift --list-devices --scripted 2>/dev/null)

    if (( ${#devs} )); then
        _describe 'device' devs
    else
        # Fall back to block devices
        _files -W /dev -g 'sd*|nvme*|vd*|md*|mapper/*'
    fi
}

compdef _timeshift timeshift

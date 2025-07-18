#compdef timeshift

# Timeshift zsh completion
# 作者: Claude
# 版本: 1.0

_timeshift() {
    local context state line
    typeset -A opt_args

    _arguments -C \
        '(--list -l)'{--list,-l}'[列出快照]' \
        '(--create -c)'{--create,-c}'[创建快照]' \
        '(--restore -r)'{--restore,-r}'[恢复快照]' \
        '(--delete -d)'{--delete,-d}'[删除快照]' \
        '(--check)'{--check}'[检查快照]' \
        '(--help -h)'{--help,-h}'[显示帮助信息]' \
        '(--version -v)'{--version,-v}'[显示版本信息]' \
        '(--verbose)'{--verbose}'[详细输出]' \
        '(--quiet -q)'{--quiet,-q}'[静默模式]' \
        '(--yes -y)'{--yes,-y}'[自动确认所有提示]' \
        '(--scripted)'{--scripted}'[脚本模式，适合在脚本中使用]' \
        '(--tags)'{--tags}'[指定标签]:标签:(ondemand boot hourly daily weekly monthly)' \
        '(--comments)'{--comments}'[添加注释]:注释:' \
        '(--snapshot-device)'{--snapshot-device}'[指定快照设备]:设备:_files -/' \
        '(--backup-device)'{--backup-device}'[指定备份设备]:设备:_files -/' \
        '(--include-hidden)'{--include-hidden}'[包含隐藏文件]' \
        '(--exclude)'{--exclude}'[排除文件模式]:模式:' \
        '(--list-snapshots)'{--list-snapshots}'[列出所有快照]' \
        '(--list-devices)'{--list-devices}'[列出所有设备]' \
        '(--snapshot)'{--snapshot}'[指定快照]:快照:->snapshots' \
        '(--skip-grub)'{--skip-grub}'[跳过 GRUB 更新]' \
        '(--grub-device)'{--grub-device}'[指定 GRUB 设备]:设备:_files -/' \
        '(--config)'{--config}'[指定配置文件]:配置文件:_files' \
        '(--btrfs)'{--btrfs}'[使用 BTRFS 模式]' \
        '(--rsync)'{--rsync}'[使用 RSYNC 模式]' \
        '*:文件:_files' && ret=0

    case $state in
        snapshots)
            local snapshots
            snapshots=(${(f)"$(timeshift --list --scripted 2>/dev/null | awk '{print $1}')"})
            if [[ ${#snapshots[@]} -gt 0 ]]; then
                _describe '快照' snapshots
            fi
            ;;
    esac

    return ret
}

# 辅助函数：获取快照列表
_timeshift_get_snapshots() {
    local snapshots
    snapshots=(${(f)"$(timeshift --list --scripted 2>/dev/null | awk '{print $1}')"})
    echo "${snapshots[@]}"
}

# 辅助函数：获取设备列表
_timeshift_get_devices() {
    local devices
    devices=(${(f)"$(timeshift --list-devices --scripted 2>/dev/null | awk '{print $1}')"})
    echo "${devices[@]}"
}

# 当直接调用时，应用补全
_timeshift "$@"

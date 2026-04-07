# timeshift-completion

[Timeshift](https://github.com/linuxmint/timeshift) (v25.12.4+) 的 Zsh 补全插件，适用于 [Oh My Zsh](https://ohmyz.sh/)。

## 功能

- 补全所有操作（`--create`、`--restore`、`--delete`、`--list` 等）
- 上下文感知选项：`--comments`/`--tags` 仅在 `--create` 后出现，`--snapshot`/`--target-device`/`--skip-grub` 仅在 `--restore` 后出现，以此类推
- 动态快照名补全（从 `timeshift --list` 输出中解析）
- 动态设备补全（从 `timeshift --list-devices` 获取，失败时回退到 `/dev` 下的块设备）
- 标签值补全（`O` `B` `H` `D` `W` `M`）

## 安装

### Oh My Zsh

```bash
# 克隆到自定义插件目录
git clone https://github.com/mejistus/timeshift-completion \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/timeshift-completion

# 或直接复制文件
mkdir -p ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/timeshift-completion
cp timeshift-completion.plugin.zsh \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/timeshift-completion/
```

在 `~/.zshrc` 的插件列表中添加 `timeshift-completion`：

```zsh
plugins=(... timeshift-completion)
```

重新加载 shell：

```bash
source ~/.zshrc
```

### 手动安装

在 `~/.zshrc` 中直接 source 该文件：

```zsh
source /path/to/timeshift-completion.plugin.zsh
```

## 使用

```bash
timeshift --<TAB>            # 显示所有操作和全局选项
timeshift --create --<TAB>   # 显示 --comments、--tags 及全局选项
timeshift --restore --<TAB>  # 显示 --snapshot、--target-device、--skip-grub 等
timeshift --delete --<TAB>   # 显示 --snapshot 及全局选项
timeshift --tags <TAB>       # 显示标签值：O B H D W M
timeshift --snapshot <TAB>   # 列出已有快照
timeshift --snapshot-device <TAB>  # 列出可用设备
```

> 快照和设备补全会在后台调用 `sudo timeshift ...`。如果没有结果，请确保当前用户有 sudo 权限。

## 支持的选项

| 类别 | 选项 |
|------|------|
| 操作 | `--check` `--create` `--restore` `--delete` `--delete-all` `--list` `--list-snapshots` `--list-devices` `--help` `--version` |
| 创建 | `--comments <描述>` `--tags {O,B,H,D,W,M}` |
| 恢复 | `--snapshot <名称>` `--target-device <设备>` `--target <设备>` `--grub-device <设备>` `--grub <设备>` `--skip-grub` |
| 删除 | `--snapshot <名称>` |
| 全局 | `--snapshot-device <设备>` `--yes` `--btrfs` `--rsync` `--debug` `--verbose` `--quiet` `--scripted` |

## 要求

- Zsh 5.0+
- Timeshift v25.12.4+ 已安装且在 `$PATH` 中
- `sudo` 权限（用于动态快照/设备补全）

## 许可证

MIT

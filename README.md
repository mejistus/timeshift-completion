# Timeshift ZSH 补全插件

为 [Timeshift](https://github.com/teejee2008/timeshift) 系统快照工具提供智能的 ZSH 命令行补全功能。

## 🚀 功能特性

- **智能补全**: 支持所有 timeshift 命令和选项的补全
- **动态快照列表**: 自动获取和补全现有快照名称
- **设备识别**: 自动补全系统中的可用设备
- **标签支持**: 提供预定义标签的补全（ondemand、boot、hourly、daily、weekly、monthly）
- **文件路径补全**: 支持配置文件、设备路径等的智能补全
- **中文描述**: 提供中文的选项描述，更容易理解

## 📦 安装方法

### 方法一：手动安装

1. 下载补全脚本：
```bash
# 创建补全目录（如果不存在）
mkdir -p ~/.zsh/completions

# 下载补全脚本
curl -o ~/.zsh/completions/_timeshift https://raw.githubusercontent.com/your-repo/timeshift-zsh-completion/main/_timeshift
```

2. 将补全目录添加到 fpath：
```bash
# 添加到 ~/.zshrc
echo 'fpath=(~/.zsh/completions $fpath)' >> ~/.zshrc
echo 'autoload -U compinit && compinit' >> ~/.zshrc
```

3. 重新加载 zsh 配置：
```bash
source ~/.zshrc
```

### 方法二：Oh My Zsh 插件

1. 克隆或下载到 Oh My Zsh 插件目录：
```bash
cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/your-repo/timeshift-zsh-completion.git timeshift
```

2. 在 `~/.zshrc` 中启用插件：
```bash
plugins=(... timeshift)
```

3. 重新加载配置：
```bash
source ~/.zshrc
```

### 方法三：使用 zinit

```bash
# 添加到 ~/.zshrc
zinit load "your-repo/timeshift-zsh-completion"
```

### 方法四：使用 oh-my-zsh 的 git 插件系统

```bash
# 添加到 ~/.zshrc
plugins=(... timeshift)

# 然后将 _timeshift 文件放到 ~/.oh-my-zsh/custom/plugins/timeshift/ 目录下
```

## 🎯 使用说明

安装完成后，你可以享受以下补全功能：

### 基本命令补全
```bash
timeshift --<TAB>  # 显示所有可用选项
timeshift -<TAB>   # 显示所有短选项
```

### 快照相关补全
```bash
timeshift --restore --snapshot <TAB>  # 补全现有快照名称
timeshift --delete --snapshot <TAB>   # 补全要删除的快照
```

### 设备补全
```bash
timeshift --snapshot-device <TAB>     # 补全可用设备
timeshift --backup-device <TAB>       # 补全备份设备
```

### 标签补全
```bash
timeshift --tags <TAB>                # 补全预定义标签
# 可选项：ondemand, boot, hourly, daily, weekly, monthly
```

### 文件路径补全
```bash
timeshift --config <TAB>              # 补全配置文件路径
timeshift --grub-device <TAB>         # 补全 GRUB 设备路径
```

## 🔧 支持的命令和选项

### 主要命令
- `--list, -l`: 列出快照
- `--create, -c`: 创建快照
- `--restore, -r`: 恢复快照
- `--delete, -d`: 删除快照
- `--check`: 检查快照

### 常用选项
- `--snapshot-device`: 指定快照设备
- `--backup-device`: 指定备份设备
- `--snapshot`: 指定快照名称
- `--tags`: 指定标签
- `--comments`: 添加注释
- `--verbose`: 详细输出
- `--quiet, -q`: 静默模式
- `--yes, -y`: 自动确认
- `--scripted`: 脚本模式

### 高级选项
- `--include-hidden`: 包含隐藏文件
- `--exclude`: 排除文件模式
- `--skip-grub`: 跳过 GRUB 更新
- `--grub-device`: 指定 GRUB 设备
- `--config`: 指定配置文件
- `--btrfs`: 使用 BTRFS 模式
- `--rsync`: 使用 RSYNC 模式

## 🛠️ 故障排除

### 补全不工作？

1. **检查 fpath 设置**：
```bash
echo $fpath | tr ' ' '\n' | grep timeshift
```

2. **重新初始化补全系统**：
```bash
rm -f ~/.zcompdump*
autoload -U compinit && compinit
```

3. **检查 timeshift 是否在 PATH 中**：
```bash
which timeshift
```

4. **手动重新加载补全**：
```bash
unfunction _timeshift 2>/dev/null
autoload -U _timeshift
```

### 快照列表补全不工作？

确保 timeshift 命令可以正常运行：
```bash
timeshift --list --scripted
```

如果需要 sudo 权限，可以配置 sudo 免密或使用别名：
```bash
# 添加到 ~/.zshrc
alias timeshift='sudo timeshift'
```

## 📝 自定义配置

你可以通过修改补全脚本来自定义行为：

1. **添加自定义标签**：
编辑 `_timeshift` 文件中的标签列表：
```bash
'(--tags)'{--tags}'[指定标签]:标签:(ondemand boot hourly daily weekly monthly custom1 custom2)'
```

2. **修改描述语言**：
将中文描述改为英文或其他语言。

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request！

1. Fork 这个仓库
2. 创建你的特性分支 (`git checkout -b feature/amazing-feature`)
3. 提交你的更改 (`git commit -m 'Add some amazing feature'`)
4. 推送到分支 (`git push origin feature/amazing-feature`)
5. 开启一个 Pull Request

## 📄 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件。

## 🙏 致谢

- [Timeshift](https://github.com/teejee2008/timeshift) - 优秀的系统快照工具
- ZSH 补全系统文档
- 所有贡献者和测试者
- 以及Claude哈哈哈哈
---

**享受更高效的 timeshift 命令行体验！** 🎉

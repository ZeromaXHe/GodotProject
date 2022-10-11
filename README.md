# 笔记

## 快捷键

Q 选择工具

> 该模式下：
> 
> `Alt` + 拖拽边框缩放点，保持选中目标中心位置不变进行缩放
> 
> `Shift` + 拖拽，等比例缩放
> 
> `Ctrl` + 任意缩放点以外地方拖拽，以旋转轴（pivot）为中心旋转
> 
> `Ctrl` + 缩放点拖拽，对角位置不变的缩放
 
V 修改旋转轴（pivot）—— 其实就是属性里面的 offset

F 使选择对象居中

## 外部编辑器

这里使用的是 Visual Studio Code，下面是需要配置的步骤：

### Godot 配置

1. 打开 `编辑器 -> 编辑器配置`（Editor Settings）
2. 选择 `文本编辑器 -> 外部`（Text Editor > External）
3. 将 `使用外部编辑器` 开关设置为启用状态
4. 可执行路径中填写 VS Code 的 Code.exe 路径
5. 执行参数中填写 `{project} --goto {file}:{line}:{col}`

### VS Code 配置

在扩展中搜索 godot-tools 并安装

功能包括：

- 语法高亮。适用于 GDScript(`.gd`)，`.tscn` 和 `.tres` 场景格式
- 全类型的 GDScript 支持
- 可选“智能模式（Smart Mode）”来提高动态类型脚本的生产力
- 悬停时展示函数定义和文档
- 丰富的自动补全
- 展示脚本警告和错误
- `Ctrl +` 点击一个变量或者方法调用可以跳转到它的定义处
- 支持 Godot 引擎 API 全部文档
- 从 VS Code 中启动 Godot 引擎
- 使用 VS Code 调试你的基于 GDScript 构建的 Godot 项目。支持断点，跳入、跳出、跳过，变量查询，调用栈和动态场景树

你可以使用下面设置来配置 Godot Tools:

`editor_path` - Godot 编辑器 exe 的绝对路径。对于 Mac OS，执行软件在 Godot.app 中。
`gdscript_lsp_server_port` - GDScript 语言服务器的 WebSocket 服务器端口。
`check_status` - 检查 GDScript 语言服务器连接状态。

#### GDScript Debugger 配置

在 VS Code 中配置:

`Ctrl + Shift + D` 或者左侧点击查看“运行和调试”界面，如果没有 GDScript Godot 的调试配置，则增加一个

如果已经有 `launch.json` 的话，则可以按照下面方式修改配置：

1. `Ctrl + Shift + P` 或 `F1` 打开命令面板
2. 使用命令 `>Debug: Open launch.json`
3. 选择 Debug Godot configuration
4. 修改相关设置
5. `F5` 启动

但我没有配通…… 这就让 VS Code 很鸡肋了，GDScript 还是不好重构，用 VS Code 只是多几个快捷键（虽然我也用的少，不熟悉 VS Code）……

还是老老实实用 Godot 自带的编辑器吧，要改代码的时候还不如直接 IDEA 改，习惯了。

# TODO

Tetris

Snake (TileMap)

Flappy Bird (Physics)

3D Pinball (Physics)

Shooting Game

# 资源声明

fonts 文件夹中：

使用的 `SourceHanSansCN-Normal.ttf` 文件为 [思源黑体](https://github.com/adobe-fonts/source-han-sans) 开源字体，基于 OFL-1.1 协议开源。

使用的 `unifont-15.0.01.ttf` 文件为 [GNU Unifont](http://unifoundry.com/unifont/index.html) 开源字体，基于 GNU GPL 2.0 和 OFL 1.1 协议开源

platformer\assets 文件夹中：

使用的 `platformerPack_character.png` 和 `platformPack_tilesheet.png` 文件来自于 Kenney 的 [Simplified Platformer Pack](https://www.kenney.nl/assets/simplified-platformer-pack)， 基于 CC0 1.0 Universal 协议，可以免费用于个人项目与商用

使用的 `cloudLayer1.png`、`cloudLayer2.png` 和 `mountains.png` 文件来自于 Kenney 的 [Background Elements Redux](https://www.kenney.nl/assets/background-elements-redux)， 基于 CC0 1.0 Universal 协议，可以免费用于个人项目与商用

使用的 `gold.png` 文件 (1 ~ 4) 来自于 Kenney 的 [Jumper Pack](https://www.kenney.nl/assets/jumper-pack)， 基于 CC0 1.0 Universal 协议，可以免费用于个人项目与商用

使用的 `enemies.png` 文件来自于 Kenney 的 [Platformer Pack Redux](https://www.kenney.nl/assets/platformer-pack-redux)， 基于 CC0 1.0 Universal 协议，可以免费用于个人项目与商用

platformer\assets\audio 文件夹中：

使用的 `coin_picked.ogg`（原名 `toggle_002.ogg`）、`fly_dead.ogg`（原名 `close_001.ogg`）、`jump.ogg`（原名 `bong_001.ogg`）、`player_dead.ogg`（原名 `question_001.ogg`）、`slime_dead.ogg`（原名 `drop_001.ogg`） 文件来自于 Kenney 的 [Interface Sounds](https://www.kenney.nl/assets/interface-sounds)， 基于 CC0 1.0 Universal 协议，可以免费用于个人项目与商用

以上版权归原公司或团体所有，也向他们表示感谢~
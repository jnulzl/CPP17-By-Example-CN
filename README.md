# C++17 By Example（中文翻译版 · LaTeX 工程）

把 Stefan Björnander 的 *C++17 By Example*（Packt, 2018）全书译为中文，
并按 **Packt 原书版式**重新排版。本目录即编译工程根；原书英文 PDF 在上一层目录。

- 原书：*C++17 By Example — Practical projects to get you up and running with C++17*
- 作者：Stefan Björnander（Packt Publishing, 2018）
- 中文名：**C++17 By Example（中文版）**

---

## 目录结构

```
latex_source/                  # 本目录即工程根
├── main.tex                   # 编译入口：\input{book/ccs.tex} + \subfile{book/index.tex}
├── build.bat                  # ✅ 本项目用这个脚本编译（三遍 xelatex + 清理 minted 缓存）
├── fonts/                     # 空目录（模板遗留；本项目全部用系统字体，见「字体映射」）
├── images/                    # 42 张图片：cover.png 封面 + 插图 + 提示块图标
├── main.pdf                   # 编译成品（388 页）
├── nul                        # 残留空目录（Windows 保留设备名，删不掉；无害，不影响编译）
└── book/
    ├── ccs.tex                # 导言区（479 行）：页面/字体/宏包、代码块、提示块、索引、装配宏
    ├── index.tex              # 章节装配（手写静态文件，增删章节改这里）
    ├── manning-pygments-style.tex  # 代码高亮配色
    └── content/
        ├── front/             # titlepage / copyright / dedication / mapt / about / preface / conventions
        ├── main/              # 01–10.tex（10 章，共约 1.76 万行）
        └── back/              # otherbooks.tex（其他书推荐）+ index.tex（索引，静态手写）
```

---

## 环境依赖

| 依赖 | 版本 / 说明 |
|---|---|
| TeX Live | 2026（含 `xelatex`、minted **v3** / `latexminted`、`pygmentize`） |
| Python | 3.x，本机装于 `D:\anaconda3`。`build.bat` 已把它放在 PATH 最前 |
| 中文字体 | **Source Han Serif SC（思源宋体）**、**Microsoft YaHei** |
| 拉丁字体 | Palatino Linotype、Arial |
| 等宽字体 | Consolas |

> `build.bat` 里写死了 `TEXBIN=D:\ProgramData\texlive\2026\bin\windows` 与
> `PYTHON=D:\anaconda3`，换机器需先改这两行。字体全部从 `C:/Windows/Fonts/`
> 按文件直接加载，**必须**本机已安装思源宋体与微软雅黑，否则报 font not found。

---

## 编译

双击 `build.bat`，或从命令行：

```bash
build.bat
```

脚本做的事：

1. 把 Python 与 TeX bin 塞到 PATH 最前；
2. 把 `TEXMF_OUTPUT_DIRECTORY` 设为**本工程绝对根**（minted v3 的硬要求，见「已知坑」第 1 条）；
3. 连跑 **三遍** `xelatex -shell-escape`（目录 / 页码 / 索引引用需要多遍收敛）；
4. 检查 `main.log` 里是否残留 minted 高亮失败，有则报错退出；
5. 清理当前目录的 `*.minted` / `*.listing` 中间文件。

- `-shell-escape` 是必须的（minted 调外部高亮器）。
- 首次编译或 `book/content/**` 有改动后，minted 会重高亮全部代码清单
  （全书 **1405 个** `codebox`），耗时较长；缓存命中时快得多。
- 手工编译时的等价命令（PATH 需先把 Python 放前面）：

```bash
export PATH="/d/anaconda3:/d/ProgramData/texlive/2026/bin/windows:$PATH"
export TEXMF_OUTPUT_DIRECTORY="D:/Ego/trans/C++17 By Example/latex_source"
export TEXMFOUTPUT="$TEXMF_OUTPUT_DIRECTORY"
xelatex -shell-escape -interaction=nonstopmode -synctex=1 main.tex   # 跑三遍
```

---

> 如果环境配置遇到问题或者编译失败可以直接到[releases](https://github.com/jnulzl/CPP17-By-Example-CN/releases)下载最新的pdf文件
>
## 非官方代码

[CPP17-By-Example](https://github.com/PacktPublishing/CPP17-By-Example) —— 书中示例代码。

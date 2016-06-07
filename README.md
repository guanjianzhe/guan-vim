TODO： 快捷修改颜色，如vim ~/.vimrc.before.local "+/let color....." "+/\v[0-9]" 
# README(目前进度：1. 安装)

       _______  __    __       ___      .__   __.      ____    ____  __  .___  ___.
      /  _____||  |  |  |     /   \     |  \ |  |      \   \  /   / |  | |   \/   |
     |  |  __  |  |  |  |    /  ^  \    |   \|  |  _____\   \/   /  |  | |  \  /  |
     |  | |_ | |  |  |  |   /  /_\  \   |  . `  | |______\      /   |  | |  |\/|  |
     |  |__| | |  `--'  |  /  _____  \  |  |\   |         \    /    |  | |  |  |  |
      \______|  \______/  /__/     \__\ |__| \__|          \__/     |__| |__|  |__|

## 1. 安装
### 1. 复制.guan-vim和.spf13-vim-3到你的用户目录。

### 2. 用脚本安装
```bash
    cd ~/.guan-vim
    ./bootstrap.sh
```
脚本中会创建6个软连接：
.spf13-vim-3中的: .vimrc .vimrc.local .vimrc.bundles 
.guan-vim中的: .vimrc.local .vimrc.before.local .vimrc.bundles.local
这6个文件，都在用户目录创建同名的软链接：
ln -s <目标名> <链接名>

### 3. 终端配色
#### 3.1 以设置终端软件的 solarized 配色。
- putty的设置：
    文件已经下载到：`.guan-vim/tools/solarized/putty-colors-solarized/`
    在windwos环境，双击目录下的solarized_dark.reg即完成配置。进入putty后选择名为Solarize的session。
    详情查自带的文档：README.mkd
- ubuntu的terminal设置
```bash
    cd .vim/bundle/gnome-terminal-colors-solarized/
    ./set_dark.sh
```
详情查自带的文档：README.mkd
- 其它终端的设置，请查看https://github.com/altercation/solarized。

#### 3.2 powerline字体
安装包含powerline字体，然后在终端软件中，选择你喜欢的含powerline字体。
在.vim/bundle/fonts/
中，下载了一些含powerline的字体。ubuntu下推荐ubuntu mono字体。
windows上，可以自行搜索“<字体名> powerline"。

#### 3.3 设置目录的配色，这样ls的时候，字体不会模糊，配色更好看。
```bash
    `cp ~/.vim/bundle/dircolors-solarized/dircolors.256dark ~/.dircolors`
    `eval 'dircolors .dircolors'
```
#### 3.4 检测bash环境，是否支持256color
ubuntu下`echo $xterm`检测，如果不支持，在.bashrc中添加：
```bash
    if [ "$TERM" == "xterm"  ]; then
        export TERM=xterm-256color
    fi
```

### 4. 自动生产git仓库的tags
.guan-vim/tools/ctags_with_git, 里面有个简单的READ.md
安装文档设置完成后，将下面加入到.bashrc，使用英文版的git:
```bash
    # impotant for git
    export LANGUAGE='en_US.UTF-8 git'
```
Making this a separate script makes it easy to invoke .git/hooks/ctags for a one-off re-index (or git config --global alias.ctags '!.git/hooks/ctags', then git ctags),

### 5. 如果你有网络，有管理员权限，安装自动补全插件 YouCompleteMe
```bash
    cd ~/.vim/bundle/YouCompleteMe
    ./install.py --clang-completer
```

### 6. enjoy it!

## guan-vim 练级攻略(完成ing）
 1. Level 1: 找回source insight的感觉
 2. Level 2: guan-vim每日必用指令
 3. Level 3: guan-vim中让你欲罢不能的插件
 4. Level 4: 使用VIM的超能力：无插件VIM
 5. Level 5: guan-vim插件使用进阶
 6. Level 6: 自力更生，授之于渔

 1. 初步了解
     - 看http://vim.spf13.com/的插件介绍
     - 看.vimrc中， Key (re)Mappings 部分
     - .vimrc.fork中的快捷键定义
 2. 完全了解
     - 通读.vimrc和.vimrc.local
     - 到插件的官网，了解插件的使用说明。推荐到http://vimawesome.com/查找插件
     - 使用vim内的帮助手册，:help xxx

### 1. Level 1: 找回source insight的感觉
 - 搜索
  - tag搜索： :tag xxx, :tag /regu（支持正则表达式）; `:ts`; `CTRL-]`, `g_CTRL-]`, CTRL+鼠标左键。（**推荐**）
        - 搜索的返回: CTRL_t, CTRL+鼠标右键。
        - tjumps
  - <leader>fa: 使用cscope搜索,功能包括(:h cscove.txt)
      c: functions calling this function
      d: functions called by this function
      e: this egrep pattern
      f: this file
      g: this definition
      i: files #including this file
      s: this C symbol
      t: this text string
  - <leader>ff: 在当前文件搜索光标下的单词
（akg搜索，v选中，\）
 - 文件搜索
    CTRL-p
    <leader>ru, F3
 - navigation导航
   CTRL_i,o: 前进，后退
 - 列模式
   CTRL_v： 进入列模式； 然后`I`， 插入。

 > 开胃菜： 演示查看kernel源码。

### 2. Level 2: guan-vim每日必用指令
#### 2.1 最简单使用的搜索:
`/`, `?` : 向下、向上搜索；`n`, `N`: 下一个，反向下一个； `/\v`： 使用正则表达式搜索（**推荐**）
`*`, `#` : 向上、向下搜索；　shift+鼠标右键：　向上搜索（更新到ubuntu16.04后默认终端不支持。。。）
<leader>/: 取消高亮

#### 2.2 others
 - 撤销、重做：`u` `CTRL_r`（**推荐**）
 行内搜索：`f`,`t`:  t）f], 前进后退`;` `,`(代办)
 - 插入命令，按常用顺序排名：i, I, o, a, A, O。（使用方法查看手册， 如`:help i`， 实际操作几次就能理解）
    - 更好的插入方法：`gi`
 - 替换: r, cw: 替换一个字母、替换一个单词。
 - 删除: x, 或者选中后删除。
 - 重复上一次操作（实际上这是一个迷你的宏）：　`.`（英文句号）
 - 宏: qaYp<C-a>q→  ; 重复@@, @a, 100@；　（推荐使用`qq`开始录制，方便）
 - Fn功能介绍，为什么要这样设置。
 - gg文件的开头；　G文件的结尾；　数字＋gg, 数字+G, `:数字` : 跳转到某行。　
 - 行操作总结： dd（删除，其实是剪切）, yy, p（对应粘贴到下一行)
 - <leader>w, <leader>q: 快速保存、退出。

#### 2.3 other others
 - 原则： 时刻记住，用最少的按键， 实现功能。
 - 法则： <start position><command><end position>， 即全部命令，可以配合数字和位置信息使用使用。
 - 题外话1： chrome浏览器，安装vimium插件，使用vim模式； git 的editor，使用vim； tmux使用vi模式； github的编辑器atom，有vim模式插件。等等。
   题外话2： 使用markdown作笔记、写文章，使用vi作为编译。推荐在线编辑器cmd markdown（支持vim模式）， 为知笔记。
   题外话3： 多用正则表达式。

### 3. Level 3: guan-vim中让你欲罢不能的插件
#### 1. 自动补全 YouCompleteMe(原来补全这么重要，原来补全可以做得这么好，这个google员工开发的插件，架构复杂）
  - 能够补全目录、文件。
  - 能够补全命令
  - 能够跳转到定义处，目前比较少用。
#### 2. fugitive（在`:Gstatus`窗口，使用`g?`查看帮助）
 - Glog, Gxxx, <leader>gs, `:Gstatus`； 全部符号可跳转。
 - dv, `:Gdiff`: 方便的对边功能
 - `:Gblame`, `gb`: 查看历史，
#### 3. 安装、更新插件： `BundleInstall`, `BundleInstall`

#### 4.基础插件
NERDTree, `?`查看帮助。<leader>nt: 侧边栏停留（有bug）
Tagbar: `?`查看帮助。s 改变排列顺序。

 - easymotion: sxx, <leader><leader>w,b...

### 4. Level 4: 使用VIM的超能力：无插件VIM
 - grep的使用
    grep <word> .
    打开搜索列表 cw； 使用<up>, <down>历遍列表内容。
    you should also know these para: grep -E -i 'guan-vim' . -Irsn -A 3 -B 3 （and egrep)
 - 跳转到光标下文件：gf
 - 移动： CTRL-e ,CTRL-y; CTRL-u, CTRL-d; CTRL-f, CTRL-b; （**强烈推荐**,不要只用jk）
          zt（光标移动到顶部）， zb（到底部）， z.（中部）。（跟你说了zt, 你应当自己查到zb, z.。how?）
          《pratice vim》推荐阅读:h motion.txt(不要打漏.txt)
 - 方向： hjkl; w, e, b, ge, E, W
   行首，行尾跳转：0, ^, %, `g_`;
   函数间的移动： `[[`, `]]`, `[]`, `][`

 - 窗口与tab
    CTRL-w_v, :vsp
    CTRL-w_s, :sp
    CTRL-n, :tabe
     - CTRL_h,j,k,l 切换窗口
     - CTRL_w * 2, 切换窗口

 - `:!<cmd>`： vim内执行shell; SHIFT_k， 对光标单词man（用来看内核代码作用抗抗的）
 - 块选择， 

#### 替换
 :help :substitute(:help :s)
 :[range]s[ubstitute]/{pattern}/{string}/[flags] [count]
 :help range

 :[range]s/pattern/string/[c,e,g,i]
 range  指的是範圍，1,7 指從第一行至第七行，1,$ 指從第一行至最後一行，也就是整篇文章，也可以 % 代表。還記得嗎？ % 是目前編輯的文章，# 是前一次編輯的文章。
 pattern    就是要被替換掉的字串，可以用 regexp 來表示。
 string 將 pattern 由 string 所取代。
 c  confirm，每次替換前會詢問。
 e  不顯示 error。
 g  globe，不詢問，整行替換。
 i  ignore 不分大小寫。
 e.g. :
 :%s/pattern/string/cg

 - 使用session和tmux，快速还原工作环境。
 - mark
#### vim的复制（总是有人问能否使用系统粘贴板）
 - vim的复制
 Vim 有12个粘贴板依次编号为：0、1、2、...、9、a、"、+，其中 + 号为系统粘贴板，” 为临时粘贴板。系统剪切板中的内容可在其他程序中使用。上面的复制指令都可以配合剪切板进行操作。
 "nyw 复制当前单词到 n 号剪切板（双引号开始） 
 "np 粘贴 n 号剪切板内容到当前位置后 
 "+Y 复制当前行到系统剪切板
 "+ny 复制当前行加下面 n 行到系统剪切板
 "+p 粘贴系统剪切板内容到当前位置后
 链接：https://www.zhihu.com/question/19863631/answer/89354508

 ctrl+s 暂停终端输出
 ctrl+q 恢复屏幕输出
 ctrl+l 清屏，【是字母L的小写】等同于Clear
 ctrl-c 发送 SIGINT 信号给前台进程组中的所有进程。常用于终止正在运行的程序。
 ctrl-z 发送 SIGTSTP 信号给前台进程组中的所有进程，常用于挂起一个进程。
 ctrl-d 不是发送信号，而是表示一个特殊的二进制值，表示 EOF。
 ctrl-\ 发送 SIGQUIT 信号给前台进程组中的所有进程，终止前台进程并生成 core 文件。

 - ctrl+z，把vim放在后台； do something; fg, 把vim切换到前台。

#### vim diff
参考：
> http://blog.chinaunix.net/uid-22548820-id-3477464.html

1. 使用vim的比较模式打开两个文件：
vim -d file1 file2
或
vimdiff file1 file2

2. 如果已经打开了文件file1，再打开另一个文件file2进行比较：
:vert diffsplit file2
如果没有用vert命令，diffsplit则会分上下两个窗口。

3. 如果已经用split方式打开了两个文件file1，file2，又想比较两文件的不同。
分别在两个窗口里面输入命令：
:diffthis

4. 如果更改了某个窗口的内容，vim又没有自动更新diff检查，可以使用如下命令更新：
:diffupdate

5. 定位到不同点：### 跳转
" TODO: 插件是什么？
[c     跳到前一个不同点
]c     跳到后一个不同点

 - ga看看ascii码，类似man ascii
 - vim的启动参数： vim -u NONE -N
 - 代替undotree? `:changes`
### 5. Level 5: guan-vim插件使用进阶
 - undotree （使用`？`查看帮助）
 - <leader>cc： 注释； <leader>cu: 取消注释。（支持选中，软后批量注释）
 - 快速对齐Tabularize

### 6. Level 6: 自力更生，授之于渔
练级历程：
1. 看网上资料； 插件挑选网站： vimawesome
2. 看.vimrc。个性化，编辑.vimrc.local, .vimrc.bundle.local, .vimrc.before.local
3. :help 或者 :h

## tmux配置
颜色配置:
 - https://github.com/edkolev/tmuxline.vim
`:Tmuxline airline_insert`

 - 如果.bash没有自动加载
http://stackoverflow.com/questions/9652126/bashrc-profile-is-not-loaded-on-new-tmux-session-or-window-why
Yes, at the end of your .bash_profile, put the line:
```
. ~/.bashrc
This automatically sources the rc file under those circumstances where it would normally only process the profile.
```

# A highly optimized .vimrc config file

![spf13-vimrc image][spf13-vimrc-img]

The .vimrc file is suited to programming. It is extremely well organized and folds in sections.
Each section is labeled and each option is commented.

It fixes many of the inconveniences of vanilla vim including

 * A single config can be used across Windows, Mac and linux
 * Eliminates swap and backup files from littering directories, preferring to store in a central location.
 * Fixes common typos like :W, :Q, etc
 * Setup a solid set of settings for Formatting (change to meet your needs)
 * Setup the interface to take advantage of vim's features including
   * omnicomplete
   * line numbers
   * syntax highlighting
   * A better ruler & status line
   * & more
 * Configuring included plugins

## Customization

Create `~/.vimrc.local` and `~/.gvimrc.local` for any local
customizations.

For example, to override the default color schemes:

```bash
    echo colorscheme ir_black  >> ~/.vimrc.local
```

### Before File

Create a `~/.vimrc.before.local` file to define any customizations
that get loaded *before* the spf13-vim `.vimrc`.

For example, to prevent autocd into a file directory:
```bash
    echo let g:spf13_no_autochdir = 1 >> ~/.vimrc.before.local
```
For a list of available spf13-vim specific customization options, look at the `~/.vimrc.before` file.


### Fork Customization

There is an additional tier of customization available to those who want to maintain a
fork of spf13-vim specialized for a particular group. These users can create `.vimrc.fork`
and `.vimrc.bundles.fork` files in the root of their fork.  The load order for the configuration is:

1. `.vimrc.before` - spf13-vim before configuration
2. `.vimrc.before.fork` - fork before configuration
3. `.vimrc.before.local` - before user configuration
4. `.vimrc.bundles` - spf13-vim bundle configuration
5. `.vimrc.bundles.fork` - fork bundle configuration
6. `.vimrc.bundles.local` - local user bundle configuration
6. `.vimrc` - spf13-vim vim configuration
7. `.vimrc.fork` - fork vim configuration
8. `.vimrc.local` - local user configuration

See `.vimrc.bundles` for specifics on what options can be set to override bundle configuration. See `.vimrc.before` for specifics
on what options can be overridden. Most vim configuration options should be set in your `.vimrc.fork` file, bundle configuration
needs to be set in your `.vimrc.bundles.fork` file.

You can specify the default bundles for your fork using `.vimrc.before.fork` file. Here is how to create an example `.vimrc.before.fork` file
in a fork repo for the default bundles.
```bash
    echo let g:spf13_bundle_groups=[\'general\', \'programming\', \'misc\', \'youcompleteme\'] >> .vimrc.before.fork
```
Once you have this file in your repo, only the bundles you specified will be installed during the first installation of your fork.

You may also want to update your `README.markdown` file so that the `bootstrap.sh` link points to your repository and your `bootstrap.sh`
file to pull down your fork.

For an example of a fork of spf13-vim that provides customization in this manner see [taxilian's fork](https://github.com/taxilian/spf13-vim).

### Easily Editing Your Configuration

`<Leader>ev` opens a new tab containing the .vimrc configuration files listed above. This makes it easier to get an overview of your
configuration and make customizations.

`<Leader>sv` sources the .vimrc file, instantly applying your customizations to the currently running vim instance.

These two mappings can themselves be customized by setting the following in .vimrc.before.local:
```bash
let g:spf13_edit_config_mapping='<Leader>ev'
let g:spf13_apply_config_mapping='<Leader>sv'
```

# Plugins

spf13-vim contains a curated set of popular vim plugins, colors, snippets and syntaxes. Great care has been made to ensure that these plugins play well together and have optimal configuration.

## Adding new plugins

Create `~/.vimrc.bundles.local` for any additional bundles.

To add a new bundle, just add one line for each bundle you want to install. The line should start with the word "Bundle" followed by a string of either the vim.org project name or the githubusername/githubprojectname. For example, the github project [spf13/vim-colors](https://github.com/spf13/vim-colors) can be added with the following command

```bash
    echo Bundle \'spf13/vim-colors\' >> ~/.vimrc.bundles.local
```

Once new plugins are added, they have to be installed.

```bash
    vim +BundleInstall! +BundleClean +q
```

## Removing (disabling) an included plugin

Create `~/.vimrc.local` if it doesn't already exist.

Add the UnBundle command to this line. It takes the same input as the Bundle line, so simply copy the line you want to disable and add 'Un' to the beginning.

For example, disabling the 'AutoClose' and 'scrooloose/syntastic' plugins

```bash
    echo UnBundle \'AutoClose\' >> ~/.vimrc.bundles.local
    echo UnBundle \'scrooloose/syntastic\' >> ~/.vimrc.bundles.local
```

**Remember to run ':BundleClean!' after this to remove the existing directories**

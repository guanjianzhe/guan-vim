# README临时版

    
       _______  __    __       ___      .__   __.      ____    ____  __  .___  ___.
      /  _____||  |  |  |     /   \     |  \ |  |      \   \  /   / |  | |   \/   |
     |  |  __  |  |  |  |    /  ^  \    |   \|  |  _____\   \/   /  |  | |  \  /  |
     |  | |_ | |  |  |  |   /  /_\  \   |  . `  | |______\      /   |  | |  |\/|  |
     |  |__| | |  `--'  |  /  _____  \  |  |\   |         \    /    |  | |  |  |  |
      \______|  \______/  /__/     \__\ |__| \__|          \__/     |__| |__|  |__|

## 1. 安装
    1. 复制.guan-vim和.spf13-vim-3到你的用户目录。

    2. 用脚本安装
    ```bash
    cd ~/.guan-vim
    ./bootstrap.sh
    ```
    脚本中会创建6个软连接：
        .spf13-vim-3中的.vimrc .vimrc.local .vimrc.bundles 
        和 .guan-vim中的.vimrc.local .vimrc.before.local .vimrc.bundles.local
        这6个文件，都在用户目录创建同名的软链接：
        ln -s <目标名> <链接名>

    3. 终端配色
    3.1 以设置终端软件的 solarized 配色。
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

    3.2 设置目录的配色，这样ls的时候，字体不会模糊，配色更好看。
        ```bash
        `cp ~/.vim/bundle/dircolors-solarized/dircolors.256dark ~/.dircolors`
        `eval 'dircolors .dircolors'
        ```
    3.3 检测bash环境，是否支持256color
    ubuntu下`echo $xterm`检测，如果不支持，在.bashrc中添加：
    ```bash
    if [ "$TERM" == "xterm"  ]; then
        export TERM=xterm-256color
    fi
    ```

    4. 自动生产git仓库的tags: .guan-vim/tools/ctags_with_git, 里面有个简单的READ.md
        加入到.bashrc:
        ```bash
        # impotant for git
        export LANGUAGE='en_US.UTF-8 git'
        ```
    4. Making this a separate script makes it easy to invoke .git/hooks/ctags for a one-off re-index (or git config --global alias.ctags '!.git/hooks/ctags', then git ctags),

    5. 如果你有网络，有管理员权限，安装自动补全插件 YouCompleteMe
    ```bash
    cd ~/.vim/bundle/YouCompleteMe
    ./install.py --clang-completer
    ```

    6. enjoy it!

## guan-vim 练级攻略(待完成）
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

## tmux配置
颜色配置:
 - https://github.com/edkolev/tmuxline.vim
:Tmuxline airline_insert

 - 如果.bash没有自动加载
```
http://stackoverflow.com/questions/9652126/bashrc-profile-is-not-loaded-on-new-tmux-session-or-window-why
Yes, at the end of your .bash_profile, put the line:

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

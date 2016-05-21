# README临时版

## 1. 安装
    1. 复制.guan-vim和.spf13-vim-3到你的用户目录。
    2. 创建6个软连接：
        .spf13-vim-3中的.vimrc .vimrc.local .vimrc.bundles 
        和 .guan-vim中的.vimrc.local .vimrc.before.local .vimrc.bundles.local
        这6个文件，都在用户目录创建同名的软链接：
        ln -s <目标名> <链接名>
    2.2 下载 https://github.com/altercation/solarized，使用putty-colors-solarized。
        或者使用我仓库里面下载好的文件：putty-colors-solarized 。

    3. 自动生产git仓库的tags: guan-vim/ctags_with_git, 里面有个简单的READ.md
    4. enjoy it!

    5. Making this a separate script makes it easy to invoke .git/hooks/ctags for a one-off re-index (or git config --global alias.ctags '!.git/hooks/ctags', then git ctags),

## 快捷键
 1. 初步了解
     - 看http://vim.spf13.com/的插件介绍
     - 看.vimrc中， Key (re)Mappings 部分
     - .vimrc.local中的快捷键定义
 2. 完全了解
     - 通读.vimrc和.vimrc.local
     - 到插件的官网，了解插件的使用说明。推荐到http://vimawesome.com/查找插件
     - 使用vim内的帮助手册，:help xxx

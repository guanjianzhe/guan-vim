# Effortless Ctags with Git

1. git config --global init.templatedir '~/.git_template'
2. (在运行 bootstrap时已经创建）copy .git_template/ to  ~/.git_template;
    确保.git_template/hook/ 下的文件有运行权限。
3. Making this separate script .git/hooks/ctags makes it easy to invoke for a one-off re-index.
   `git config --global alias.ctags '!.git/hooks/ctags'`
    then `git ctags`
    as well as easy to edit for that special case repository that needs a different set of options to ctags.

# Effortless Ctags with Git

## install
1. 设置git模板的目录
git config --global init.templatedir '~/.git_template'
2. 拷贝模板
在运行 bootstrap.sh时已经创建模板。如已创建，则不需要再创建，但依然要检测是否有可执行权限。
```
copy .git_template/ to  ~/.git_template;
# 确保.git_template/hook/ 下的文件有可执行权限。
chmod +x .git_template/hook/*
```

## 介绍
自动创建tags
在使用`git commit` `git checkout`, `git merge`, 或则rewrite commit message时，自动在相应.git目录下，创建tags。
特别地增加了`git ctags`命令用来生成tags，可以这样使用：
```bash
git ctags &
```
Making this separate script .git/hooks/ctags makes it easy to invoke for a one-off re-index.
   `git config --global alias.ctags '!.git/hooks/ctags'`
    then `git ctags`
    as well as easy to edit for that special case repository that needs a different set of options to ctags.


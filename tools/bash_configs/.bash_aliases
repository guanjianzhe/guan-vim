
#alias mount84='sudo mount -t cifs -o username=luoyong,passwd=aw123jkl,noperm //172.16.1.84/luoyong /server84'
#alias mount9pd1='sudo mount -t cifs //172.16.1.9/msc-pd1/ /server9_msc-pd1/ -o dom=ALLWINNERTECH,user=luoyong,pass=AW123jkl,noperm'
#alias mount9swp='sudo mount -t cifs //172.16.1.9/SW-Project/ /server9_sw-project/ -o dom=ALLWINNERTECH,user=luoyong,pass=AW123jkl,noperm'
#alias mount9sfa='sudo mount -t cifs //172.16.1.9/ShareForAll/ /server9_shareforall/ -o dom=ALLWINNERTECH,user=luoyong,pass=AW123jkl,noperm'
#alias mount73='sudo mount -t cifs -o username=huangsidi,passwd=hsd7892,noperm //172.16.1.73/huangsidi /server73'
##alias mount106='sudo mount -t cifs -o username=pd1,passwd=pd123456,noperm //172.16.1.106/pd1 /server106_pd1'

#############################################################################
#
#############################################################################

#服务器

#alias mount18='sudo mount -t cifs -o username=guanjianzhe,password=guan@2016,rw //192.168.200.18/ ~/servers/18server/'
#alias cd18server='cd ~/servers/18server'

# 常用目录
alias cdbiji='cd ~/KuaiPan/全志工作/笔记'
alias cd27l4='cd /home/guanjianzhe/servers/27server/gerrit/lichee/linux-3.4'
alias cdl10='cd ~/workspace/linux-3.10/'
alias cd106a64='cd ~/servers/106server/workspace/autotest/test/smoke/a64'
alias cd60workspace='cd ~/servers/60server/workspace'

#alias mount18='sudo mount //192.168.200.18 ~/servers/18server -o username=guanjianzhe,password=guan@2016,dir_mode=0777,file_mode=0777,uid=1000,gid=1000'
#                   mount //192.168.200.74/liyong/ ~/DiskOnNet/CompileServer/ -o username=liyong,     password=xxxxxx,dir_mode=0777,   file_mode=0777,uid=1000,gid=1000
alias mount18='sudo mount //192.168.200.18/Documents         ~/servers/18server/        -o username=guanjianzhe,password=guan@2016,dir_mode=0777,file_mode=0777,uid=1000,gid=1000'

#编译服务器
alias mount60='sudo mount -t cifs -o username=guanjianzhe,password=guan@2016,rw,uid=guanjianzhe,gid=guanjianzhe //192.168.200.60/guanjianzhe/ ~/servers/60server/'
alias mount27='sudo mount -t cifs -o username=guanjianzhe,password=guan@2015,rw,uid=guanjianzhe,gid=guanjianzhe //192.168.200.27/guanjianzhe/ ~/servers/27server/'
alias mount106='sudo mount -t cifs -o username=pd1,password=password,rw,uid=guanjianzhe,gid=guanjianzhe //192.168.200.106/pd1/ ~/servers/106server/'
#alias mount106='sudo mount -t cifs -o username=pd1,passwd=pd123456,noperm //192.168.200.106/pd1 /server106_pd1'
#alias mount106='sudo mount -t cifs -o username=pd1,passwd=guan@2016,noperm //192.168.200.106/pd1 /server106_pd1'

# 常用命令
alias ssh60='ssh guanjianzhe@192.168.200.60'
alias ssh27='ssh guanjianzhe@192.168.200.27'
alias ssh106='ssh pd1@192.168.200.106'
alias h=history
alias grepi='grep -Irns'

alias livesuit='sudo /home/guanjianzhe/Bin/LiveSuit/LiveSuit.sh'
alias enwlan='sudo /home/guanjianzhe/tools/enable_wlan0.sh'

alias xrl='xrandr --output DVI-D-1 --auto --output HDMI-1 --off'
alias xrr='xrandr --output DVI-D-1 --off --output HDMI-1 --auto'
#alias xra='xrandr --output  DVI-D-1 --left-of HDMI-1 --auto && xrandr --output  HDMI-1 --right-of  DVI-D-1 --auto'
alias xra='xrandr --output  DVI-D-1 --auto  --output  HDMI-1 --auto --right-of  DVI-D-1'
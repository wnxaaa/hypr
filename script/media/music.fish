#!/usr/bin/fish
# 获取系统音量
set -l volume (pamixer --get-volume | awk '{print "【󰕾 "$1"%】"}')
# 给定默认值
set -l text "  听点什么吧~"
set -l tooltip "什么都没有播放，听点什么吧~"
set -l className "none"
# 获取播放器列表
set -l players (string split ' ' (playerctl -l))

# 循环播放器获取第一个不为stop的播放器的媒体信息
for player in $players
    if test -n $player
        set -l pStatus (playerctl -p $player status)
        if test $pStatus != Stopped
            if test $pStatus = Paused
                set className "pause"
            else
                set className "play"
            end
            set text $(playerctl -p $player metadata -f "$(playerctl status | awk '{ print $1 == "Paused"?"󰏥":"󰐌"}')  {{ title }}-{{ artist }}")
            set tooltip $(playerctl -p $player metadata -f "$(playerctl status | awk '{ print $1 == "Paused"?"【暂停中】":"【正在播放】"}')  {{ artist }} 的 《{{ title }}》")
            break
        end
    end
end
# 输出结构
printf '{"text":"%s %s","tooltip":"%s","class":"%s"}' $volume $text $tooltip $className

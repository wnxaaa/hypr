#!/usr/bin/fish
# 获取有效播放器数量 
set -l playerCount (playerctl -l|wc -l)
# 获取播放器列表
set -l player (playerctl -l)
# 如果播放器有多个，则通过rofi选择播放器
if test $playerCount -ne 1
    set player (playerctl -l|rofi -dmenu)
end
# 查看播放状态 状态为stop时置空，停止后续操作
if test -n $player
    set -l pStatus (playerctl -p $player status)
    if test $pStatus = Stopped
        set player ''
    else
        # 如果有多个播放器，则暂停其他播放器
        if test $playerCount -ne 1
            playerctl -i $player pause
        end
    end
end
# 如果状态不是停止就执行播放暂停
if test -n $player
    playerctl -p $player play-pause
end

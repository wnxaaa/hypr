bash="waybar -c $HYPR/waybar/config -s $HYPR/waybar/style.css"
while :
do
    count=$(ps -ef | grep "waybar -c"|grep -v "grep" -c)
    if [ $count == 0 ]; then
        echo "被关闭了"
        echo "正在重新启动……"
        $bash
    fi
    sleep 1
done
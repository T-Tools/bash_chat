#!/bin/bash
#Coded By Yell Phone Naing
#You can take any idea from my script
#Don't edit or modify codes,respect the coder
trap 'bye;' 2
bye () {
killall ngrok
}
32_d () {
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip
unzip ngrok-stable-linux-386.zip
}
64_d () {
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm64.tgz
unzip ngrok-stable-linux-arm64.zip
}
setup () {
echo -e "\e[1;32mSelect Your Computer Type
(1) 32 bit
(2) 64 bit
\e[0m"
read -p $'\e[1;33mEnter Choice :: \e[0m' s_c
case $s_c in
1)
32_d;;
2)
64_d;;
esac
mv ngrok /bin
chmod +x /bin/ngrok
main
}
banner () {
echo -e "\e[1;31m
              8 888888888o          .8.            d888888o.   8 8888        8 
              8 8888     88.       .888.         . 8888:   88. 8 8888        8 
              8 8888      88      :88888.        8. 8888.   Y8 8 8888        8 
              8 8888     ,88     .  88888.        8. 8888.     8 8888        8 
              8 8888.   ,88     .8.  88888.        8. 8888.    8 8888        8 
              8 8888888888     .8 8.  88888.        8. 8888.   8 8888        8 
              8 8888     88.  .8   8.  88888.        8. 8888.  8 8888888888888 
              8 8888      88 .8     8.  88888.  8b    8. 8888. 8 8888        8 
              8 8888    ,88 .888888888.  88888.  8b.  ;8. 8888 8 8888        8 
              8 888888888P .8         8.  88888.  Y8888P ,88P  8 8888        8 
\e[0m"
echo -e "\e[1;32m
                      ____ _  _ ____ ___      ____ ____ ____ _  _ 
                      |    |__| |__|  |       |__/ |  | |  | |\/| 
                      |___ |  | |  |  |       |  \ |__| |__| |  | 
                            Coder [-:-] Yell Phone Naing
\e[0m"  
}

server_local () {
echo -e "\e[1;32mStarting Necat Server At 8765\e[0m"
mawk -W interactive '$0="\033[1;32mServer : \033[0m"$0' | nc -l -p 8765
}
server_wide () {
echo -e "\e[1;31mIf you don't have Ngrok Token.\e[0m"
echo -e "\e[1;32mGo To https://ngrok.io\e[0m"
read -p $'\e[1;33mEnter Ngrok Token :: \e[0m' token
ngrok authtoken $token >/dev/null 2>&1
ngrok tcp 8765 >/dev/null 2>&1 & sleep 10
domain="$(curl -sN http://127.0.0.1:4040/api/tunnels | grep -oP "tcp://[0-9]*\.tcp.ngrok.io:[0-9]*" | grep -oP 'tcp://\K[^>]').tcp.ngrok.io"
port=$(curl -sN http://127.0.0.1:4040/api/tunnels | grep -oP "tcp://[0-9]*\.tcp.ngrok.io:[0-9]*" | grep -oP 'tcp://[0-9]*\.tcp.ngrok.io:\K[^>]*')
ip=$(ping -c1 $domain | sed -nE 's/^PING[^(]+\(([^)]+)\).*/\1/p')
echo $domain
echo -e "\e[1;32mServer IP : $ip
Server Port : $port\e[0m"
server_local
}
client () {
read -p $'\e[1;33mEnter Host IP :: \e[0m' ip
read -p $'\e[1;33mEnter Host Port :: \e[0m' port
mawk -W interactive '$0="\033[1;31mClient : \033[0m"$0' | nc $ip $port
}

server_c () {
echo -e "\e[1;32m
(1) Local
(2) Wide 
\e[0m"
read -p $'\e[1;33mEnter Choice :: \e[0m' s_c
case $s_c in
1)
server_local;;
2)
server_wide;;
esac
}
menu () {
echo -e "\e[1;32m
(1) Server Host
(2) Client
(3) Setup 
\e[0m"
read -p $'\e[1;33mEnter Choice :: \e[0m' c
case $c in
1)
server_c;;
2)
client;;
3)
setup;;
esac
}
main () {
banner
menu
}
main

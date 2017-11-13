#!/bin/bash

# \e \033 \x1B
	
#colors
YEL='\033[1;33m' # YELLOW
LGR='\033[1;32m' # LIGHT GREEN
RED='\033[0;35m' # PURPLE
PUR='\033[0;35m' # PURPLE
NOC='\033[0m'    # NO COLOR
INV='\033[7m'	 # INVERTED
DIM='\033[2mDim' # DIM
 


#exit 1


printf "\n\n"

printf "${RED}Döviz Kurları:${NOC}\n"

dolar=$(wget -qO- "https://finance.google.com/finance/converter?a=1&from=USD&to=TRY" | sed "/res/!d;s/<[^>]*>//g")
printf "$dolar\n"

euro=$(wget -qO- "https://finance.google.com/finance/converter?a=1&from=EUR&to=TRY" | sed "/res/!d;s/<[^>]*>//g")
printf "$euro\n"

sterlin=$(wget -qO- "https://finance.google.com/finance/converter?a=1&from=GBP&to=TRY" | sed "/res/!d;s/<[^>]*>//g")
printf "$sterlin\n\n"


printf "${RED}Bitcoin:${NOC}\n"

bitcoinusd=$(wget -qO- "https://finance.google.com/finance/converter?a=1&from=BTC&to=USD" | sed "/res/!d;s/<[^>]*>//g")
printf "$bitcoinusd\n"

bitcoin=$(wget -qO- "https://finance.google.com/finance/converter?a=1&from=BTC&to=TRY" | sed "/res/!d;s/<[^>]*>//g")
printf "$bitcoin\n\n"


benzin=$(curl -s "http://benzinal.com/denizli-benzin-fiyatlari" 2> /dev/null | sed '\=</table={p;Q}' | tail -n $((3)) | sed 's/<[^>]\+>/ /g')
motorin=$(curl -s "http://benzinal.com/denizli-motorin-fiyatlari" 2> /dev/null | sed '\=</table={p;Q}' | tail -n $((3)) | sed 's/<[^>]\+>/ /g')

printf "${RED}Benzin:${NOC}\n"
sleep 1
printf $benzin
printf "\n\n"


printf "${RED}Motorin:${NOC}\n"
sleep 1
printf $motorin
printf "\n\n"



printf "${RED}Güncel Haber Başlıkları (Anadolu Ajansı RSS):${NOC}\n"
sleep 1
RSS_URL="http://aa.com.tr/tr/rss/default?cat=guncel"
#curl --silent $RSS_URL | head
# head kısmındaki title-description görmezden gel. 4.satırdan başla
#grep -E '(title>|description>)'
#| tail -n $((20))
guncel=$(curl --silent $RSS_URL | grep -E '(title>)' | tail -n $((20)) |  sed -n '4,$p' | sed -e 's/<[^>]*>//g' | sed -e 's/^[ \t]*//' | sed 's/$//')
printf "$guncel\n"
printf "\n\n"

printf "${RED}Spor Haber Başlıkları (Anadolu Ajansı RSS):${NOC}\n"
sleep 1
RSS_URL="http://aa.com.tr/tr/rss/default?cat=spor"
#curl --silent $RSS_URL | head
# head kısmındaki title-description görmezden gel. 4.satırdan başla
#grep -E '(title>|description>)'
#| tail -n $((20))
spor=$(curl --silent $RSS_URL | grep -E '(title>)' | tail -n $((20)) |  sed -n '4,$p' | sed -e 's/<[^>]*>//g' | sed -e 's/^[ \t]*//' | sed 's/$//')
printf "$spor\n"
printf "\n"

printf "\n\n"

printf "${RED}======== Hava Durumu ========${NOC}\n\n"
sleep 1
#external ip
ip=$(curl -s ipinfo.io/$ip)
sehir=$(curl -s ipinfo.io/$ip/city)
curl -s tr.wttr.in/$sehir?0
printf "\n\n"


exit 1









:'
printf "Lütfen bir seçenek girin :${YEL}spor, finans, hava${NOC}\n" 

read select_menu 

case $select_menu in

finans) 
		dolar=$(wget -qO- "https://finance.google.com/finance/converter?a=1&from=USD&to=TRY" | sed "/res/!d;s/<[^>]*>//g") 
		euro=$(wget -qO- "https://finance.google.com/finance/converter?a=1&from=EUR&to=TRY" | sed "/res/!d;s/<[^>]*>//g")
		sterlin=$(wget -qO- "https://finance.google.com/finance/converter?a=1&from=GBP&to=TRY" | sed "/res/!d;s/<[^>]*>//g")
		printf "${INV}$dolar${NOC}\t"
		printf "${INV}$euro${NOC}\t"
		printf "${INV}$sterlin${NOC}\n"
		
		;;

hava)
		#external ip
		ip=$(curl -s ipinfo.io/$ip)
		sehir=$(curl -s ipinfo.io/$ip/city)
		curl -s tr.wttr.in/$sehir?n

		;;

spor)
		RSS_URL="http://aa.com.tr/tr/rss/default?cat=spor"
		#curl --silent $RSS_URL | head
		# head kısmındaki title-description görmezden gel. 4.satırdan başla
		#grep -E '(title>|description>)'
		#| tail -n $((20))
		spor=$(curl --silent $RSS_URL | grep -E '(description>)' | tail -n $((20)) |  sed -n '4,$p' | sed -e 's/<[^>]*>//g' | sed -e 's/^[ \t]*//' | sed 's/$/\n/')
		printf "${LGR}$spor${NOC}\n"

		;;

özet)   


		;;

*) 
		printf "${RED}Invalid Command${NOC}\n" 

    	;;

esac 
'
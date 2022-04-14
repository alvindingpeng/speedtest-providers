speed_test() {
	local speedtest=$( curl  -m 12 -Lo /dev/null -skw "%{speed_download}\n" "$1" )
	local host=$(awk -F':' '{print $1}' <<< `awk -F'/' '{print $3}' <<< $1`)
	local ipaddress=$(ping -c1 -n ${host} | awk -F'[()]' '{print $2;exit}')
	local nodeName=$2
	printf "%-32s%-24s%-14s\n" "${nodeName}:" "${ipaddress}:" "$(FormatBytes $speedtest)"
}

FormatBytes() {
	bytes=${1%.*}
	local Mbps=$( printf "%s" "$bytes" | awk '{ printf "%.2f", $0 / 1024 / 1024 * 8 } END { if (NR == 0) { print "error" } }' )
	if [[ $bytes -lt 1000 ]]; then
		printf "%8i B/s |      N/A     "  $bytes
	elif [[ $bytes -lt 1000000 ]]; then
		local KiBs=$( printf "%s" "$bytes" | awk '{ printf "%.2f", $0 / 1024 } END { if (NR == 0) { print "error" } }' )
		printf "%7s KiB/s | %7s Mbps" "$KiBs" "$Mbps"
	else
		# awk way for accuracy
		local MiBs=$( printf "%s" "$bytes" | awk '{ printf "%.2f", $0 / 1024 / 1024 } END { if (NR == 0) { print "error" } }' )
		printf "%7s MiB/s | %7s Mbps" "$MiBs" "$Mbps"
		# bash way
		# printf "%4s MiB/s | %4s Mbps""$(( bytes / 1024 / 1024 ))" "$(( bytes / 1024 / 1024 * 8 ))"
	fi
}

speed() {
	printf "%-32s%-31s%-14s\n" "Node Name:" "IPv4 address:" "Download Speed"
	speed_test 'http://cachefly.cachefly.net/100mb.test' 'CacheFly'
	speed_test 'https://sgp-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Singapore, Asian-SG'
	speed_test 'https://bom-in-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Mumbai, Asian-IN'
	speed_test 'https://sel-kor-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Seoul, Asian-KR'
                speed_test 'https://hnd-jp-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Tokyo, Asian-JP'
                speed_test 'https://ams-nl-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Amsterdam, Europe-NL'
                speed_test 'https://fra-de-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Frankfurt, Europe-DE'
                speed_test 'https://lon-gb-ping.vultr.com/vultr.com.100MB.bin' 'Vultr,London, Europe-GB'
                speed_test 'https://par-fr-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Paris, Europe-FR'
                speed_test 'https://sto-se-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Stockholm, Europe-SE'
                speed_test 'https://lax-ca-us-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Los angeles, North America-US'
                speed_test 'https://ga-us-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Atlanta, North America-US'
                speed_test 'https://il-us-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Chicago, North America-US'
                speed_test 'https://tx-us-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Dallas, North America-US'
                speed_test 'https://fl-us-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Miami, North America-US'
                speed_test 'https://nj-us-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, New Jersey, North America-US'
                speed_test 'https://tor-ca-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Toronto, North America-CA'
                speed_test 'https://sao-br-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Sao Paulo, South America-CA'
#    	speed_test 'http://speedtest.tokyo.linode.com/100MB-tokyo.bin' 'Linode, Tokyo, Asian-JP'
	speed_test 'http://speedtest.tokyo2.linode.com/100MB-tokyo2.bin' 'Linode, Tokyo2, Asian-JP'
	speed_test 'http://speedtest.singapore.linode.com/100MB-singapore.bin' 'Linode, Singapore, Asian-SG'
	speed_test 'http://speedtest.fremont.linode.com/100MB-fremont.bin' 'Linode, Fremont, CA'
	speed_test 'http://speedtest.newark.linode.com/100MB-newark.bin' 'Linode, Newark, NJ'
	speed_test 'http://speedtest.london.linode.com/100MB-london.bin' 'Linode, London, UK'
	speed_test 'http://speedtest.frankfurt.linode.com/100MB-frankfurt.bin' 'Linode, Frankfurt, DE'
	speed_test 'http://speedtest.tok02.softlayer.com/downloads/test100.zip' 'Softlayer, Tokyo, Asian-JP'
	speed_test 'http://speedtest.sng01.softlayer.com/downloads/test100.zip' 'Softlayer, Singapore, Asian-SG'
	speed_test 'http://speedtest.sng01.softlayer.com/downloads/test100.zip' 'Softlayer, Seoul, Asian-KR'
	speed_test 'http://speedtest.hkg02.softlayer.com/downloads/test100.zip' 'Softlayer, HongKong, Asian-CN'
	speed_test 'http://speedtest.dal13.softlayer.com/downloads/test100.zip' 'Softlayer, Dallas, TX'
#	speed_test 'http://speedtest.sea01.softlayer.com/downloads/test100.zip' 'Softlayer, Seattle, WA'
	speed_test 'http://speedtest.fra02.softlayer.com/downloads/test100.zip' 'Softlayer, Frankfurt, DE'
	speed_test 'http://speedtest.par01.softlayer.com/downloads/test100.zip' 'Softlayer, Paris, FR'
	speed_test 'http://mirror.hk.leaseweb.net/speedtest/100mb.bin' 'Leaseweb, HongKong, Asian-CN'
	speed_test 'http://mirror.sg.leaseweb.net/speedtest/100mb.bin' 'Leaseweb, Singapore, Asian-SG'
	speed_test 'http://mirror.wdc1.us.leaseweb.net/speedtest/100mb.bin' 'Leaseweb, Washington D.C., US'
	speed_test 'http://mirror.sfo12.us.leaseweb.net/speedtest/100mb.bin' 'Leaseweb, San Francisco, US'
	speed_test 'http://mirror.nl.leaseweb.net/speedtest/100mb.bin' 'Leaseweb, Netherlands, NL'
	speed_test 'http://proof.ovh.ca/files/100Mio.dat' 'OVH, Montreal, CA'
	speed_test 'http://tpdb.speed2.hinet.net/test_100m.zip' 'Hinet, Taiwan, Asian-TW'
	# next
}

speed

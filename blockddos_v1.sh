#!/bin/bash

# First, set up blocklists with iptables and ipset
# https://linux-audit.com/blocking-ip-addresses-in-linux-with-iptables/

# Then install netutils if you don't have it

# Modify these parameters 

port=18089
cutoff=10
timer=10


# Magic loops

while :
do

blocklist=$(netstat -anp |grep $port | sed 's/ \+ /\t/g' | cut -f 4 | cut -f 1 -d ":" | sort | uniq -c)

blocklist=($blocklist)
echo ${blocklist[@]}
echo "################"
echo ${#blocklist[@]}

# https://stackoverflow.com/questions/61081608/bash-remove-leading-and-trailing-spaces-in-array

shopt -s extglob                     # turn on extended glob
blocklist=( "${blocklist[@]/#+([[:blank:]])/}" ) # remove leading space/tab from each element
blocklist=( "${blocklist[@]/%+([[:blank:]])/}" ) # remove trailing space/tab from each element

echo ${blocklist[@]}

echo "starting LOOP"

for i in "${blocklist[@]}"
do
   : 
#	sleep 2
	echo $i
	echo "Checking ip: "$i
	# https://stackoverflow.com/questions/13777387/check-for-ip-validity
        if [[ $i =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
	echo "Great, this is an IP. That means $last_element must be the num_cnxns"
        num_cnxns=$last_element
	echo "this is num_cnxns" $num_cnxns
	if [[ "$num_cnxns" -gt "$cutoff" ]]; then
        echo "IP is blocked: "$i
        ipset add blacklist $i
	else
	echo "$i is a friendly remote node user"
	fi
	else
        echo "$i is not an ip address, must be num_cnxns"
	last_element=$i
	fi
done

echo "End of loop, sleeping"
echo "Now is echo $(date)"
echo "Total number of blocked IPs:"
sudo ipset list blacklist | wc -l
sleep $timer

done

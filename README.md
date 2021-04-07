# p2r2n_defender
Scripts to help protect nodes in the Public Remote Rpc Node Network (P2R2N) of monero

# Requirements
Must be run as root because it fiddles with ip blocking.
First, install netutils.
Then, get a blocklist setup in iptables
https://linux-audit.com/blocking-ip-addresses-in-linux-with-iptables/

Then, run in a screen session or whatever.

# parameters to modify

in header of file, there are currently 3 variables.  
port = change the port to your public rpc port  
cutoff = IP addresses with more RPC connections than this number will be blocked. I've used between 5 and 10.  
timer = wait time, in seconds, for script to loop.   

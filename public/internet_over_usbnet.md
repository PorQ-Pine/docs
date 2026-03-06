# Setting up Internet over USBNet on Quill OS

#### Disclaimer: I am no networking expert. Even if I do somewhat understand what they are doing, Gemini wrote these scripts for the most part. They work, though, at least on macOS + current Quill OS version. Use at your own risk.

- On the host connected to the Internet, create a script called `start_tunnel.sh` containing the following:
```bash
#!/bin/bash
# Configuration
PINENOTE_USER="nicolas" # Replace this with your username
PINENOTE_IP="192.168.3.2" # Change to your PineNote's IP
PROXY_PORT=1080

echo "Starting SOCKS5 tunnel on port $PROXY_PORT..."
ssh -v -R 1080 -f -N $PINENOTE_USER@$PINENOTE_IP

if [ $? -eq 0 ]; then
    echo "Tunnel active. Mac is now a proxy for the PineNote."
else
    echo "Failed to start tunnel."
fi
```
- On your PineNote:
  - Install `redsocks` via `sudo dnf install redsocks`
  - Modify the relevant part of `/etc/redsocks.conf` so that it looks like this:
  ```
  redsocks {
  	local_ip = 127.0.0.1;
  	local_port = 12345;
  	ip = 127.0.0.1;
  	port = 1080;
  	type = socks5;
  }
  ```
  - Restart `redsocks`: `sudo systemctl restart redsocks`.
  - Create the following script called `nftables.sh`:
  ```bash
    #!/bin/bash
    
    # 1. Clear existing rules to start fresh
    sudo nft flush ruleset
    
    # 2. Define Variables
    MAC_USB_IP="192.168.3.1"
    REDSOCKS_PORT="12345"
    
    # 3. Create a table and a chain for NAT output
    sudo nft add table ip nat
    sudo nft add chain ip nat output { type nat hook output priority filter \; }
    
    # 4. SAFETY: Do not proxy local traffic or traffic to the Mac
    sudo nft add rule ip nat output ip daddr 192.168.3.0/24 return
    sudo nft add rule ip nat output ip daddr 127.0.0.1 return
    
    # 5. REDIRECT: Send all other TCP traffic to Redsocks
    sudo nft add rule ip nat output ip protocol tcp redirect to :$REDSOCKS_PORT
    
    # 6. Routing
    # Check if the route exists before adding to avoid "File exists" errors
    sudo ip route replace default dev usb0 via $MAC_USB_IP
  ```
- Once all of this is done, run `start_tunnel.sh` on the host and `nftables.sh` on the PineNote. You should then be able to connect to the Internet about 30 or 40 seconds later.

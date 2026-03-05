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
  - Create the following script called `iptables.sh`:
  ```bash
  #!/bin/bash
  # 1. Reset everything
  sudo iptables -t nat -F
  
  # 3. SAFETY: Do not proxy traffic going to the Mac or the local network
  sudo iptables -t nat -A OUTPUT -d 192.168.3.0/24 -j RETURN
  sudo iptables -t nat -A OUTPUT -d 127.0.0.1 -j RETURN
  
  # 4. REDIRECT: Everything else goes to Redsocks
  sudo iptables -t nat -A OUTPUT -p tcp -j REDIRECT --to-ports 12345
  
  # 5. Add default route via usb0 interface
  sudo ip route add default dev usb0
  ```
- Once all of this is done, run `start_tunnel.sh` on the host and `iptables.sh` on the PineNote. You should then be able to connect to the Internet about 30 or 40 seconds later.

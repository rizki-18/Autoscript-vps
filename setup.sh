# ==========================================
# FIREWALL IPTABLES (OPTIMAL FOR INJECT)
# ==========================================
echo "Memulai konfigurasi Iptables..."

export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get install iptables iptables-persistent -y 
mkdir -p /etc/iptables

# 1. BERSIHKAN (FLUSH) RULE IPTABLES LAMA
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X

# 2. KOMUNIKASI INTERNAL VPS (LOOPBACK / LOCALHOST)
# Vital agar HAProxy, Golang WS, Xray, dan Dropbear tidak terhalang
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# 3. IZINKAN KONEKSI YANG SUDAH TERHUBUNG
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# 4. DROPPING PAKET CORRUPT / INVALID
iptables -A INPUT -m state --state INVALID -j DROP
iptables -A FORWARD -m state --state INVALID -j DROP

# 5. ATURAN ANTI-TORRENT (SAFE INJECT KUOTA)
# Menggunakan algoritma 'bm' yang valid pada iptables
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables -A FORWARD -m string --algo bm --string "get_peers" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce_peer" -j DROP
iptables -A FORWARD -m string --algo bm --string "find_node" -j DROP

# 6. REDIRECTION UDP CUSTOM
# Membelokkan traffic UDP ke 36712, KECUALI port yang di-exclude oleh config JSON
iptables -t nat -A PREROUTING -p udp -m multiport ! --dports 53,123,5300,7300 -j REDIRECT --to-ports 36712

# 7. BUKA PORT TCP & UDP UTAMA (INPUT RULES)
# Ping ICMP (Agar server merespons ping dengan baik)
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT

# OpenSSH / HAProxy Web
iptables -A INPUT -p tcp --dport 22 -j ACCEPT          # SSH Default
iptables -A INPUT -p tcp --dport 80 -j ACCEPT          # HAProxy HTTP / Nginx
iptables -A INPUT -p tcp --dport 443 -j ACCEPT         # HAProxy HTTPS / TLS

# Services UDP (Sesuai pengecualian JSON dan port utama)
iptables -A INPUT -p udp -m multiport --dports 53,123,5300,7300 -j ACCEPT
iptables -A INPUT -p udp --dport 36712 -j ACCEPT       # UDP Custom Engine

# 8. INTERNET SHARING (NAT MASQUERADE)
# Sangat penting agar traffic dari VPN/Tunnel bisa diteruskan ke internet
ETH_INTERFACE=$(ip route get 8.8.8.8 | awk -- '{printf $5}')
iptables -t nat -A POSTROUTING -o $ETH_INTERFACE -j MASQUERADE

# 9. SET DEFAULT POLICY FIREWALL
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# 10. SIMPAN PERMANEN
iptables-save > /etc/iptables/rules.v4

# Aktifkan via netfilter-persistent jika terinstall
if command -v netfilter-persistent &> /dev/null; then
    netfilter-persistent save
    netfilter-persistent reload
fi

echo "Konfigurasi Iptables berhasil diterapkan dan disimpan!"

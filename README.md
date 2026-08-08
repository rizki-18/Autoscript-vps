# 🚀 Autoscript Premium VPN - Xray & SSH
*Solusi Cepat Membangun Server VPN Berkualitas Tinggi*

**Powered by Rizki18_Project | Indonesia Pride 🇮🇩**

---

## 📌 Tentang Skrip Ini

**Autoscript-vps** adalah *auto-installer* modern yang dirancang untuk memasang seluruh kebutuhan server VPN (SSH, Xray, WebSocket, dll) hanya dengan **satu baris perintah**. Dibangun dengan mengutamakan performa, efisiensi RAM, dan keamanan maksimal.

---

## 🔰 Layanan & Protokol yang Didukung

Skrip ini mendukung penuh berbagai protokol *tunneling* modern yang terintegrasi secara mulus dalam sistem **Xray Core** dan **SSH**:

* 🛡️ **SSH & VPN**
  * SSH SSL / Stunnel
  * SSH WebSocket (WS)
* 🚀 **Xray Core**
  * **Vmess** : TLS, NTLS (Non-TLS), gRPC
  * **Vless** : TLS, NTLS (Non-TLS), gRPC
  * **Trojan** : TLS, NTLS (Non-TLS), gRPC
* 🎮 **Layanan Ekstra**
  * **UDP Custom** (Mendukung panggilan suara & game online)
  * **BadVPN**

---

## 🔌 Informasi Port (Publik / Pelanggan)

Berikut adalah daftar *port* standar yang akan otomatis dikonfigurasi dan siap digunakan oleh pelanggan Anda:

| Protokol / Layanan | Port Terbuka |
| :--- | :--- |
| **Xray TLS / HTTPS / SSL** | `443` |
| **SSH WebSocket / HTTP** | `80` |
| **UDP Custom** | `1 - 65535` |
| **BadVPN** | `7300` |

---


## 🖥️ Kompatibilitas Sistem Operasi

Skrip ini dikembangkan agar tahan banting dan kompatibel dengan OS Linux berikut:

* ✅ **Ubuntu** : Versi **20.04**, 22.04, 24.04 (atau lebih baru)
* ✅ **Debian** : Versi **10**, 11, 12 (atau lebih baru)

*(Arsitektur yang didukung: AMD64 / x86_64)*

---

## ⚠️ Persyaratan Wajib (Sebelum Instalasi)

Sebelum mengeksekusi skrip, pastikan Anda telah menyiapkan 3 hal berikut:

1. **Password Instalasi** 🔑 (Diberikan oleh pihak Developer).
2. **Email Aktif (Google/Gmail)** 📧 (Dibutuhkan untuk *generate* sertifikat SSL).
3. **Domain Aktif** 🌐 (Wajib sudah di-*pointing* ke IP VPS Anda dan menggunakan sistem Proxy/DNS dari **Cloudflare**).

---

## 🚀 Cara Instalasi

Login ke terminal VPS Anda sebagai pengguna **`root`**, lalu *copy-paste* perintah di bawah ini dan tekan `ENTER`:

```bash
apt-get update -y && apt-get install wget -y && wget -qO install.sh https://github.com/rizki-18/Autoscript-vps/raw/refs/heads/main/install.sh && chmod +x install.sh && ./install.sh
```
![Tampilan Menu Skrip](https://raw.githubusercontent.com/rizki-18/Autoscript-vps/main/Screenshot_20260808-193454.png)

---

## 📞 Kontak & Bantuan

Untuk dukungan teknis, pertanyaan, atau pemesanan skrip *custom*, silakan hubungi kontak resmi di bawah ini:

* 💬 **WhatsApp :** [Klik di sini](https://wa.me/6281994752984)
* ✈️ **Telegram :** [klik di sini](https://t.me/mrapandi)

---
**&copy; 2026 Rizki18_Project. All Rights Reserved.**

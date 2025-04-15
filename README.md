# Infralaunch 🚀

**InfraLaunch** is a self-hosted infrastructure automation tool that sets up DNS zones, reverse proxies, and Docker-hosted sites for multiple client domains — all in one command.

Inspired by platforms like Cloudflare, InfraLaunch gives you:

- Automated DNS zone + record creation (using PowerDNS + MariaDB)
- Reverse proxy setup with NGINX for each client domain
- Containerized static site hosting via Docker + NGINX
- Easy domain bootstrapping with one script

Unlike Cloudflare, InfraLaunch is fully self-hosted — giving you full control over your infrastructure.

---

## 🔧 Features

- Add any domain with `./add-client.sh yourdomain.com <internal-ip>`
- PowerDNS + MariaDB integration
- Auto-created A, NS, and WWW records
- Dynamic NGINX configuration per site
- Custom index.html creation
- Docker container management (runs/restarts automatically)

---
## Ideal For

- DevOps projects and portfolios
- Local self-hosted platforms
- Demonstrating infrastructure automation
- Learning DNS, Docker, NGINX, and automation scripting

---
## ⚙️ Prerequisites

- Ubuntu 22.04+ server (AWS EC2 works great)
- Docker & Docker Compose
- PowerDNS + MariaDB backend
- NGINX installed

---

## 📁 Project Structure

```
├── add-client.sh         # Main provisioning script
├── .env                  # DB credentials + host config
├── /var/www/             # Website content folders
├── /etc/nginx/sites-*    # Auto-managed NGINX configs
└── README.md             # You're here :)
```

---

## 🚀 Usage

1. Clone this repo:

```bash
git clone https://github.com/your-username/infralaunch.git
cd infralaunch
```

2. Fill in your DB info in `.env`:

```
PDNS_DB_USER=pdns
PDNS_DB_PASS=your_secure_password
PDNS_DB_NAME=powerdns
PDNS_DB_HOST=127.0.0.1
```

3. Add a client:

```bash
sudo ./add-client.sh domain.com 172.31.12.168
```

4. Set your domain registrar's NS records to:
```
ns1.yourdomain.com(ns1.raool.site)
ns2.yourdomain.com(ns2.raool.site)
```

---

## 🧠 Behind the Scenes

- Records inserted into PowerDNS's MariaDB tables
- Zones are created as MASTER
- DNS handled on port 53 (UDP + TCP)
- Docker container listens on a random exposed port
- NGINX proxies traffic to internal IP

---

## 🌍 DNS Validation

You can verify DNS using:

```bash
dig yourdomain.com +short
dig www.yourdomain.com +short
dig NS yourdomain.com +short
```

---

## 🧪 Coming Soon

- SSL via Let's Encrypt (auto certs!)
- Web UI for launching sites
- GitHub Action for CI

---

## 🛡 License

MIT License — free to use, fork, contribute.

---

## ✨ Credits

Made with ☕ by Raool. Inspired by simple DevOps.

---

## 💬 Feedback / PRs

Open to issues, ideas, and pull requests!

---

**Happy hosting 🚀**






















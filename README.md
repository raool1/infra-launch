# InfraLaunch

**InfraLaunch** is a self-hosted infrastructure automation tool that sets up DNS zones, reverse proxies, and Docker-hosted sites for multiple client domains — all in one command.

Inspired by platforms like Cloudflare, InfraLaunch gives you:

- Automated DNS zone + record creation (using PowerDNS + MariaDB)
- Reverse proxy setup with NGINX for each client domain
- Containerized static site hosting via Docker + NGINX
- Easy domain bootstrapping with one script

Unlike Cloudflare, InfraLaunch is fully self-hosted — giving you full control over your infrastructure.

## Key Features

- Add a new domain with one command:  
  `./add-client.sh domain.com <internal-ip>`
- Automatically configures PowerDNS for A/NS records
- Sets up NGINX reverse proxy routing
- Launches a Docker container with a welcome page
- Can scale to multiple client domains easily

## Ideal For

- DevOps projects and portfolios
- Local self-hosted platforms
- Demonstrating infrastructure automation
- Learning DNS, Docker, NGINX, and automation scripting

## Coming Soon / To-Do

- Automatic SSL (Let's Encrypt)
- Web UI for client/domain management
- Global CDN integrations (optional)



## Installation

### 1. Prerequisites

You'll need:

- An Ubuntu 22.04+ server (e.g., AWS EC2, DigitalOcean Droplet)
- Docker & Docker Compose installed
- NGINX installed (`sudo apt install nginx`)
- PowerDNS + MariaDB configured (see below)

> **Note**: PowerDNS must be installed with MySQL backend.  
> You can follow [this guide](https://doc.powerdns.com/authoritative/backend-mysql/) or use our PowerDNS setup script (coming soon).

---

### 2. Clone the Repo

```bash
git clone https://github.com/raool1/infra-launch.git
cd infra-launch

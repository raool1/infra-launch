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

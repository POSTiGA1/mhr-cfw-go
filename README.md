# MHR-CFW Go

[![GitHub](https://img.shields.io/badge/GitHub-ThisIsDara-blue?logo=github)](https://github.com/ThisIsDara/mhr-cfw-go)

## Disclaimer

`mhr-cfw-go` is provided for educational, testing, and research purposes only.

- **Provided without warranty:** This software is provided "AS IS", without express or implied warranty, including merchantability, fitness for a particular purpose, and non-infringement.
- **Limitation of liability:** The developers and contributors are not responsible for any direct, indirect, incidental, consequent, or other damages resulting from the use of this project or the inability to use it.
- **User responsibility:** Running this project outside controlled test environments may affect networks, accounts, proxies, certificates, or connected systems. You are solely responsible for installation, configuration, and use.
- **Legal compliance:** You are responsible for complying with all local, national, and international laws and regulations before using this software.
- **Google services compliance:** If you use Google Apps Script or other Google services with this project, you are responsible for complying with Google's Terms of Service, acceptable use rules, quotas, and platform policies. Misuse may lead to suspension or termination of your Google account or deployments.
- **License terms:** Use, copying, distribution, and modification of this software are governed by the repository license. Any use outside those terms is prohibited.

---

## How It Works

```
Client -> Local Proxy -> Google front -> Google Apps Script -> Target website
               |
               +-> shows www.google.com to the network DPI filter
```

The Go proxy runs locally on your machine and forwards traffic through Google's infrastructure.
The network only sees allowed domains like `www.google.com` while your actual traffic is hidden inside the relay request.

---

## How to Use

### 1 - Download and Build

```bash
git clone https://github.com/ThisIsDara/mhr-cfw-go.git
cd mhr-cfw-go
go build -o mhr-cfw-go.exe ./cmd/mhr-cfw
```

### 2 - Set Up Google Apps Script Relay

1. Open [Google Apps Script](https://script.google.com/) and sign in.
2. Click **New project**.
3. Open the [`Code.gs`](script/Code.gs) file from this project, **copy everything**, and paste into the editor.
4. Change the password on this line:
   ```javascript
   const AUTH_KEY = "your-secret-password-here";
   ```
5. Click **Deploy** → **New deployment**.
6. Choose **Web app** as the type.
7. Set:
   - **Execute as:** Me
   - **Who has access:** Anyone
8. Click **Deploy**.
9. **Copy the Deployment ID** (long random string).

### 3 - Configure

Edit `config.json`:

```json
{
  "auth_key": "your-secret-password-here",
  "script_id": "YOUR_DEPLOYMENT_ID"
}
```

### 4 - Run

```powershell
.\mhr-cfw-go.exe
```

The proxy will start on `127.0.0.1:8080`. Use [FoxyProxy](https://getfoxyproxy.org/) to route browser traffic through it.

### 5 - Install CA Certificate (for HTTPS interception)

From the menu, select **Install CA certificate** or run:

```powershell
.\mhr-cfw-go.exe --install-cert
```

---

## Command Line Options

| Option | Description |
| --- | --- |
| `--no-menu` | Run without TUI menu |
| `--port` | Override proxy port |
| `--host` | Override listen host |
| `--socks5-port` | Override SOCKS5 port |
| `--disable-socks5` | Disable SOCKS5 proxy |
| `--log-level` | Set log level (DEBUG, INFO, WARN, ERROR) |
| `--install-cert` | Install CA certificate |
| `--uninstall-cert` | Remove CA certificate |
| `--scan` | Scan Google IPs |
| `--setup` | Run setup wizard |
| `--version` | Show version |

---

## Features

- HTTP/HTTPS proxy with CONNECT tunnel
- SOCKS5 proxy
- Domain fronting via Google Apps Script
- MITM proxy with dynamic certificates
- HTTP/2 transport
- Interactive TUI menu
- LAN sharing support

---

## License

MIT
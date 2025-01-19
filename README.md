# Website IP Change Monitor

This script monitors the IP addresses of a specified website and sends an email notification if the IPs change. It is designed to prevent email flooding by ensuring that only one notification is sent per IP change, using a flag file to track if an email has already been sent.

## Features
- Monitors a website's IP address.
- Sends an email notification if the IP address changes.
- Prevents multiple email notifications by using a flag file.
- Logs IP changes and email notifications.

## Requirements
- Linux-based system with `mail` or `sendmail` installed.
- Access to `dig` to resolve the website's IP address.
- `cron` or other job scheduler for periodic execution.

## Configuration
1. Set the `RECIPIENT` variable to the email address that should receive the notifications.
2. Set the `WEBSITE` variable to the website you want to monitor.

Example:
```bash
RECIPIENT="your-email@example.com"
WEBSITE="example.com"
```

## Usage

Clone the repository to your local machine:
```bash
git clone https://github.com/your-username/website-ip-monitor.git
```

Edit the script to set the required configuration variables:
```bash
RECIPIENT="your-email@example.com"  # Email address to receive notifications
WEBSITE="example.com"               # Website you want to monitor
```

Make the script executable:
```bash
chmod +x monitor_ip_change.sh
```

Run the script manually:
```bash
./monitor_ip_change.sh
```
(Optional) Add the script to `cron` to run it periodically. For example, to run the script every 10 minutes:
```bash
crontab -e
```
# Add the following line to run the script every 10 minutes
```bash
*/10 * * * * /path/to/monitor_ip_change.sh
```
The script creates logs at `/tmp/website_ip_changes.log` to track IP changes and email notifications.

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

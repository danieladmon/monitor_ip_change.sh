#!/bin/bash

# Configuration
WEBSITE="example.com"
IP_FILE="/tmp/website_ip.txt"
LOG_FILE="/tmp/website_ip_changes.log"
EMAIL_SENT_FILE="/tmp/website_email_sent.flag"
RECIPIENT="your-email@example.com"
SUBJECT="Website IP Change Alert"

# Get current IPs
CURRENT_IPS=$(dig +short "$WEBSITE" | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$')

# Exit if no IPs are resolved
if [ -z "$CURRENT_IPS" ]; then
    echo "$(date) - Unable to resolve IPs for $WEBSITE" | tee -a "$LOG_FILE"
    exit 1
fi

# Read stored IPs
STORED_IPS=$(cat "$IP_FILE" 2>/dev/null || echo "")

# Check if any current IP matches stored IPs
if ! grep -qxFf <(echo "$CURRENT_IPS") <(echo "$STORED_IPS"); then
    echo "$(date) - IPs changed for $WEBSITE. New IPs: $CURRENT_IPS" | tee -a "$LOG_FILE"

    # Send email if not already sent
    if [ ! -f "$EMAIL_SENT_FILE" ]; then
        echo "The IPs for $WEBSITE have changed. New IPs: $CURRENT_IPS" | mail -s "$SUBJECT" "$RECIPIENT"
        touch "$EMAIL_SENT_FILE"
        echo "$(date) - Email notification sent to $RECIPIENT" >> "$LOG_FILE"
    fi

    # Update stored IPs
    echo "$CURRENT_IPS" > "$IP_FILE"
else
    echo "$(date) - IPs unchanged for $WEBSITE" >> "$LOG_FILE"
    [ -f "$EMAIL_SENT_FILE" ] && rm -f "$EMAIL_SENT_FILE"
fi

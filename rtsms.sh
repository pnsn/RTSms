#! /usr/bin/env bash
# A script using Twilio SMS API to send out text alerts to pagers and smartphones.

source /etc/environment         # simple NAME=VALUE pairs on separate lines
sender="$SENDER"                # env var
account_sid="$ACCOUNT_SID"      # env var
auth_token="$AUTH_TOKEN"        # env var

api_url="https://api.twilio.com/2010-04-01/Accounts/$account_sid/Messages.json"
contacts="./contacts.sms"; touch "$contacts"
log="./logfile.sms"; touch "$log"

message="PNSN TEST: two segment long body of text (243 chars + 6 byte header = 249) that was delivered in 2 consecutive SMS messages, then automatically rebuilt and concatenated by your smartphone Messenger app, and represented as a single SMS message."

<< MESSAGE_DESCRIPTION
A message segment is up to 153 characters long, if no backticks(``) or Unicode symbols were used.
A message segment is up to 67 characters long, if a backtick kind of quote or any Unicode symbol was used.
Some characters count as two(2) characters each:  ~  ^  \  |  / 
Smartphones can receive larger texts of up to 1600 characters long, split into segments.
Smartphone messaging software concatenates segments back and rebuilds into a single message. 
"+" (plus sign) gets replaced with a single whitespace: " "
"\" (backslash sign) becomes escaped by another backslash added: "\\"
"&" ampersand disappears and truncates the rest of the message.
US/Canada costs $0.0075 per 1 SMS/segment sent (+$0.0025/sms if to Verizon or +$0.005/sms to US Cellular, except if sent from a toll-free).
Twilio SMS API speed is currently 1 sms per second (default), or 3 sms per second if sent from a toll-free number.
MESSAGE_DESCRIPTION

echo -------------------------------- | tee -a "$log"
echo NEW TWILIO API SESSION INITIATED | tee -a "$log"
date | tee -a "$log"
echo | tee -a "$log"

sms() {
printf 'Sending SMS to %s ...\n' "$1"
curl -s -d "Body=$message" -d "From=$sender" -d "To=$1" "$api_url" -u "$account_sid:$auth_token" | xargs &>> "$log"
}

while read -r number; do
    if [[ "$number" ]]; then
    sms "$number"
    fi
done < <(sed 's/[^[:digit:]]//g; /^$/d' "$contacts")
echo | tee -a "$log"
echo SESSION COMPLETED "($(date))." | tee -a "$log"
echo >> "$log"

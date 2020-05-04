## RTSms
**A Bash shell script using Twilio SMS API to send out text alerts to pagers and smartphones.**

### Usage

1. Create a contact list file and fill with data: `$ vim contacts.sms` 
2. Add an exec file permission: `$ chmod +x rtsms.sh`
3. Run the script: `$ ./rtsms.sh`

### Message description

- A message segment is up to 153 characters long, if no backticks(``) or Unicode symbols were used.
- A message segment is up to 67 characters long, if a backtick kind of quote or any Unicode symbol was used.
- Some characters count as two(2) characters each:  ~  ^  \  |  / 
- Smartphones can receive larger texts of up to 1600 characters long, split into segments.
- Smartphone messaging software concatenates segments back and rebuilds into a single message. 
- "+" (plus sign) gets replaced with a single whitespace: " "
- "\" (backslash sign) becomes escaped by another backslash added: "\\"
- "&" ampersand disappears and truncates the rest of the message.

### Contact list

Twilio recommends iterating through numbers to queue the requests. Each new SMS message must be sent with a separate REST API request. To initiate messages to a list of recipients, you must make a request for each number to which you would like to send a message. RTSms script can parse contact lists with any phone number formats. It will convert the numbers to a simple long integer value format accepted by Twilio (e.g. 4155554345 or 14155554345), although Twilio itself converts common phone number formats to E.164 format, for example (415) 555-4345 would come through as '+14155554345'. By default, the contact list is expected in the script's working directory (created if not found).  

### Logging

Check for the logfile.sms in the script's working directory. API responses (including errors and message bodies as parsed by Twilio server) are requested and logged in JSON data format, one number per line, with the whole block representing a Session (the script runtime). Twilio server also supports other response formats, such as XML, CSV and HTTP.

### Pricing and speed

US/Canada costs $0.0075 per 1 SMS/segment sent (+$0.0025/sms if to Verizon or +$0.005/sms to US Cellular, except if sent from a toll-free).
Twilio SMS API speed is currently 1 sms per second (default), or 3 sms per second if sent from a toll-free number.

### Useful references

https://www.twilio.com/docs/glossary/what-sms-character-limit

https://www.twilio.com/docs/usage/troubleshooting/data-types

https://www.twilio.com/docs/usage/twilios-response

https://www.twilio.com/docs/iam/test-credentials

https://www.twilio.com/docs/sms/api



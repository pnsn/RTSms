## RTSms
**A Bash shell script using Twilio SMS API to send out text alerts to pagers and smartphones.**

### Usage

0. Ensure all the required environment variables are set (below)
1. Create a contact list file and fill with data: `$ vim contacts.sms` 
2. Add an exec file permission: `$ chmod +x rtsms.sh` (optional)
3. Run the script: `$ ./rtsms.sh` (or just `$ bash rtsms.sh`)

### The variables

At a minimum, you need to get your Twilio phone number (SENDER), ACCOUNT_SID and AUTH_TOKEN via Twilio control panel, and define all of them either in your shell environment, or the script itself, or any other file to source. Note that Twilio also provides test credentials for sending HTTP Post requests and logging responses without actual SMS being sent or incurring charges.

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

US/Canada costs $0.0075 per 1 SMS segment sent (+$0.0025/sms if to Verizon or +$0.005/sms to US Cellular, except if sent from a toll-free).
Twilio SMS API speed is currently 1 message segment per second (default), or 3 segments per second if sent from a toll-free number:
https://support.twilio.com/hc/en-us/articles/115002943027-Understanding-Twilio-Rate-Limits-and-Message-Queues
Max queue length is 14400 segments or 4 hours, and then they will automatically fail.

### Useful references

https://www.twilio.com/docs/glossary/what-is-gsm-7-character-encoding

https://www.twilio.com/blog/2017/03/what-the-heck-is-a-segment.html

https://www.twilio.com/docs/glossary/what-sms-character-limit

https://www.twilio.com/docs/usage/troubleshooting/data-types

https://www.twilio.com/docs/usage/twilios-response

https://www.twilio.com/docs/iam/test-credentials

https://www.twilio.com/docs/sms/api


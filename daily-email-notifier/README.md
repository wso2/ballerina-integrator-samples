# Daily Email Notifier

## Description

A scheduled task that sends a daily email update at 8 AM using the Gmail API. This sample demonstrates how to integrate
Ballerina with an external email service.

## Prerequisites

- Ensure that you have valid Gmail API credentials configured.
- Set up necessary OAuth2 authentication for the Gmail connector.
- Verify that the recipient’s email address is correct.

## Usage Instructions

1. Configure the required Gmail API credentials and ensure the `ballerinax/googleapis.gmail` connector is properly set up.
2. Set the `senderEmail`, `receiverEmail`, and `gmailUserId` values before running the program.
3. Run the Ballerina application to send an email update.
4. If you want to schedule the email to be sent daily at 8 AM, deploy this integration in **Devant** as a scheduled job.
   Once deployed, it will send the email every day at 8 AM.

## How It Works

- The application constructs an email message with a subject and body.
- It sends the email using the [Gmail connector](https://central.ballerina.io/ballerinax/googleapis.gmail/latest).
- If successful, it logs the email ID; otherwise, it logs an error message.

## Example Log Output

```
INFO  [ballerina] Sending email to: example@domain.com
INFO  [ballerina] Email sent successfully: Email ID = 12345xyz
```

# Defining whome we want to send the EMAIL

EMAIL="mrdevanshjindal@gmail.com" 
SUBJECT="Daily Disk Usage Report"

# Storing the report of disk into variable
# -h is used to read output in human readable format 
REPORT=$(df -h)

# This is the mall which we want to send to them 
EMAIL_BODY="Hello,
Here's the daily disk usage report of your VM machine:

$REPORT

Keep supporting..!
Best Regards,
Your Automated Monitoring System"

#Echo cmd used to give output the content of EMAIL_BODY
# Mail is cmd used to send emails
# -s is used to specify the Subject of email 
echo "$EMAIL_BODY" | mail -s "$SUBJECT" "$EMAIL"

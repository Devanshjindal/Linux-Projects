# Writing the script for Auto Updating

# this is path of the log file where the script will write the results
LOG_FILE="/var/log/auto_updates.log"
# initializes an empty variable that will later be set to either yum or dnf PACKAGE_MANAGER=""

# Using te function that takes one argument and writes it to the log file with time
Log_message() {
# assign the first argument passed to the function to a local variable
local message="$1"
# Appending the message to the log file with the current date and time.
echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" >> "$LOG_FILE"
}

# This function is used to check which package manager is available and uses it to install update 
check_and_install_updates() {

# This block checks if yum or dnf is available on the system and sets the packet_manager
# variable accordingly. if neither is found, its logs an error and exits the script.
# check if yum is available and set package variable accordingly
if command -v yum &> /dev/null; then
# command -v checks if the command exists
# &> /dev/null redirects the both standard output and standard error
PACKAGE_MANAGER="yum"
# if yum is not avial, check if dnf is available and set the variable accordingly 
elif command -v dnf &> /dev/null; then
PACKAGE_MANAGER="dnf"
# if neither yum nor dnf is found, send an error message and exit the script 
else
log_message "Error: Netther yum nor dnf package manager found."
exit 1
fl
# Indicating the start of the update process using the determined pacakge manager 
log_message "Starting Update process using $PACKAGE_MANAGER."

#This runs the update command and captures both standard output and standard error.
#if the command succeeds, it logs the output indicating success. if the command fails, it
# logs the output indicating failure
if output=$($PACKAGE_MANAGER update -y 2>&1); then
log_message "Update Successful, Updated packages: \n$output"
else
log_message "Update Failed, Error details :\n$output"
fl
}

# Defines the main function
main() {
# Logs a message indicating the start of the script 
log_message "Automated update script started."
# calling the function to perform the update process 
check_and_install_updates
# Logs a message indicating the completion of the script 
log_message "Automated update script completed."
# this calls the main function to start the script 
main

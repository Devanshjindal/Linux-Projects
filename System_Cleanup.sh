# Writing the script for removing the unwanted files, packages, temp files

# Here we made a file performance.log where we want to store the results 
# Here clean up activity will be recoreded 
LOG_FILE="/var/log/system_clean_up.log"

# This function is used to logs messages with timestamps
log_message() {
# Stores the first argument passed to the function in a local variable 
local message="$1"
# Appends the message with the current date and time to the log file. 
echo "$(date '+%Y-%m-%d %H:%M:%S") - $message" >> "$LOG_FILE"
}

# in this function we start to cleanup the temporary files

cleanup_temp_files() {

log_message "starting cleanup of temporary files." # Logs the start of temporary file
# rm cmd is used to delete the empty files and we use -rf to delete recurcively forcefully deletion 
rm -rf /tmp/* # Deletes all files and directories in /tmp
rm -rf /var/tmp/* # Delete all files and directories in /var/tmp
log_message "Completed cleanup of temporary files." # logs the completion of temp files

# Here we start to start cleaning the cache clearing process
clear_caches() {
# logs the start of cache clearing 
log_message "Starting cache clearing."
# checks if apt-get command is avaiable 
if command -v apt-get &> /dev/null; then
apt-get clean #clears the apt-get cache 
# checks if yum command is available 
elif command -v yum &> /dev/null; then
yum clean all #clears the yum cache
#checks if dnf command is available or not 
elif command -v dnf &> /dev/null; then 
dnf clean all # clearrs the dnf cache
fi
log_message "Completed cache clearing."
}

# this function used to delete unused package removal process.
remove_unused_packages() {
# check for the availiability of pacakge manager and remove unused package 
log_message "Starting removal of unused packages."
if command -v apt-get &> /dev/null; then
apt-get autoremove -y #Automatically removes packages that are no longer needed. 
elif command -v yum &> /dev/null; then
yum autoremove -y
# -y option stands for yes which automatically answer yes to any prompts or questions 
elif command -v dnf &> /dev/null; then
dnf autoremove -y
fi
log_message "Completed removal of unused packages."
# logs the completion of removed unwanted packages
}

# Logs the start and completion of the entire script execution
main() {
log_message "system cleanup and optimization script started."
cleanup_temp_files # calling the functions to clean the tmp files, caches and unused packages
clear_caches
remove_unused_packages
log_message "system cleanup and optimization script completed."
}

#Writing a script for monitoring the CPU, MEMORY and so on commonents

#here we made a file performance.log where we want to store the results 
# Here performance metrics will be logged
LOG_FILE="/var/log/performance.log"

# Using the function to perform the actions 
log_message() {
# The first argument passed to this function
local message="$1"
# Adding the current date and time by using the date cmd with the message to the log file
echo "$(date '+%Y-%m-%d %H:%M:S') - $message" >> "$LOG_FILE"
}

# Again we using another function to perform the task
get_cpu_usage() {
# Using the top cmd in batch mode for a single iteration and extract the CPU usage
# The grep cmd used to filter the result
# The awk cmd extracts the 2nd and 4th fields -> user and system CPU usage and sum them local
cpu_usage=$(top -bn1 | awk '/Cpu\(s\)/ {print $2 + $4}')
echo "${cpu_usage%.*}" # Return the output as an integer by removing the decimal part
}

get_memory_usage() {
#using the free cmd to display memory usage
#calculating the percentage
local memory_usage=$(free | awk '/Mem/ {print $3/$2 * 100.0}') 
echo "${memory_usage%.*}"
}

get_disk_to() {
# using the lostat cmd to display disk i/o statistics
local disk_to=$(tostat -d | awk 'NR>3 {sum+=$3+$4} END {print sum}') 
echo "${disk_to%.*}"
}

# Function to monitor and log performance metrics
monitor_performance() {
# get the current cpu usage, memory usage, and disk i/o 
local cpu_usage=$(get_cpu_usage
Local memory_usage=$(get_memory_usage)
local_disk_to=$(get_disk_io)

# log the performance metrics
# saving the output into message function
log_message "CPU Usage: $cpu_usage%, Memory Usage: $memory_usage%, Disk I/O: $disk_to KB/s"
}

# Main function to execute the monitoring process
main() {
# printing the message indicating that script is started
echo "Monitoring script started."
monitor_performance #calling the function to monitor and log performance metrics
# printing the message indicating that script is completed
echo "Monitoring Script completed."
}
# runing the main function
main

echo -e "$(date '+%Y-%m-%d %H:%M:S') Script executed successfully" >> /var/log/script.log

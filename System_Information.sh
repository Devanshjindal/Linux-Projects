# Printing the script for system information by using echo cmd 
# TASK-9 SYSTEM INFORMATION SCRIPT
echo "##########################################"
echo "######## System Information Script #######"
echo "##########################################" 
echo "" # used to make a empty line

# Printing the CPU Information by using lscpu cmd
echo "............ CPU INFORMATION ............."
echo ".........................................."
lscpu | grep -E 'Model name|Socket|Core|Thread|MHz|Cache|Vendor'
# grep command is used to search the items
# '' in colon we give some keywords to search and print
echo ""
echo "........................................."

# Printing the Memory Information by using mpstat cmd
echo "........... MEMORY INFORMATION .........."
echo "........................................."
mpstat
echo ""
echo "........................................."

# Printing the Disk Usage Information by using the df cmd
echo ".............. DISK USAGE ..............."
echo "........................................."
df -h # -h is used to read the output in human readable form 
echo ""
echo "........................................."

# Printing the Network Interfaces Information by using ip cmd 
echo "......Network Interface Information......"
echo "........................................."
for network_interface in $(ls /sys/class/net/); do
# using the for loop so that all interface will be printed
# using variable network_interface and searching in the file /sys/class/net/ 
echo "Interfaces: $network_interface"
#using the tp cmd to show detailed information 
ip addr show $network_interface
done 
echo ""
echo "........................................"

# Printing the Running processes by using the ps cmd
echo ".......... RUNNING PROCESSES ..........."
echo "........................................"
ps -o ptd,pptd,cmd,mem,%cpu

# using -o allows to print specific column as we gave pid, ppid etc echo ""
echo ""
echo "........................................"

#Script is completed
echo "................Thanks.................."

# Writing a script to create 100 users
echo "Creating the 100 users"
echo ""
# Using for loop for creating 100 users in one go rather than creating it manually 
for i in {1..100} # here i is variable and [1..100} represents 1, 2, 3, ..,100 counting 
do
# Make a variable as user
user="mycomusr$i" # making username with names mycomuse1, mycomusr2 and so on.

# using useradd command to add the user in vm
# -m will create home directory
# -d specifies the home dir path
# -s used to set the shell for user account
useradd -m -d /home/$user -s /bin/bash $user

# setting the password as username by using chpasswd cmd 
echo "$user:$user" | chpasswd

# Now setting up the password to expire every after 30 days
# chage cmd is used to change expirey, inactive, warning days 
# -M refers to the maximum numbers of days
chage M 30 $user

# Setting up the permissions of user account
# using cmd chmod to modify the permission
# 700 refers to read, write and execute permissions for owner 
chmod 700 /home/$user

# Setting the Group to each user account
# -a means appending the group to user
# -G specifies the group to which the user should be added 
usermod -aG wheel $user

# we can delete these users too
# if id "$user" &>/dev/null; then
# sudo userdel -r $user
# Completed with the Task now displaying the Name of User account 
done

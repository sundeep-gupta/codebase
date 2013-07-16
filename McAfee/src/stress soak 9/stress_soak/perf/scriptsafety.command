

countdown=0
for ((countdown = 14000 ; countdown != 1; countdown-- ))
do
     echo -e "\033[31m This script ensures machine reboot in case of a problem .system is being restarted in $countdown seconds"
     sleep 1
done
echo sanjeev
sudo reboot


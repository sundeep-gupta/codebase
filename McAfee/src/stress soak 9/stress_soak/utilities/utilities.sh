clear


sudo cat /dev/null
currentuser=$(whoami)

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "This script has utilities to make your life simpler "
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo ""
echo "Select the desire option from 1,2,3,4 to continue................"
echo""
echo "1. CleanUp system (Removes Crash reports, System Log files)"
echo "2. Uninstall Virex and VirusScan for Mac ( All Versions)"
echo "3. Uninstall NWA"
echo "4. Remove all Cron Jobs ( Current user and Root user)"
echo "5. Exit"
echo ""
echo -n "Please enter the required option and press ENTER key :   "
read response

case $response in

1)
echo ""
echo "You selected........CleanUp system..Option 1"
;;

2)
echo ""
echo "You selected........Uninstall Virex and VirusScan for Mac.. Option 2 "

;;

3)
echo ""
echo "You selected........Uninstall NWA..Option 3 "

;;

4)
echo ""
echo "You selected........Remove all Cron Jobs..Option 4"
;;

5)
echo ""
echo "You selected........Exit..Option 5"
;;

*)
echo "Invalid selection. Please reselect.........."

;;
esac


1) Disable all prompts for all Applications.
2) All configs are to be set in ssm_perf/Includes/PerfConfig.txt
3) Configure AppleMail & Microsoft Entourage in the network so mails can be sent/received.


Network latency related setup:

** Setup the configs in ssm_perf/Includes/PerfConfig.txt **
** Some of the scripts/steps need to be run individually currently. This will be automated soon and updated **

1) Specify "full" for package config if tests are being done for full package i.e AV+AS+FW+AP
2) For AppPro - Network latency related tests set Safari and Firefox brower download paths in browser preferences and specify the same in the config file.
3) For AppPro - Network latency related tests set default web page when browser opens to blank.
4) Disable "Warn before allowing an external application to send mail" option in Microsoft Entourage Preferences->Security.
5) Please make sure that no rules exist for Application Protection before starting the test for network latency.
6) Setup the keygen in such a way that the 2 mac machines involved in network related operations do not require password for scp as follows:
   a) user@homebox ~ $ ssh-keygen -t dsa
   b) user@homebox ~ $ scp -i /var/root/.ssh/id_dsa.pub user@'servername':/var/root/.ssh/authorized_keys.
   c) user@homebox ~ $ ssh 'servername' (or 'ipaddress') [# You should log in to the remote host without being asked for a password.]

7) There are 2 scripts : a) app_pro_1.command -- for doing scp of files and calculating the time
                         b) app_pro_2.command -- for doing http and ftp with browsers firefox and safari (excluding safari-ftp combination) and calculating the time taken for the operation.
8) Please add teh rules for scp, safari, firefox as intended with suitable access levels and run the above scripts
9) On running the above tests, a log file namely app_pro.log is created under Reports/. 
10) Once the log file is created run app_pro.pl present under Reports/ which results in creation of apppro_log_mod.
11) Run ./generate_report "|" apppro_log_mod to create the final report.
 

